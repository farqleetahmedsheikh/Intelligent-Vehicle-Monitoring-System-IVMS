from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status
from django.template.loader import render_to_string
from django.core.mail import EmailMultiAlternatives

from .models import Complaint
from .serializers import ComplaintSerializer


@api_view(['POST'])
def register_complaint(request):
    serializer = ComplaintSerializer(data=request.data)

    if serializer.is_valid():
        complaint = serializer.save()

        # Render email
        html_content = render_to_string("emails/complaint_registered.html", {
            "ownerName": complaint.ownerName,
            "complaintId": complaint.id,
            "plateNumber": complaint.plateNumber,
            "vehicleModel": complaint.vehicleModel,
            "vehicleColor": complaint.vehicleColor,
            "year": 2025,
        })

        email = EmailMultiAlternatives(
            subject="Your Vehicle Theft Complaint is Registered",
            body="",
            from_email="Trackvision240@gmail.com",
            to=[complaint.ownerEmail],
        )
        email.attach_alternative(html_content, "text/html")
        email.send()

        return Response(
            {"message": "Complaint registered successfully", "data": serializer.data},
            status=status.HTTP_201_CREATED
        )

    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

@api_view(['GET'])
def search_complaint(request):
    query = request.query_params.get('q')

    if not query:
        return Response({"error": "Search query 'q' is required"}, status=400)

    # Detect what user entered
    is_cnic = query.replace('-', '').isdigit() and len(query.replace('-', '')) in [13, 14]
    is_plate = any(char.isalpha() for char in query) and any(char.isdigit() for char in query)
    is_chassis = len(query) > 10 and query.isalnum()

    # Apply filters
    complaints = Complaint.objects.none()

    if is_cnic:
        complaints = Complaint.objects.filter(ownerCnic=query)

    elif is_plate:
        complaints = Complaint.objects.filter(plateNumber__iexact=query)

    elif is_chassis:
        complaints = Complaint.objects.filter(chassisNumber__iexact=query)

    else:
        # fallback: try name, email, phone, make, model
        complaints = Complaint.objects.filter(
            ownerName__icontains=query
        ) | Complaint.objects.filter(
            ownerEmail__icontains=query
        ) | Complaint.objects.filter(
            ownerPhone__icontains=query
        ) | Complaint.objects.filter(
            vehicleMake__icontains=query
        ) | Complaint.objects.filter(
            vehicleModel__icontains=query
        )

    if not complaints.exists():
        return Response({"message": "No records found"}, status=404)

    serializer = ComplaintSerializer(complaints, many=True)
    return Response(serializer.data, status=200)
