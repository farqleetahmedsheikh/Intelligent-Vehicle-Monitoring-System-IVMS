from vehicle_detection.models import VehicleDetection

def predict_route(plate):

    history = VehicleDetection.objects.filter(
        plateNumber=plate
    ).order_by("-detected_at")[:5]

    route = []

    for h in history:
        route.append({
            "lat": h.latitude,
            "lng": h.longitude
        })

    return route