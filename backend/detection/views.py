import tempfile
import os
import cv2

from rest_framework.views import APIView
from rest_framework.parsers import MultiPartParser, FormParser
from rest_framework.response import Response
from rest_framework import status
from django.core.mail import EmailMultiAlternatives
from django.template.loader import render_to_string
from django.conf import settings
from django.utils.timezone import now

from complaints.models import Complaint
from ai_module.plate_detector import detect_plate_and_read
from users.models import CustomUser


class DetectVehicleAPIView(APIView):
    
    def send_alert_email(self, complaint, plate, location):
        admin_emails = list(CustomUser.objects.filter(role="admin").values_list("email", flat=True))
        recipients = [complaint.ownerEmail] + admin_emails

        html_content = render_to_string(
            "email/vehicle_detected.html",
            {
                "ownerName": complaint.ownerName,
                "plateNumber": plate,
                "vehicleModel": complaint.vehicleModel,
                "vehicleColor": complaint.vehicleColor,
                "location": location,
                "time": now(),
                "year": now().year,
            }
        )

        email = EmailMultiAlternatives(
            subject="🚨 Stolen Vehicle Detected",
            body="Your stolen vehicle has been detected.",
            from_email=settings.DEFAULT_FROM_EMAIL,
            to=recipients,
        )

        email.attach_alternative(html_content, "text/html")
        email.send(fail_silently=False)
        
    parser_classes = (MultiPartParser, FormParser)

    def post(self, request):

        image = request.FILES.get("images")

        if not image:
            return Response(
                {"error": "Image required"},
                status=status.HTTP_400_BAD_REQUEST
            )

        # Save temporary image
        with tempfile.NamedTemporaryFile(delete=False, suffix=".jpg") as temp:
            for chunk in image.chunks():
                temp.write(chunk)

            temp_path = temp.name

        try:
            plate, crop = detect_plate_and_read(temp_path)

            if not plate:
                return Response({
                    "status": "no_plate_detected"
                })

            # Normalize plate
            plate = plate.replace(" ", "").replace("-", "").upper()

            # Check database
            complaint = Complaint.objects.filter(
                plateNumber__iexact=plate
            ).first()

            if complaint:

                # Optional debug save
                cv2.imwrite("detected_plate.jpg", crop)
               
                location = "Camera 1 - Parking Area"

                self.send_alert_email(complaint,plate,location)

                return Response({
                    "status": "stolen_vehicle_detected",
                    "plate": plate,
                    "complaint_id": complaint.id
                })

            return Response({
                "status": "vehicle_not_reported",
                "plate": plate
            })

        finally:
            if os.path.exists(temp_path):
                os.remove(temp_path)