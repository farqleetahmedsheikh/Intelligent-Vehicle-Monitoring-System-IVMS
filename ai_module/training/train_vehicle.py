from ultralytics import YOLO
import os

def train_all_experiments():

    # =========================
    # EXPERIMENT LIST
    # =========================
    exps = ["exp_60", "exp_70", "exp_80"]

    # Load model ONCE (faster + correct)
    model = YOLO("yolo11n.pt")

    for exp in exps:
        print(f"\n🚀 Training on {exp}...\n")

        data_yaml = f"datasets/{exp}/data.yaml"

        # =========================
        # CREATE data.yaml IF MISSING
        # IMPORTANT: use RELATIVE paths
        # =========================
        if not os.path.exists(data_yaml):
            with open(data_yaml, "w") as f:
                f.write("""train: images/train
val: images/val

nc: 3
names: ["car", "person", "bike"]
""")

        # =========================
        # TRAIN MODEL
        # =========================
        model.train(
            data=data_yaml,
            epochs=50,
            imgsz=640,
            batch=8,
            device="cpu",   # change to 0 if GPU available
            project="runs/vehicle",
            name=exp,
            exist_ok=True
        )

    print("\n🎉 All experiments completed!")

if __name__ == "__main__":
    train_all_experiments()