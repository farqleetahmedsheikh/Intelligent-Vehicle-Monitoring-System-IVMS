from rest_framework.decorators import api_view, parser_classes
from rest_framework.response import Response
from rest_framework import status
from django.template.loader import render_to_string
from django.core.mail import EmailMultiAlternatives
from rest_framework.parsers import MultiPartParser, FormParser
from django.core.paginator import Paginator, EmptyPage
from .models import Complaint
from .serializers import ComplaintSerializer
import logging

logger = logging.getLogger(__name__)

@api_view(['POST'])
@parser_classes([MultiPartParser, FormParser])
def register_complaint(request):
    serializer = ComplaintSerializer(data=request.data)

    if serializer.is_valid():
        complaint = serializer.save()

        try:
            html_content = render_to_string("email/complaint_registered.html", {
                "ownerName": complaint.ownerName,
                "complaintId": complaint.id,
                "plateNumber": complaint.plateNumber,
                "vehicleModel": complaint.vehicleModel,
                "vehicleColor": complaint.vehicleColor,
                "variant": complaint.vehicleVariant,
            })

            email = EmailMultiAlternatives(
                subject="Your Vehicle Theft Complaint is Registered",
                body="",
                from_email="Trackvision240@gmail.com",
                to=[complaint.ownerEmail],
            )
            email.attach_alternative(html_content, "text/html")
            email.send()

            email_status = "Email sent successfully"

        except Exception as e:
            logger.error(f"Failed to send complaint email: {e}")
            email_status = "Failed to send email notification"

        return Response(
            {
                "message": "Complaint registered successfully",
                "email_status": email_status,
                "data": serializer.data
            },
            status=status.HTTP_201_CREATED
        )

    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

@api_view(['GET'])
def search_complaint(request):
    query = request.query_params.get('q', '').strip()
    role = request.query_params.get('role')
    if(role == "user"):
        email = request.query_params.get('email')
    if not query:
        return Response({"error": "Search query 'q' is required"}, status=400)

    complaints = Complaint.objects.none()
    
    # Detect what user entered
    is_cnic = query.replace('-', '').isdigit() and len(query.replace('-', '')) in [13, 14]
    is_plate = any(c.isalpha() for c in query) and any(c.isdigit() for c in query)
    is_chassis = len(query) > 10 and query.isalnum()

    if is_cnic:
        complaints = Complaint.objects.filter(ownerCnic=query)
    elif is_plate:
        complaints = Complaint.objects.filter(plateNumber__iexact=query)
    elif is_chassis:
        complaints = Complaint.objects.filter(chassisNumber__iexact=query)
    else:
        complaints = Complaint.objects.filter(
            Q(ownerName__icontains=query) |
            Q(ownerEmail__icontains=query) |
            Q(ownerPhone__icontains=query) |
            Q(vehicleMake__icontains=query) |
            Q(vehicleModel__icontains=query)
        )

    # Restrict normal users
    
    if role != 'admin':
        complaints = complaints.filter(ownerEmail=email)

    serializer = ComplaintSerializer(complaints, many=True)
    return Response({"data": serializer.data, "status": 200})

@api_view(['GET'])
def complaint_list(request):
    userEmail = request.GET.get('email', None)
    page = int(request.GET.get('page', 1))
    limit = int(request.GET.get('limit', 10))

    # Use filter only if userEmail is non-empty string
    if userEmail:
        complaints_queryset = Complaint.objects.filter(ownerEmail=userEmail).order_by('-createdAt')
    else:
        # Optional: for admin only
        complaints_queryset = Complaint.objects.all().order_by('-createdAt')

    paginator = Paginator(complaints_queryset, limit)

    try:
        complaints_page = paginator.page(page)
    except EmptyPage:
        complaints_page = []

    serializer = ComplaintSerializer(complaints_page, many=True)
    
    print ("Returning complaints page:", page, "with limit:", limit, "Total complaints:", paginator.count)

    return Response({
        "total": paginator.count,
        "page": page,
        "limit": limit,
        "complaints": serializer.data
    })
    
@api_view(['GET'])
def get_complaint(request, complaint_id):
    try:
        complaint = Complaint.objects.get(id=complaint_id)
    except Complaint.DoesNotExist:
        return Response({"error": "Complaint not found"}, status=status.HTTP_404_NOT_FOUND)

    serializer = ComplaintSerializer(complaint)
    return Response(serializer.data, status=status.HTTP_200_OK)

@api_view(['GET'])
def get_all_complaints(request):
    complaints = Complaint.objects.all().order_by("-id")
    serializer = ComplaintSerializer(complaints, many=True)
    return Response(serializer.data)

@api_view(["PATCH"])
def update_complaint_status(request, id):
    try:
        complaint = Complaint.objects.get(id=id)
    except Complaint.DoesNotExist:
        return Response({"error": "Not found"}, status=404)

    status_value = request.data.get("status")
    complaint.status = status_value
    complaint.save()
    return Response({"success": True})
