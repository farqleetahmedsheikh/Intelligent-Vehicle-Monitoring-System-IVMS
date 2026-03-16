from ultralytics import YOLO
import easyocr
import cv2

vehicle_model = YOLO("models/yolov8n.pt")
plate_model = YOLO("models/license_plate.pt")

reader = easyocr.Reader(['en'])


def detect_plate(image):

    results = plate_model(image)

    plate_text = None

    for r in results:
        for box in r.boxes:
            x1,y1,x2,y2 = map(int, box.xyxy[0])

            crop = image[y1:y2, x1:x2]

            text = reader.readtext(crop, detail=0)

            if text:
                plate_text = text[0]
                break

    return plate_text