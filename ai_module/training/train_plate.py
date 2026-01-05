from ultralytics import YOLO

def train_plate():
    model = YOLO("yolov11n.pt")

    model.train(
        data="datasets/plates/data.yaml",
        epochs=50,
        imgsz=640,
        batch=8,
        device="cpu"
    )

if __name__ == "__main__":
    train_plate()
