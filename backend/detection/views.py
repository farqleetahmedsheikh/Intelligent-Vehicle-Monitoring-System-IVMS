from rest_framework.views import APIView
from rest_framework.response import Response
from django.core.files.base import ContentFile
import cv2

from .yolo.plate_detect import detect_plate_and_read
from complaints.models import Complaint
from alerts.models import Alert
from routes.models import RouteHistory
from alerts.email_service import send_alert_email
from routes.route_prediction import predict_routes

class DetectVehicleAPIView(APIView):
    def post(self, request):
        image = request.FILES.get("image")
        location = request.data.get("location", "Unknown")

        if not image:
            return Response({"error": "Image is required"}, status=400)

        temp_path = "/tmp/input.jpg"
        with open(temp_path, "wb+") as f:
            for chunk in image.chunks():
                f.write(chunk)

        plate, crop_img = detect_plate_and_read(temp_path)

        if not plate:
            return Response({"message": "No plate found"}, status=200)

        complaint = Complaint.objects.filter(plate_number__iexact=plate).first()

        if not complaint:
            return Response({"status": "not_reported", "plate": plate})

        # convert crop image to Django file
        _, buffer = cv2.imencode(".jpg", crop_img)
        image_file = ContentFile(buffer.tobytes(), name=f"{plate}.jpg")

        # save alert in database
        alert = Alert.objects.create(
            complaint=complaint,
            location=location,
            evidence_image=image_file
        )

        # save route history for ML
        RouteHistory.objects.create(
            plate_number=plate,
            location=location
        )

        # route prediction AI
        routes = predict_routes(plate, location)

        # send email alerts
        send_alert_email(complaint.user.email, plate, location)
        send_alert_email("admin@example.com", plate, location)

        return Response({
            "status": "match_found",
            "plate": plate,
            "complaint_id": complaint.id,
            "alert_id": alert.id,
            "routes": routes
        })
