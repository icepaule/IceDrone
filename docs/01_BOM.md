[← Docs index](README.md)

# 01 - Bill of Materials (BOM)

**Verification date:** 2026-09-02. Availability and prices are volatile; re-check before ordering.

Machine-readable version: [`bom/bom.csv`](../bom/bom.csv), reproduced in full below.

## Full parts list

| Qty | Category | Part | Specification | Preferred supplier | Verified status (2026-09-02) | Unit price (€) | URL / search note | Critical check |
|---:|---|---|---|---|---|---:|---|---|
| 1 | compute | Seeed XIAO ESP32-S3 Sense | 8MB PSRAM/8MB Flash, OV3660 | Botland | Available, 24h | 15.90 | [botland.de](https://botland.de/wifi-und-bt-module-esp32/22926-seeed-xiao-esp32-s3-sense-kamera-kit-mit-ov3660-wifi-bluetooth-seeedstudio-113991115.html) | Use Sense camera version |
| 1 | sensor | GY-91 MPU9250+BMP280 | 3.3V I2C | Amazon.de marketplace | Product result verified | 11.59 | Search: GY-91 MPU9250 BMP280 10DOF | Confirm MPU9250 not MPU6050 clone |
| 6 | propulsion | 8520 brushed motor | 8.5x20mm 3.7V, 1.0mm shaft | Amazon.de/LDARC | Variant availability changes | – | Search exact: 8520 coreless 1mm shaft | 1.0mm shaft mandatory |
| 2 | propulsion | 76mm propeller set | 2-blade, 1.0mm bore, 2 CW + 2 CCW | Electrapac | Exact geometry listed | – | [electrapac.com](https://www.electrapac.com/product/2-Pcs-76mm-Propeller-For-1020-8520-Coreless-motor) | Do not buy 5mm CineWhoop hub |
| 2 | power | EMAX 1S LiHV 650mAh | 3.8V nominal, 120C, PH2.0 | Hobbydrone.cz | In stock >20 when checked | 6.80 | [hobbydrone.cz](https://www.hobbydrone.cz/de/tinyhawk-1s-120c-hv-650mah-lipo/) | Use LiHV charger for 4.35V charge |
| 10 | electronics | AO3400A | N-MOSFET 30V SOT-23 | Reichelt | Exact product result | 0.18 | Search: Reichelt AO3400A | Pin orientation critical |
| 10 | electronics | SS14 | Schottky 1A 40V | Reichelt/other distributor | Commodity | – | – | One across each motor |
| 10 | electronics | 100R resistor | 0603/0805 | Reichelt/other distributor | Commodity | – | – | Series gate resistor |
| 10 | electronics | 100k resistor | 0603/0805 | Reichelt/other distributor | Commodity | – | – | Gate pulldown and battery divider |
| 2 | electronics | 470uF capacitor | low ESR, >=6.3V | Reichelt/other distributor | Commodity | – | – | Across VBAT near motor stage |
| 2 | electronics | 100uF capacitor | low ESR, >=6.3V | Reichelt/other distributor | Commodity | – | – | Near XIAO BAT input |
| 1 | power | PH2.0 pigtail | 20-22AWG | RC supplier | Commodity | – | – | Check polarity |
| 1 | mechanical | PETG filament | 1.75mm | Existing stock | Local | – | – | Frame |
| 1 | mechanical | TPU 95A filament | 1.75mm | Optional | Local | – | – | Camera cradle |

## Recommended sourcing strategy

I could not honestly verify a single German/EU supplier that currently carries **all** of the following with the exact required variants (especially 8520/1.0-mm motors and 76-mm/1.0-mm CW/CCW props). The lowest-risk purchase is therefore split into **core electronics** and **micro-drone propulsion**. Amazon.de can consolidate several generic components into one checkout, but exact marketplace sellers and shaft/connector variants change frequently.

### Preferred, quality-first purchase

| Qty | Part | Required specification | Verified source/status | Indicative price |
|---:|---|---|---|---:|
| 1 | Seeed XIAO ESP32-S3 Sense | 8 MB PSRAM, 8 MB flash, OV3660 current production | Botland, index SEE-22926, available / 24h when checked | €15.90 |
| 1 | GY-91 | MPU9250 + BMP280, 3.3 V I2C compatible | Amazon.de marketplace result verified by product search | ~€11.59 |
| 6 | 8520 brushed coreless motors | 8.5×20 mm, **1.0 mm shaft**, 3.7 V; buy 2 spares | Amazon.de marketplace / alternate LDARC 8520 listing; verify shaft before checkout | ~€15-25 total |
| 2 sets | 76 mm 2-blade props | **1.0 mm hole**, 2×CW + 2×CCW per set | Electrapac exact 76 mm/1.0 mm listing; buy spare set | varies |
| 2 | 1S LiHV/LiPo | 550-650 mAh, PH2.0, ≥30C; EMAX 650 mAh 120C acceptable | Hobbydrone.cz: 650 mAh PH2.0, >20 in stock when checked | €6.80 each |
| 10 | AO3400A | N-MOSFET, SOT-23, 30 V, logic-level | Reichelt exact AO3400A listing | €0.18 each |
| 10 | SS14 | Schottky 1 A/40 V or equivalent | standard electronics distributor | <€2 pack |
| 10 | 100 Ω resistors | 0603/0805 | standard electronics distributor | <€1 |
| 10 | 100 kΩ resistors | 0603/0805 | standard electronics distributor | <€1 |
| 2 | 470 µF low-ESR capacitor | ≥6.3 V | standard electronics distributor | ~€1 |
| 2 | 100 µF low-ESR capacitor | ≥6.3 V | standard electronics distributor | ~€1 |
| 1 | PH2.0 pigtail | 20-22 AWG preferred | RC/electronics supplier | ~€2 |
| 1 | thin silicone wire | 26-28 AWG signal, 22-24 AWG battery | electronics supplier | ~€5 |
| 1 | 1S LiHV-capable charger | must support 4.35 V if using LiHV | RC supplier | varies |
| 1 | 20-30 mm lightweight carrier/perfboard OR Open32Drone carrier PCB | four MOSFET stages | Open32Drone hardware link in upstream repo | varies |

### Consolidated Amazon.de option

The following were all surfaced in the same Amazon.de marketplace ecosystem during verification: XIAO ESP32-S3 Sense, GY-91, 8520 motors and AO3400A packs. This is the closest current single-checkout option, but verify **1.0-mm motor shaft**, prop bore and LiPo connector immediately before purchase. Marketplace ASINs are deliberately not frozen in this repository because sellers and variants change.

### Parts that matter most

**Motor shaft:** 1.0 mm. Open32Drone explicitly warns that 0.8-mm 8520 variants will not take the specified propellers.

**Propeller type:** use low-pitch 2-blade props intended for brushed 8520/1020 motors. Do not substitute current 76-mm CineWhoop props with 5-mm hubs; those are for brushless motors and are mechanically incompatible.

**Battery:** V1 is designed around 550-650 mAh. The included cradle concept assumes approximately 62×20×8 mm maximum outer dimensions. Measure the ordered pack before printing the final cradle.

**Camera:** current XIAO Sense production uses OV3660. Old OV2640 stock exists; the Seeed camera API remains compatible, but the current BOM targets OV3660.

## Estimated cost

A realistic V1 budget, excluding tools and radio transmitter, is approximately **€65-95** including spare motors/props and two batteries. The airframe itself uses only a few euros of filament.

## Optional V2 additions

- serial optical-flow + ToF module supported by Open32Drone
- SBUS receiver (e.g. FlySky A8S or compatible)
- dedicated RC transmitter
- BT2.0/A30 battery connector conversion for lower connector loss
- custom 30×30 mm carrier PCB after the prototype is validated

---
[← Docs index](README.md) | Next: [02 - Electrical →](02_ELECTRICAL.md)
