[← Docs index](README.md)

# 09 - Amazon.de Order List (DE)

Convenience shopping list with direct Amazon.de links for most of the [Bill of Materials](01_BOM.md), found via web search on 2026-09-02. This complements — it does not replace — `01_BOM.md`.

> **These are convenience links, not pinned/verified purchases.** Amazon.de marketplace listings, prices, stock and even the shipped variant behind a given listing change frequently, and automated verification of individual Amazon product pages is not possible (Amazon blocks it). Before ordering, open each link and check the "Verify" column yourself. Treat this file as a starting point for a manual order, and expect to re-check or re-search if it is more than a few weeks old.

| Part | Qty | Amazon.de link | Verify before ordering |
|---|---:|---|---|
| Seeed XIAO ESP32-S3 Sense | 1 | [Entwicklungsboard, index 113991115](https://www.amazon.de/Entwicklungsboards-Kits-ESP32S3-Embedded-113991115/dp/B0CRZ971M1) | Listing title says OV2640; the BOM targets current-production OV3660 (see `01_BOM.md`). Confirm the camera version with the seller before buying. |
| GY-91 MPU9250+BMP280 | 1 | [TECNOIOT GY-91](https://www.amazon.de/TECNOIOT-GY-91-Acceleration-Kompass-Sensor-Modul-Beschleunigung/dp/B07HMQZ7N9) | Confirm it is MPU9250, not an MPU6050 clone. |
| 8520 coreless motor, 1.0 mm shaft | 6 (4 + 2 spares) | [hobbypower 8520 + 75 mm CW/CCW props](https://www.amazon.de/hobbypower-Coreless-53000rpm-8-5x20mm-Propeller/dp/B076M7G24G) | **Shaft diameter is the critical check** — 0.8 mm variants exist and will not take the specified propellers. |
| 76 mm 2-blade props, 1.0 mm bore | 2 sets | not usefully available on Amazon.de → [Electrapac](https://www.electrapac.com/product/2-Pcs-76mm-Propeller-For-1020-8520-Coreless-motor) (per `01_BOM.md`) | No Amazon.de listing with the exact required bore was found. |
| 1S LiHV/LiPo 650 mAh, PH2.0 | 2 | [FancyWhoop 650 mAh 1S LiPo](https://www.amazon.de/FancyWhoop-650mAh-1S-LiPo-Akku/dp/B086HKNGG9) | Confirm C-rating ≥30C and PH2.0 polarity. |
| AO3400A N-MOSFET, SOT-23 | 10 | [Todiys, pack of 100](https://www.amazon.de/Todiys-A03400A-AO3400A-N-Kanal-Transistor/dp/B08RHJG79T) | Pin orientation is critical when soldering (see `05_BUILD_AND_TEST.md`). |
| SS14 Schottky diode | 10 | [Chanzon, pack of 100](https://www.amazon.de/Packung-100-SS14-Schottky-Barriere-Gleichrichterdioden-DO-214AC/dp/B079KJ46ZS) | — |
| 100 Ω + 100 kΩ resistors, 0603/0805 | 10 each | [ALMOCN 0603 assortment, 60 values](https://www.amazon.de/-/en/ALMOCN-Resistor-Tolerance-Resistors-Certified/dp/B095YMDH87) | One kit covers both values. |
| 470 µF + 100 µF capacitor, ≥6.3V | 2 each | [BEEYUIHF electrolytic assortment, 925 pcs](https://www.amazon.de/-/en/BEEYUIHF-Electrolytic-Assortment-1uF-1500uF-Capacitors/dp/B0B4JV89SH) | Pick pieces rated 16V/25V/50V — comfortably exceeds the ≥6.3V minimum. |
| PH2.0 pigtail (2-pin) | 1 | [JST-PH2.0 2P connector + 20 cm cable](https://www.amazon.de/Elektronischer-Schaltungsverschlussanschluss-JST-PH2-0-Connector-F%C3%84NNLICHER-50pair/dp/B09FX5SCS3) | Verify polarity against the battery with a multimeter before plugging in. |
| Silicone wire, 26 AWG | 1 | [Fermerry 26 AWG, 6 colors x 3 m](https://www.amazon.de/Verl%C3%A4ngerung-Adapterkabel-Solarstecker-Verl%C3%A4ngerungskabel-wasserdichtem/dp/B08N4ZVLD4) | Sufficient for both signal and motor leads at this current level. |
| 1S LiHV charger, 4.35 V, PH2.0 | 1 | [GTIWUNG 6-channel 3.8V/4.35V charger](https://www.amazon.de/GTIWUNG-Batterie-Ladeger%C3%A4t-JST-PH-Steckverbinder-T579/dp/B0BN3YLDTN) | Confirm the 4.35 V LiHV mode is selectable, not fixed at 4.2 V. |
| Carrier/perfboard | 1 | [QWORK 32-piece double-sided perfboard set](https://www.amazon.de/Doppelseitiges-PCB-Prototyp-Lochrasterplatine-Kompatibel-Projekten/dp/B0DRY97XBK) | Cut to the ~20-30 mm size needed. |

## Why these links are not pinned elsewhere in the docs

`01_BOM.md` and `SOURCES.md` deliberately avoid freezing marketplace ASINs, because Amazon.de sellers and variants change often (see "Verification policy" in `SOURCES.md`). This file is the exception made on request, as a dated, disposable shopping aid rather than an authoritative source — re-derive it (or re-run the searches) rather than trusting it long after 2026-09-02.

---
[← 08 - Troubleshooting](08_TROUBLESHOOTING.md) | [Docs index](README.md) | Next: [Sources →](SOURCES.md)
