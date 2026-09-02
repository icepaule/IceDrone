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

## ESP32 build breaks after library/core update

Return to the last recorded tested toolchain. Flight firmware should be treated like embedded production software: pin the framework and library versions and re-run the full validation plan after any update.
