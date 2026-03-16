import numpy as np

def detect_color(image):

    avg_color = np.mean(image, axis=(0,1))

    if avg_color[2] > 150:
        return "Red"

    if avg_color[1] > 150:
        return "Green"

    if avg_color[0] > 150:
        return "Blue"

    return "Unknown"