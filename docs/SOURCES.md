[← Docs index](README.md)

# Sources

Checked 2026-09-02.

## Core projects

- Open32Drone repository: https://github.com/npu-ius-lab/open32drone
- Open32Drone tutorial: https://github.com/npu-ius-lab/open32drone/blob/main/tutorial.md
- Open32Drone license: Apache-2.0
- Flix: https://github.com/okalachev/flix
- Flix user projects / ESP32-S3-CAM streaming: https://github.com/okalachev/flix/blob/master/docs/user.md
- ESP-FLY: https://github.com/Seeed-Projects/Co-Create_ESP-FLY

## Seeed documentation

- XIAO ESP32-S3 series: https://wiki.seeedstudio.com/xiao_esp32s3_getting_started/
- XIAO ESP32-S3 pin multiplexing: https://wiki.seeedstudio.com/xiao_esp32s3_pin_multiplexing/

Key facts verified from current documentation:

- XIAO Sense current camera is OV3660; OV2640 has been discontinued for current production.
- 8 MB PSRAM / 8 MB flash.
- board footprint approximately 21×17.8 mm; Sense stack about 15 mm high.
- camera uses GPIO10-18, 38-40, 47, 48 internally.
- Open32Drone uses GPIO4/3/6/5 for four 10 kHz motor PWM outputs and GPIO2/43 for I2C.
- current Open32Drone docs describe a 300 Hz flight-critical loop and optional low-priority QVGA MJPEG service.
- Open32Drone specifies 8520 1.0-mm-shaft motors and 76-mm props, with target takeoff mass 60-80 g.

## Purchase verification

- Botland XIAO ESP32-S3 Sense, index SEE-22926, listed at €15.90 and available/24 h when checked: https://botland.de/wifi-und-bt-module-esp32/22926-seeed-xiao-esp32-s3-sense-kamera-kit-mit-ov3660-wifi-bluetooth-seeedstudio-113991115.html
- Reichelt AO3400A product result: AO3400A, 30 V N-MOSFET SOT-23, around €0.18 at check time.
- Hobbydrone.cz EMAX 650 mAh 1S LiHV PH2.0, >20 in stock when checked: https://www.hobbydrone.cz/de/tinyhawk-1s-120c-hv-650mah-lipo/
- Electrapac 76 mm two-blade 1.0-mm-hole propellers: https://www.electrapac.com/product/2-Pcs-76mm-Propeller-For-1020-8520-Coreless-motor
- Amazon.de marketplace product search returned XIAO Sense, 8520 motors, GY-91 and AO3400A options, but marketplace seller/variant availability is not stable enough to pin as the sole source.

## Verification policy

A URL in this document records what was checked, not a guarantee of future availability. Before ordering, confirm the shaft diameter, connector, camera version, dimensions and stock state on the seller's current page.

---
[← 08 - Troubleshooting](08_TROUBLESHOOTING.md) | [Docs index](README.md)
