from django.db import models
from complaints.models import Complaint
class Detection(models.Model):
    complaint = models.ForeignKey(Complaint, on_delete=models.CASCADE, related_name="detections")

    # Mobile scanner info
    deviceId = models.CharField(max_length=100, null=True, blank=True)

    # Location
    locationText = models.CharField(max_length=255, null=True, blank=True)
    latitude = models.FloatField(null=True, blank=True)
    longitude = models.FloatField(null=True, blank=True)

    # Image captured by mobile camera
    detectedImage = models.ImageField(upload_to="detections/", null=True, blank=True)

    detectedAt = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Detection of {self.complaint.plateNumber}"
