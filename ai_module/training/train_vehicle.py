from ultralytics import YOLO

def train_vehicle():
    model = YOLO("yolo11n.pt")

    model.train(
        data="datasets/vehicles/data.yaml",
        epochs=50,
        imgsz=640,
        batch=8,
        device="cpu",   # change to 0 if GPU
        project="runs/vehicle",
        name="yolo11"
    )

if __name__ == "__main__":
    train_vehicle()
