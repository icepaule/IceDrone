#!/usr/bin/env python3
"""Create labeled IceDrone assembly and exploded-view documentation images."""

import argparse
import math
from pathlib import Path
from PIL import Image, ImageDraw, ImageFont

CANVAS_W = 1400
HEADER_H = 130


def font(size: int, bold: bool = False):
    name = "DejaVuSans-Bold.ttf" if bold else "DejaVuSans.ttf"
    candidates = [
        Path("/usr/share/fonts/truetype/dejavu") / name,
        Path("/usr/share/fonts/dejavu") / name,
    ]
    for p in candidates:
        if p.exists():
            return ImageFont.truetype(str(p), size=size)
    return ImageFont.load_default()


def arrow(draw, start, end, width=3, fill="black"):
    draw.line([start, end], fill=fill, width=width)
    angle = math.atan2(end[1] - start[1], end[0] - start[0])
    head = 14
    wing = math.pi / 7
    p1 = (end[0] - head * math.cos(angle - wing), end[1] - head * math.sin(angle - wing))
    p2 = (end[0] - head * math.cos(angle + wing), end[1] - head * math.sin(angle + wing))
    draw.polygon([end, p1, p2], fill=fill)


def callout(draw, box, number, line1, line2, target, anchor="right"):
    x1, y1, x2, y2 = box
    draw.rounded_rectangle(box, radius=12, fill="white", outline="black", width=2)
    cx, cy = x1 + 27, (y1 + y2) // 2
    draw.ellipse((cx - 18, cy - 18, cx + 18, cy + 18), fill="black")
    nfont = font(21, True)
    bbox = draw.textbbox((0, 0), str(number), font=nfont)
    draw.text(
        (cx - (bbox[2] - bbox[0]) / 2, cy - (bbox[3] - bbox[1]) / 2 - 2),
        str(number), fill="white", font=nfont,
    )
    draw.text((x1 + 52, y1 + 12), line1, fill="black", font=font(21))
    draw.text((x1 + 52, y1 + 43), line2, fill="black", font=font(21))
    if anchor == "right":
        start = (x2, cy)
    elif anchor == "left":
        start = (x1, cy)
    elif anchor == "bottom":
        start = ((x1 + x2) // 2, y2)
    else:
        start = ((x1 + x2) // 2, y1)
    arrow(draw, start, target)


def make_canvas(raw_path, title, subtitle, bg=None):
    raw = Image.open(raw_path).convert("RGB")
    if raw.width != CANVAS_W:
        ratio = CANVAS_W / raw.width
        raw = raw.resize((CANVAS_W, round(raw.height * ratio)), Image.Resampling.LANCZOS)
    canvas = Image.new("RGB", (CANVAS_W, HEADER_H + raw.height), bg or "white")
    canvas.paste(raw, (0, HEADER_H))
    d = ImageDraw.Draw(canvas)
    d.text((28, 18), title, fill="black", font=font(29, True))
    d.text((28, 64), subtitle, fill="black", font=font(21))
    return canvas, d


def make_assembled(raw_path, out_path):
    canvas, d = make_canvas(
        raw_path,
        "IceDrone Airframe V2 – bestücktes Komplettmuster",
        "Gedruckte STL-Teile plus vereinfachte Mockups von Akku, 8520-Motoren, Elektronik, GY-91 und XIAO-Kamera.",
    )
    callout(d, (34, 835, 415, 916), 1, "frame_v2.stl", "Hauptrahmen + 4 Motorbecher", (555, 760), "right")
    callout(d, (38, 974, 415, 1054), 2, "battery_sled_650_v2.stl", "Akkuhalter unter dem Rahmen", (582, 835), "right")
    callout(d, (970, 816, 1268, 896), 3, "electronics_deck_v2.stl", "Elektronik-Trägerplatte", (772, 653), "left")
    callout(d, (980, 600, 1288, 680), 4, "imu_gy91_saddle.stl", "Halter für die GY-91 IMU", (711, 602), "left")
    callout(d, (850, 216, 1225, 296), 5, "xiao_camera_mount_15deg.stl", "Halter für XIAO + Kamera", (670, 454), "left")
    callout(d, (45, 220, 310, 301), 6, "flight_cage_v2.stl", "leichter Schutzkäfig", (535, 518), "right")
    callout(d, (982, 978, 1315, 1058), 7, "m2_spacers_5mm_set4.stl", "4 Abstandshalter", (711, 738), "left")
    canvas.save(out_path)


def make_exploded(raw_path, out_path):
    canvas, d = make_canvas(
        raw_path,
        "IceDrone Airframe V2 – Explosionsdarstellung",
        "Von unten nach oben: Akku → Rahmen → Spacer → Elektronikdeck → Sensor/Kamera → Schutzkäfig.",
    )
    callout(d, (40, 895, 343, 975), 1, "battery_sled_650_v2.stl", "Akkuwanne", (663, 934), "right")
    callout(d, (40, 719, 347, 798), 2, "frame_v2.stl", "Rahmen + Motorbecher", (665, 776), "right")
    callout(d, (953, 748, 1288, 828), 3, "m2_spacers_5mm_set4.stl", "4 Abstandshalter", (719, 722), "left")
    callout(d, (953, 604, 1255, 686), 4, "electronics_deck_v2.stl", "Elektronikdeck", (776, 628), "left")
    callout(d, (953, 467, 1228, 548), 5, "imu_gy91_saddle.stl", "GY-91 Halter", (720, 544), "left")
    callout(d, (40, 423, 411, 503), 6, "xiao_camera_mount_15deg.stl", "Kamera/XIAO-Halter", (651, 542), "right")
    callout(d, (40, 216, 280, 297), 7, "flight_cage_v2.stl", "Schutzkäfig", (692, 410), "right")
    canvas.save(out_path)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--assembled", required=True)
    ap.add_argument("--exploded", required=True)
    ap.add_argument("--outdir", required=True)
    args = ap.parse_args()
    out = Path(args.outdir)
    out.mkdir(parents=True, exist_ok=True)
    make_assembled(args.assembled, out / "complete_assembled_labeled.png")
    make_exploded(args.exploded, out / "exploded_labeled.png")


if __name__ == "__main__":
    main()
