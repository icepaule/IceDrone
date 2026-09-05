# IceDrone Airframe V2

This directory contains the modular V2 printable airframe for the IceDrone project. The V1 CAD remains available one directory above; V2 is an optional, more complete mechanical stack with dedicated holders for the battery, XIAO ESP32-S3 Sense camera board, GY-91 IMU and electronics carrier.

![Airframe V2 assembly preview](renders/assembly_preview_v2.webp)

## Design basis

- 123 mm Quad-X diagonal motor-center wheelbase
- motor centers at ±43.49 mm X/Y
- 8520 brushed coreless motors, nominal 8.5 mm diameter / 1.0 mm shaft
- 75/76 mm propellers (not included here)
- shared 30 × 30 mm M2 mechanical stack
- 1S 550–650 mAh battery, nominal envelope up to about 62 × 20 × 8 mm
- Seeed Studio XIAO ESP32-S3 Sense with forward-facing camera mount
- GY-91 IMU close to the geometric center
- intended for an Anycubic Kobra S1 with a 0.4 mm nozzle

> **Measure before final flight printing.** Marketplace GY-91 boards and 1S batteries vary in size. The key dimensions are parameters in `scad/icedrone_v2_lib.scad`.

## Part preview and purpose

| Preview | OpenSCAD | STL | Purpose |
|---|---|---|---|
| ![Frame](renders/frame_v2.webp) | [`frame_v2.scad`](scad/frame_v2.scad) | [`frame_v2.stl`](stl/frame_v2.stl) | Main 123 mm Quad-X load-bearing frame with four 8520 motor cups and the central 30 × 30 mm stack. |
| ![Electronics deck](renders/electronics_deck_v2.webp) | [`electronics_deck_v2.scad`](scad/electronics_deck_v2.scad) | [`electronics_deck_v2.stl`](stl/electronics_deck_v2.stl) | Upper carrier for the MOSFET/motor stage or a small 20–30 mm perfboard/PCB. |
| ![XIAO camera mount](renders/xiao_camera_mount_15deg.webp) | [`xiao_camera_mount_15deg.scad`](scad/xiao_camera_mount_15deg.scad) | [`xiao_camera_mount_15deg.stl`](stl/xiao_camera_mount_15deg.stl) | Forward XIAO ESP32-S3 Sense holder with approximately 15° downward camera attitude and open cooling. |
| ![GY-91 saddle](renders/imu_gy91_saddle.webp) | [`imu_gy91_saddle.scad`](scad/imu_gy91_saddle.scad) | [`imu_gy91_saddle.stl`](stl/imu_gy91_saddle.stl) | Centered IMU saddle; TPU 95A is preferred for mild vibration decoupling. |
| ![Battery sled](renders/battery_sled_650_v2.webp) | [`battery_sled_650_v2.scad`](scad/battery_sled_650_v2.scad) | [`battery_sled_650_v2.stl`](stl/battery_sled_650_v2.stl) | Sliding lower battery cradle for roughly 550–650 mAh 1S packs and longitudinal CG adjustment. |
| ![Flight cage](renders/flight_cage_v2.webp) | [`flight_cage_v2.scad`](scad/flight_cage_v2.scad) | [`flight_cage_v2.stl`](stl/flight_cage_v2.stl) | Lightweight recommended flight protection over the electronics stack. |
| ![Canopy](renders/canopy_v2.webp) | [`canopy_v2.scad`](scad/canopy_v2.scad) | [`canopy_v2.stl`](stl/canopy_v2.stl) | More closed, heavier alternative canopy for increased mechanical protection. |
| ![M2 spacers](renders/m2_spacers_5mm_set4.webp) | [`m2_spacers_5mm_set4.scad`](scad/m2_spacers_5mm_set4.scad) | [`m2_spacers_5mm_set4.stl`](stl/m2_spacers_5mm_set4.stl) | Four 5 mm M2 spacers used between the main frame and electronics deck. |
| ![Prop guard](renders/prop_guard_corner_v2.webp) | [`prop_guard_corner_v2.scad`](scad/prop_guard_corner_v2.scad) | [`prop_guard_corner_v2.stl`](stl/prop_guard_corner_v2.stl) | Optional single-corner propeller guard for low-energy indoor tests; print four if used. |
| ![Motor cup test](renders/motor_cup_test_v2.webp) | [`motor_cup_test_v2.scad`](scad/motor_cup_test_v2.scad) | [`motor_cup_test_v2.stl`](stl/motor_cup_test_v2.stl) | Five 8520 motor press-fit samples: 8.55 / 8.60 / 8.65 / 8.70 / 8.75 mm. Print this before the full frame. |

The library file [`icedrone_v2_lib.scad`](scad/icedrone_v2_lib.scad) contains the shared parametric geometry. [`assembly_preview_v2.scad`](scad/assembly_preview_v2.scad) is a non-printable visualization scene used to generate the assembly image above.

## Recommended flight stack

From bottom to top:

1. `battery_sled_650_v2.stl`
2. `frame_v2.stl`
3. four `m2_spacers_5mm_set4.stl`
4. `electronics_deck_v2.stl`
5. `flight_cage_v2.stl` **or** `canopy_v2.stl`

The XIAO camera mount is installed toward the front of the electronics deck. The GY-91 should remain as close as practical to the geometric center and aligned with the frame axes.

## Anycubic Kobra S1 print guidance

| Part | Material | Layer | Walls | Infill | Support |
|---|---|---:|---:|---:|---|
| Frame | PETG | 0.16–0.20 mm | 4 | 100% | none |
| Electronics deck | PETG | 0.16–0.20 mm | 3–4 | 60–100% | none |
| XIAO mount | PETG or TPU 95A | 0.16–0.20 mm | 3 | 50–100% PETG / 25–40% TPU | normally none |
| IMU saddle | TPU 95A preferred | 0.20 mm | 3 | 20–35% | none |
| Battery sled | PETG or TPU | 0.16–0.20 mm | 3 | 50–100% | none |
| Flight cage | PETG | 0.16 mm | 3 | 100% | build-plate/tree support only for top bridges |
| Canopy | PETG | 0.16–0.20 mm | 3 | 60–100% | print roof-down; support only if slicer requires it |

For the main frame, use the proven PETG profile rather than maximum print speed. Arm layer adhesion and motor-cup dimensional accuracy matter more than surface finish.

## Motor cup calibration

Print `stl/motor_cup_test_v2.stl` first and try the actual Amazon 8520 motors. Choose the smallest cup that accepts the motor with a firm press fit without deforming the motor can or cracking the cup. Then set `motor_id` in `scad/icedrone_v2_lib.scad` to that value and re-render `frame_v2.scad` before the final flight print.

## Approximate printed mass

Theoretical PETG mass from the STL volumes is approximately:

- frame: 13.4 g
- electronics deck: 3.0 g
- four spacers: 0.5 g
- IMU saddle: ~0.8–0.9 g
- XIAO camera mount: 1.7 g
- battery sled: 3.1 g
- flight cage: 3.1 g

Recommended V2 printed flight stack: roughly **25.6 g** before motors, electronics, battery and propellers. The closed canopy raises the printed stack to roughly **28.2 g**.

## Validation files

- [`PARTS_MANIFEST.csv`](PARTS_MANIFEST.csv) — part list and role
- [`STL_VALIDATION.csv`](STL_VALIDATION.csv) — mesh validation results

The individual flight STL exports were checked as closed meshes. The spacer set and motor-cup test intentionally contain multiple disconnected bodies because they place several printable pieces in a single STL.

## Safety

Perform all electrical, motor-order, motor-direction, IMU-orientation and failsafe tests **without propellers installed**. Fit propellers only after the prop-off checks pass. For first powered propeller tests use eye protection, restrain the airframe and keep hands and loose objects out of the propeller plane.
