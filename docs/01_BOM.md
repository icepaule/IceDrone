[← Docs index](README.md)

# 01 - Bill of Materials (BOM)

**Current electrical revision:** IceDrone V3.4  
**Updated:** 2026-09-18

Machine-readable hardware version: [`bom/bom.csv`](../bom/bom.csv).  
Dedicated PCB-reflow tooling/consumables: [`bom/reflow_bom.csv`](../bom/reflow_bom.csv).

> The older V1 sourcing list contained SS14 motor flyback diodes, 6.3 V bulk capacitors and a direct XIAO battery-input concept. Those values are **obsolete for V3.4**. Use the V3.4 requirements below.

## Core V3.4 hardware

| Qty | Category | Part | V3.4 requirement | Critical check |
|---:|---|---|---|---|
| 1 | compute | Seeed XIAO ESP32-S3 Sense | Sense camera version | external 5 V supply path; not raw LiHV |
| 1 | sensor | GY-91 MPU9250+BMP280 | 3.3 V I2C | verify actual IMU variant |
| 1 | sensor | VL6180X breakout | photographed 7-pin module | pin order VIN,2V8,GND,GPIO,SHDN,SCL,SDA |
| 1 | actuator | FH-1502 gimbal/servo | PWM | GPIO42; PDM microphone unavailable |
| 4 + spares | propulsion | 8520 brushed motor | 8.5×20 mm, 3.7 V, 1.0 mm shaft | shaft size mandatory |
| 1 set + spares | propulsion | 75–76 mm propellers | 1.0 mm bore, matched CW/CCW | verify bore and rotation |
| 1–2 | power | 1S LiHV battery | 3.8 V nominal, max 4.35 V | LiHV-capable charger |
| 1 | power | 1S→5 V boost | ≥0.7 A continuous, ≥1 A transient recommended | XIAO supply path |
| 4 | electronics | AO3400A | N-MOSFET, SOT-23 | pin orientation critical |
| 4 | electronics | **SS34-class Schottky** | **≥3 A** | flyback; cathode/band to VBAT |
| 1 | electronics | D5 Schottky | ≥1 A, e.g. SS14/1N5819W class | cathode to XIAO 5V |
| 4 | electronics | 100 Ω | gate series resistor | one per MOSFET |
| 6 | electronics | 100 kΩ | 4 pulldowns + 2 ADC divider | correct values |
| 1 | electronics | **470 µF / 10 V low-ESR** | C1 | polarity |
| 1 | electronics | **100 µF / 10 V low-ESR** | C2 | polarity |
| 5 | electronics | 100 nF ceramic | C3 + 4 motor-terminal caps | motor caps directly at motor |
| 1 | power | BT2.0 pigtail | 20–22 AWG preferred | polarity |
| 4 | power | JST-XH/equivalent 2-pin motor connector | current-capable | no Dupont for motor current |
| 1 | prototype | 70×30 mm perfboard | 2.54 mm pitch | V3.4 coordinate system |

## PCB first-article / reflow BOM

The custom **70×30 mm PCB and stencil are now physically available**. The dedicated assembly list is [`bom/reflow_bom.csv`](../bom/reflow_bom.csv) and includes:

- YIHUA YH-853AAA preheater/hot-air station;
- V3.4 stainless stencil;
- Sn42Bi58 low-temperature solder paste, 138 °C eutectic;
- Kapton tape for the stencil hinge / thermocouple;
- same-thickness FR4/old-PCB shims for an oversized stencil;
- squeegee, ESD tweezers and magnification;
- 99% IPA + lint-free wipes;
- optional but strongly recommended K-type thermocouple;
- no-clean flux and fine desoldering braid for rework.

See [11 - PCB Reflow Sn42Bi58](11_REFLOW_SN42BI58_DE.md) before applying paste.

## AO3400A

The V3.4 motor stage uses AO3400A because it has low RDS(on) specified at low gate voltage. For the SOT-23 package use the manufacturer's pinout:

- pin 1 = Gate
- pin 2 = Source
- pin 3 = Drain

For a perfboard prototype use a SOT-23 adapter or very short dead-bug leads.

## Power components

### D1-D4

Motor flyback diodes are **SS34-class ≥3 A Schottky** parts in V3.4. Prefer a **3 A / 40 V SMA (DO-214AC)** device such as SS34 or B340A-class. The earlier SS14/1 A choice is **not suitable for D1-D4** in V3.4.

The previously considered Amazon listing **“Chanzon SS14, 1 A / 40 V, SMA (DO-214AC)”** is currently unavailable and, independently of availability, is no longer the correct motor-flyback choice for this revision. SS14 remains electrically acceptable only for the lower-current **D5** isolation position, provided its footprint matches.

### C1 / C2

- C1: 470 µF / 10 V low-ESR
- C2: 100 µF / 10 V low-ESR

10 V parts provide more margin against brush-motor transients than the old 6.3 V entries.

### D5 and boost converter

Raw 1S LiHV can reach 4.35 V. V3.4 therefore feeds the XIAO through:

`VBAT → 1S→5V boost → D5 Schottky → XIAO 5V`

Do not connect raw LiHV directly to XIAO 5V/BAT in this hardware revision.

## Connectors and wire

Use Dupont/breadboard jumpers only for low-current signals/modules:

- XIAO signal lines
- GY-91
- VL6180X
- gimbal signal
- boost control/sense wiring

Battery and motor current must use suitable wire and connectors such as BT2.0/JST-XH or equivalent.

## Perfboard prototype

The temporary prototype uses a **70×30 mm** perfboard. See:

- [02 - Electrical](02_ELECTRICAL.md)
- [05 - Build and Test](05_BUILD_AND_TEST.md)
- [10 - Perfboard V3.4 soldering](10_PERFBOARD_V34_SOLDERING_DE.md)

The custom manufactured PCB is intended to replace the perfboard after first-article validation.

## Sourcing note

`09_AMAZON_ORDER_LIST_DE.md` is a dated marketplace sourcing snapshot. Electrical requirements in this BOM and in `02_ELECTRICAL.md` take precedence if the shopping list contains an older value.

---
[← Docs index](README.md) | Next: [02 - Electrical →](02_ELECTRICAL.md)
