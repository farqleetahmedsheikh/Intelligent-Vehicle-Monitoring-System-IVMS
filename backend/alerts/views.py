from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status

from .models import Alert
from .serializers import AlertSerializer


# Get all alerts for a user
@api_view(['GET'])
def get_user_alerts(request):
    email = request.query_params.get("email")

    if not email:
        return Response({"error": "Email is required"}, status=400)

    alerts = Alert.objects.filter(
        detection__complaint__ownerEmail=email
    ).order_by("-sentAt")

    serializer = AlertSerializer(alerts, many=True)
    return Response(serializer.data, status=200)



# Mark alert as read
@api_view(['POST'])
def mark_alert_read(request, alert_id):
    try:
        alert = Alert.objects.get(id=alert_id)
    except Alert.DoesNotExist:
        return Response({"error": "Alert not found"}, status=404)

    alert.isRead = True
    alert.save()

    return Response({"message": "Alert marked as read"}, status=200)



# Get single alert details
@api_view(['GET'])
def get_alert_details(request, alert_id):
    try:
        alert = Alert.objects.get(id=alert_id)
    except Alert.DoesNotExist:
        return Response({"error": "Alert not found"}, status=404)

    serializer = AlertSerializer(alert)
    return Response(serializer.data, status=200)
