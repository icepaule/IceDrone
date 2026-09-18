# IceDrone Documentation

IceDrone is a small, 3D-printable brushed quadcopter built around the **Seeed Studio XIAO ESP32-S3 Sense**, **GY-91 IMU**, VL6180X ToF sensor, 8520 motors and the current **Airframe V2** mechanical stack.

![Airframe V2 assembly](assets/airframe_v2_assembly.png)

This documentation belongs to [github.com/icepaule/IceDrone](https://github.com/icepaule/IceDrone) and is also published at **[icepaule.github.io/IceDrone](https://icepaule.github.io/IceDrone/)**.

## Table of contents

| # | Chapter | Covers |
|---:|---|---|
| 01 | [Bill of Materials](01_BOM.md) | Current V3.4 parts and electrical requirements |
| 02 | [Electrical](02_ELECTRICAL.md) | V3.4 power architecture, motor stages, pin map, sensors |
| 03 | [Mechanical](03_MECHANICAL.md) | Airframe V2, printable parts, STL/SCAD, Kobra S1 settings, CG |
| 04 | [Firmware](04_FIRMWARE.md) | Open32Drone strategy, build settings, video/MAVLink design rules |
| 05 | [Build and Test](05_BUILD_AND_TEST.md) | Step-by-step assembly and bring-up |
| 06 | [First Flight](06_FIRST_FLIGHT.md) | Test environment, hop/hover phases, acceptance criteria |
| 07 | [Safety and Legal (DE/EU)](07_SAFETY_AND_LEGAL_DE.md) | Workshop safety and UAS legal notes |
| 08 | [Troubleshooting](08_TROUBLESHOOTING.md) | Common faults and causes |
| 09 | [Amazon.de Order List (DE)](09_AMAZON_ORDER_LIST_DE.md) | Dated marketplace shopping aid |
| 10 | [Perfboard V3.4 soldering (DE)](10_PERFBOARD_V34_SOLDERING_DE.md) | Hole-by-hole solder map, SMD practice, multimeter gates |
| 11 | [PCB-Reflow Sn42Bi58 (DE)](11_REFLOW_SN42BI58_DE.md) | Stencil, paste printing, YIHUA YH-853AAA profile, inspection |
| — | [Reflow Quick Card](REFLOW_QUICK_CARD_DE.md) | Condensed workbench checklist |
| — | [Sources](SOURCES.md) | Upstream projects and references |

## Current project status

| Area | Status |
|---|---|
| Electrical revision | **V3.4 HW-VERIFIED is authoritative**; V3.2/V3.3 are obsolete for soldering |
| Perfboard prototype | 70×30 mm V3.4 layout and detailed solder guide available |
| Custom PCB | **70×30 mm PCB and stencil received**; manual first-article assembly/reflow procedure documented |
| Reflow process | Sn42Bi58 low-temperature workflow for YIHUA YH-853AAA documented; separate `bom/reflow_bom.csv` available |
| Bill of materials | Updated for SS34-class motor flyback, 10 V bulk capacitors and regulated XIAO 5 V supply |
| Mechanical | **Airframe V2 current**; parametric OpenSCAD + STL + previews in `cad/airframe_v2/` |
| Propeller CAD | Standard and experimental toroidal models in `cad/propellers/` |
| Bench-test firmware | Available in `firmware/bench_test/`; V3.4 motor map uses GPIO4/44/6/5 |
| Camera Wi-Fi diagnostic | `firmware/camera_wifi_test/` streams MJPEG over the existing Wi-Fi LAN |
| Flight-critical firmware | Tracks upstream Open32Drone; motor mapping/rotation, IMU calibration and battery calibration still require full hardware bring-up |

## V3.4 electrical highlights

- M1 GPIO4/D3
- M2 **GPIO44/D7**
- M3 GPIO6/D5
- M4 GPIO5/D4
- I2C SDA GPIO2/D1, SCL GPIO43/D6; firmware must call `Wire.begin(2, 43)`
- D1-D4 = SS34-class ≥3 A Schottky
- C1 = 470 µF / 10 V low-ESR
- C2 = 100 µF / 10 V low-ESR
- raw LiHV is not connected directly to XIAO 5V/BAT; use 1S→5 V boost + D5
- photographed VL6180X order: VIN, 2V8, GND, GPIO, SHDN, SCL, SDA

## Related files

- [`../hardware/perfboard_v34_netlist.csv`](../hardware/perfboard_v34_netlist.csv) — authoritative perfboard connections
- [`../hardware/perfboard_v34_pin_matrix.csv`](../hardware/perfboard_v34_pin_matrix.csv) — V3.4 external pin map
- [`assets/perfboard_v34_solder_side.svg`](assets/perfboard_v34_solder_side.svg) — physically mirrored rear-view solder map
- [`../hardware/pinmap.csv`](../hardware/pinmap.csv) — XIAO/GPIO mapping
- [`../hardware/motor_stage_netlist.csv`](../hardware/motor_stage_netlist.csv) — motor/power component netlist
- [`../bom/reflow_bom.csv`](../bom/reflow_bom.csv) — tools/consumables for stencil + Sn42Bi58 reflow
- [`assets/stencil_setup_v34.svg`](assets/stencil_setup_v34.svg) — oversized-stencil setup
- [`assets/reflow_profile_sn42bi58.svg`](assets/reflow_profile_sn42bi58.svg) — low-temperature profile reference
- [`assets/reflow_real_stencil_fixture_v34.jpg`](assets/reflow_real_stencil_fixture_v34.jpg) — real stencil/clamping setup
- [`assets/reflow_real_yihua_setup_v34.jpg`](assets/reflow_real_yihua_setup_v34.jpg) — real YIHUA setup / mechanical fit reference
- [`../firmware/bench_test/`](../firmware/bench_test/) — pre-flight bench firmware
- [`../cad/airframe_v2/`](../cad/airframe_v2/) — current airframe CAD
- [`../LICENSE`](../LICENSE), [`../NOTICE`](../NOTICE) — licensing
