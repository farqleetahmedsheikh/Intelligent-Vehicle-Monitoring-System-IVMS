from ultralytics import YOLO
import cv2
import easyocr

model = YOLO("detection/yolo/yolo_weights/yolov11n.pt")  
reader = easyocr.Reader(['en'])

def detect_plate_and_read(image_path):
    results = model(image_path)
    detections = results[0].boxes

    plate_crop = None

    for box in detections:
        cls = int(box.cls[0])
        if cls == 0:  # class 0 → Number Plate (you must train for this)
            x1, y1, x2, y2 = map(int, box.xyxy[0])
            img = cv2.imread(image_path)
            plate_crop = img[y1:y2, x1:x2]
            break

    if plate_crop is None:
        return None, None
    
    # OCR to extract number
    text = reader.readtext(plate_crop, detail=0)
    plate_number = text[0] if text else None

    return plate_number, plate_crop
