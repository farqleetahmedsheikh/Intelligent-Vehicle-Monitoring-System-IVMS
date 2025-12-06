from django.db.models.signals import post_save
from django.dispatch import receiver
from .models import Alert
from detection.models import Detection
from django.core.mail import EmailMultiAlternatives
from django.template.loader import render_to_string


@receiver(post_save, sender=Detection)
def create_alert_when_detected(sender, instance, created, **kwargs):
    if not created:
        return

    complaint = instance.complaint

    # Create alert message
    message = f"Your stolen vehicle with plate {complaint.plateNumber} was detected at {instance.locationDetected}."

    # Create alert object
    alert = Alert.objects.create(
        detection=instance,
        alertMessage=message,
        alertImage=instance.detectedImage  # reuse detection image
    )

    # Send email to user
    html_content = render_to_string("emails/vehicle_detected_alert.html", {
        "ownerName": complaint.ownerName,
        "plate": complaint.plateNumber,
        "location": instance.locationDetected,
        "time": instance.detectedAt,
    })

    email = EmailMultiAlternatives(
        subject="⚠ Vehicle Detection Alert",
        body="",
        from_email="trackvision240@gmail.com",
        to=[complaint.ownerEmail],
    )
    email.attach_alternative(html_content, "text/html")
    email.send()
