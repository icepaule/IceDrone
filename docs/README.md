# IceDrone Documentation

IceDrone is a small, 3D-printable brushed quadcopter built around the **Seeed Studio XIAO ESP32-S3 Sense**, **GY-91 IMU**, 8520 motors and the current **Airframe V2** mechanical stack.

![Airframe V2 assembly](assets/airframe_v2_assembly.png)

This documentation belongs to [github.com/icepaule/IceDrone](https://github.com/icepaule/IceDrone) and is also published at **[icepaule.github.io/IceDrone](https://icepaule.github.io/IceDrone/)**.

## Table of contents

| # | Chapter | Covers |
|---:|---|---|
| 01 | [Bill of Materials](01_BOM.md) | Parts list, sourcing notes, estimated cost |
| 02 | [Electrical](02_ELECTRICAL.md) | Power architecture, motor driver channels, pin map, grounding |
| 03 | [Mechanical](03_MECHANICAL.md) | Airframe V2, printable parts, STL/SCAD, Kobra S1 settings, CG |
| 04 | [Firmware](04_FIRMWARE.md) | Open32Drone strategy, build settings, video/MAVLink design rules |
| 05 | [Build and Test](05_BUILD_AND_TEST.md) | Step-by-step assembly and bring-up |
| 06 | [First Flight](06_FIRST_FLIGHT.md) | Test environment, hop/hover phases, acceptance criteria |
| 07 | [Safety and Legal (DE/EU)](07_SAFETY_AND_LEGAL_DE.md) | Workshop safety and UAS legal notes |
| 08 | [Troubleshooting](08_TROUBLESHOOTING.md) | Common faults and causes |
| 09 | [Amazon.de Order List (DE)](09_AMAZON_ORDER_LIST_DE.md) | Dated marketplace shopping aid |
| — | [Sources](SOURCES.md) | Upstream projects and references |

## Current project status

| Area | Status |
|---|---|
| Bill of materials | Available; verify actual delivered variants |
| Electrical | Pin map, netlist and wiring documented |
| Mechanical | **Airframe V2 current**; parametric OpenSCAD + STL + previews in `cad/airframe_v2/` |
| Propeller CAD | Standard and experimental toroidal models in `cad/propellers/` |
| Bench-test firmware | Available in `firmware/bench_test/` |
| Flight-critical firmware | Tracks upstream Open32Drone; see [04 - Firmware](04_FIRMWARE.md) |

## Related files

- [`../README.md`](../README.md) — project overview with visual previews
- [`../cad/airframe_v2/`](../cad/airframe_v2/) — current airframe SCAD/STL/renders
- [`../cad/propellers/`](../cad/propellers/) — replacement/test propeller CAD
- [`../bom/bom.csv`](../bom/bom.csv), [`../hardware/`](../hardware/) — machine-readable BOM and wiring data
- [`../firmware/bench_test/`](../firmware/bench_test/) — pre-flight bench firmware
- [`../LICENSE`](../LICENSE), [`../NOTICE`](../NOTICE) — licensing
