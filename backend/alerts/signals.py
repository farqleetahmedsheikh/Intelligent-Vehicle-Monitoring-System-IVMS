from django.db.models.signals import post_save
from django.dispatch import receiver
from .models import Alert
from detection.models import Detection
from django.core.mail import EmailMultiAlternatives
from django.template.loader import render_to_string
from channels.layers import get_channel_layer
from asgiref.sync import async_to_sync

@receiver(post_save, sender=Detection)
def create_alert_when_detected(sender, instance, created, **kwargs):
    if not created:
        return

    complaint = instance.complaint

    message = f"Your stolen vehicle with plate {complaint.plateNumber} was detected at {instance.locationDetected}."

    alert = Alert.objects.create(
        detection=instance,
        alertMessage=message,
        alertImage=instance.detectedImage
    )

    # SEND REAL-TIME ALERT
    channel_layer = get_channel_layer()

    alert_data = {
        "id": alert.id,
        "alertType": alert.alertType,
        "alertMessage": alert.alertMessage,
        "alertImage": str(alert.alertImage.url) if alert.alertImage else None,
        "sentAt": str(alert.sentAt),
    }

    # SEND TO USER
    async_to_sync(channel_layer.group_send)(
        f"alerts_{complaint.ownerEmail}",
        {
            "type": "send_alert",
            "data": alert_data
        }
    )

    # SEND TO ADMINS
    async_to_sync(channel_layer.group_send)(
        "alerts_admin",
        {
            "type": "send_alert",
            "data": alert_data
        }
    )

    # Email code stays same...


    # Send email to user
    html_content = render_to_string("emails/vehicle_detected_alert.html", {
        "ownerName": complaint.ownerName,
        "plate": complaint.plateNumber,
        "location": instance.locationDetected,
        "time": instance.detectedAt,
    })

    email = EmailMultiAlternatives(
        subject="Vehicle Detection Alert",
        body="",
        from_email="trackvision240@gmail.com",
        to=[complaint.ownerEmail],
    )
    email.attach_alternative(html_content, "text/html")
    email.send()
