import tempfile
import os
import cv2

from rest_framework.views import APIView
from rest_framework.parsers import MultiPartParser, FormParser
from rest_framework.response import Response
from rest_framework import status

from complaints.models import Complaint
from ai_module.plate_detector import detect_plate_and_read


class DetectVehicleAPIView(APIView):
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