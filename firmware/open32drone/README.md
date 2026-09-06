# Open32Drone integration

`vendor/open32drone` is a git submodule pointing at the upstream
[Open32Drone](https://github.com/npu-ius-lab/open32drone) repository. Do not edit
files inside the submodule directly — apply `v1.patch` on top of a clean
checkout instead, so upstream updates (`git submodule update --remote`) stay a
clean rebase target.

## What `v1.patch` changes

Applies the two "Local V1 choices" from `docs/04_FIRMWARE.md` that differ from
upstream's own defaults:

- `CAMERA_JPEG_QUALITY`: 10 → 18
- `OPTICAL_FLOW_ENABLED`: 1 → 0 (disabled for V1)

Everything else in that policy list (MAVLink port 14550, camera enabled,
QVGA, one viewer maximum, SBUS disabled, battery divider 2.0) already matches
upstream's defaults and needs no patch.

## Build and flash

```bash
# from the repo root, once:
git submodule update --init vendor/open32drone

cd vendor/open32drone
git apply ../../firmware/open32drone/v1.patch
cd software

arduino-cli core install esp32:esp32@3.3.6 \
  --additional-urls https://espressif.github.io/arduino-esp32/package_esp32_index.json
arduino-cli lib install "FlixPeriph@1.10.4" "MAVLink@2.0.25"

arduino-cli compile --clean \
  --fqbn 'esp32:esp32:XIAO_ESP32S3:PSRAM=opi,PartitionScheme=default_8MB,FlashMode=dio' \
  --output-dir /tmp/open32drone-build firmware

arduino-cli upload -p /dev/ttyACM0 \
  --fqbn 'esp32:esp32:XIAO_ESP32S3:PSRAM=opi,PartitionScheme=default_8MB,FlashMode=dio' \
  --input-dir /tmp/open32drone-build

# afterwards, restore the clean submodule checkout:
cd ../../..
git -C vendor/open32drone checkout -- .
```

## Verified 2026-09-06 (USB-only smoke test, submodule at `a49c037a`)

No IMU, motors, or battery wired — camera and Wi-Fi hardware only, propellers
off. Boot log confirmed:

- `Camera profile: QVGA quality 18, 10 FPS` — patch applied correctly.
- `softAP started: yes (IP 192.168.4.1)`, `Camera stream: http://192.168.4.1/stream`.
- `MAVLink UDP: bind OK local 14550 initial peer 192.168.4.255:14550`.
- `IMU: Error: 1` / `IMU initialization failed` — expected, no IMU wired yet
  (GY-91 arrives ~2026-09-16/21).
- No optical-flow setup attempted (`OPTICAL_FLOW_ENABLED=0` took effect).
- `Initializing complete`, then the CLI banner — firmware runs its full
  300 Hz loop without an IMU or optical flow present; nothing hangs or
  crash-loops on the missing sensors.

This only proves the firmware boots and its Wi-Fi/camera/MAVLink transport
work on this board. It is not a flight readiness check — Stages E through J
in `docs/05_BUILD_AND_TEST.md` (IMU orientation, motor mapping/rotation,
battery calibration, pre-prop checklist) still apply once the IMU and motor
hardware are installed.
