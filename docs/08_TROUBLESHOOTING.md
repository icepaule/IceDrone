[← Docs index](README.md)

# 08 - Troubleshooting

## XIAO resets when motors start

Likely causes:

1. battery voltage sag;
2. insufficient bulk capacitance;
3. long/thin battery wiring;
4. motor noise coupling into the XIAO supply;
5. weak/aged LiPo.

Actions: inspect VBAT with an oscilloscope if available, add/relocate bulk capacitor, shorten wiring, test with a known-good high-C battery, and reduce motor duty during diagnosis.

## Camera works on USB but fails on battery

Measure battery rail during capture. The camera/Wi-Fi load produces substantial transient current. Check antenna, PSRAM settings and power integrity. Current Seeed documentation lists roughly 110 mA typical Wi-Fi-active consumption for the Sense expansion and much higher short peaks in camera operation.

## One motor starts at boot

Immediately disconnect power. Check AO3400 pin orientation, solder bridges and missing gate pulldown. Never troubleshoot this with a prop fitted.

## Craft flips instantly

Do not tune PID. Check, in order:

1. motor numbering;
2. prop location CW/CCW;
3. motor rotation direction;
4. IMU axis orientation;
5. mixer configuration.

## Strong vibration / jello

- replace bent/damaged prop;
- check motor shaft runout;
- make sure the motor is tightly retained;
- use TPU camera cradle;
- verify frame arms are not cracked;
- try another motor if one has worn bearings/bushings.

## Wi-Fi control becomes poor when streaming

- lock video to QVGA;
- one viewer only;
- lower camera frame rate/JPEG quality;
- keep control/telemetry UDP traffic prioritized;
- use the supplied U.FL antenna with clear orientation;
- for a later V2, consider independent RC/SBUS so flight control is not dependent on the video WLAN link.

## Camera initializes but every captured frame is NULL

`esp_camera_init()` returns `ESP_OK` (the sensor answers on SCCB/I2C), but `esp_camera_fb_get()` reliably returns `NULL` afterward.

Observed on a real XIAO Sense unit at the default 20 MHz XCLK. Two independent fixes, both worth trying:

1. Lower `xclk_freq_hz` to 10 MHz and discard one warm-up frame right after init (see `firmware/bench_test/camera.cpp` and `firmware/camera_wifi_test/main.cpp`) — this alone made capture reliable on the affected unit.
2. If frames are still intermittently `NULL` after the XCLK fix, suspect a marginal FPC ribbon-cable seat on the Sense camera module rather than a firmware issue. Re-seating or replacing the camera module resolved a case where roughly 1 in 10–20 frames still failed even at 10 MHz.

`CAMERA_GRAB_WHEN_EMPTY` instead of `CAMERA_GRAB_LATEST` also avoids returning a buffer that a slow consumer is still holding, but did not by itself fix the NULL-frame issue described here.

## ESP32 build breaks after library/core update

Return to the last recorded tested toolchain. Flight firmware should be treated like embedded production software: pin the framework and library versions and re-run the full validation plan after any update.

---
[← 07 - Safety and Legal](07_SAFETY_AND_LEGAL_DE.md) | [Docs index](README.md) | Next: [09 - Amazon.de Order List →](09_AMAZON_ORDER_LIST_DE.md)
