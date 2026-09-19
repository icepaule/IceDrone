[← Docs index](README.md)

# 09 - Amazon.de Order List (DE)

Convenience shopping list originally collected on 2026-09-02. This is a **dated sourcing snapshot**, not the electrical specification.

> **V3.4 IMPORTANT:** The authoritative electrical requirements are now [`01_BOM.md`](01_BOM.md), [`02_ELECTRICAL.md`](02_ELECTRICAL.md) and the [V3.4 perfboard guide](10_PERFBOARD_V34_SOLDERING_DE.md). Do not copy older SS14/6.3-V/direct-XIAO-power assumptions from a historical shopping link. V3.4 uses **SS34-class ≥3 A motor flyback diodes**, **C1 470 µF/10 V**, **C2 100 µF/10 V**, and a **1S→5 V boost + D5** for XIAO power.

> Marketplace listings, prices, stock and even the shipped variant behind a given listing change frequently. Open every listing and verify the exact electrical/mechanical variant before ordering.

| Part | Qty | Example/source note | V3.4 verify before ordering |
|---|---:|---|---|
| Seeed XIAO ESP32-S3 Sense | 1 | Amazon/Seeed distributor | Sense version; actual camera module may be OV2640 or OV3660 |
| GY-91 MPU9250+BMP280 | 1 | Amazon marketplace | Confirm MPU9250/actual IMU variant, not an MPU6050 clone |
| VL6180X breakout | 1 | Existing photographed module / marketplace | 7-pin order must match `VIN,2V8,GND,GPIO,SHDN,SCL,SDA` |
| 8520 coreless motor, 1.0 mm shaft | 6 (4 + 2 spares) | RC/Amazon supplier | **1.0 mm shaft**; 8.5×20 mm class |
| 75/76 mm 2-blade props, 1.0 mm bore | 2 sets | RC supplier | Exact bore and matched CW/CCW set |
| 1S LiHV battery | 2 | BETAFPV/RC supplier | 3.8 V nominal, 4.35 V full; BT2.0 preferred for this build |
| 1S→5 V boost module | 1 | Electronics/RC supplier | ≥0.7 A continuous, ≥1 A transient recommended; verify 5 V output before XIAO |
| AO3400A N-MOSFET, SOT-23 | 4 + spares | Reichelt/standard distributor | Pin 1 Gate, 2 Source, 3 Drain |
| **SS34-class Schottky** | 4 + spares | standard electronics distributor | **≥3 A**; motor flyback; band/cathode toward VBAT |
| D5 Schottky | 1 + spare | SS14/1N5819W class acceptable here | ≥1 A; boost-to-XIAO isolation, not a motor flyback diode |
| 100 Ω resistor | 4 + spares | 0603/0805 or THT | gate series resistor |
| 100 kΩ resistor | 6 + spares | 0603/0805 or THT | four gate pulldowns + ADC divider |
| **470 µF low-ESR capacitor** | 1 + spare | standard distributor | **10 V**, C1, polarity |
| **100 µF low-ESR capacitor** | 1 + spare | standard distributor | **10 V**, C2, polarity |
| 100 nF ceramic | 5 + spares | standard distributor | one ADC filter + one directly across each motor |
| BT2.0 pigtail | 1 + spare | RC supplier | 20–22 AWG preferred; verify polarity |
| JST-XH/equivalent motor connectors | 4 | electronics supplier | current-capable; no Dupont for motor current |
| silicone wire | assorted | electronics supplier | 28–30 AWG signals; **22–24 AWG or suitably rated wire for battery/motor current** |
| 1S LiHV charger | 1 | RC supplier | must support the actual 4.35 V LiHV pack |
| Perfboard | 1 | electronics supplier | **70×30 mm**, 2.54 mm pitch for the V3.4 prototype |

## What was actually ordered / physically observed

- **Battery connector:** BT2.0 was selected for the current 1S LiHV setup. Verify polarity with a multimeter before first connection.
- **XIAO ESP32-S3 Sense:** the received camera module was observed as OV2640. The camera backend/bench testing should therefore be validated against the actual board rather than relying on a marketplace title.
- **Motors:** sourced as 8520-class motors with 75 mm props; shaft diameter remains a mandatory physical check before final assembly.
- **VL6180X:** the physical module was photographed and its seven-pin order was incorporated into V3.4. `2V8` and `GPIO` remain unused; `VIN` is supplied from XIAO 3V3.

## Why exact marketplace links are intentionally not authoritative

Marketplace sellers and variants change. A listing that was correct on the search date can later ship a different connector, motor shaft, camera module or component package. The repository therefore separates:

1. **electrical/mechanical requirements** — authoritative in chapters 01/02/10 and `hardware/`;
2. **shopping links** — disposable convenience references that must be re-checked at purchase time.

For the current build, always resolve conflicts in favor of the V3.4 electrical documentation.

---
[← 08 - Troubleshooting](08_TROUBLESHOOTING.md) | [Docs index](README.md) | Next: [10 - Perfboard V3.4 soldering →](10_PERFBOARD_V34_SOLDERING_DE.md)


## SMD-Sortiment für den V3.4-PCB-Erstaufbau (2026-09-19)

Für den ersten Reflow ist die **0603-Version** des **JTAREA 6390pcs SMD Electronic Component Assortment** deutlich geeigneter als die 0805-Version. Laut aktueller Produktbeschreibung enthält das 0603-Set unter anderem:

- 1%-Widerstände 0603 einschließlich **100 Ω** und **100 kΩ**;
- 0603-Keramikkondensatoren einschließlich **100 nF**;
- Schottky-Dioden **1N5822 / SS34, SMA** (für D1-D4 geeignet);
- **1N5819 / SS14, SMA** sowie weitere Dioden;
- zusätzliche Transistoren, ICs, Induktivitäten und LEDs als Werkstattbestand.

Damit deckt ein Set R1-R10, C3 und D1-D4 ab. **Nicht abgedeckt** sind der für D5 vorgesehene **1N5819W/B5819W im SOD-123-Footprint** sowie die beiden großen SMD-Elkos C1/C2.

Für D5 separat nach **1N5819W oder B5819W, 1 A / 40 V, SOD-123** suchen. Die bereits vorhandenen SS14 im SMA-Gehäuse sind dafür mechanisch zu groß.

Für C1/C2 sind allgemeine Elektrolyt-Sortimente nur dann sinnvoll, wenn Durchmesser/Land-Pattern passen. Viele 470-µF/16-V-Sortimentsteile sind 10 mm groß und passen nicht auf das geplante C1-Footprint. Für den Erstaufbau deshalb C1/C2 footprintgenau beschaffen.


## Amazon-Sets für D5 und C1/C2 (Stand 2026-09-19)

### C1 + C2 gemeinsam in einem SMD-Elko-Sortiment

Ein auf Amazon.de gefundenes **400 Stück / 24 Werte SMD-Aluminium-Elko-Sortiment 1 µF–1000 µF** ist für die beiden Bulk-Kondensatoren besonders interessant. Die zugehörige Stückliste nennt ausdrücklich:

- **100 µF / 16 V, 6.3 × 5.4 mm** → passend zur C2-Gehäuseklasse.
- **470 µF / 16 V, 8 × 10.5 mm** → passend zur C1-Gehäuseklasse.

Damit können C1 und C2 aus **einem** Sortiment bestückt werden. Beim Wareneingang trotzdem Durchmesser und Polaritätsmarkierung gegen das PCB prüfen.

Die kleinere 95-Stück/8-Werte-16-V-SMD-Elko-Box enthält zwar ebenfalls 100 µF und 470 µF, veröffentlicht aber nicht zuverlässig die Gehäusemaße je Wert. Für das IceDrone-PCB ist deshalb das 400er/24-Werte-Set mit expliziten Abmessungen vorzuziehen.

### D5

Für D5 wurde auf Amazon.de ein **VGOL 100er-Pack 1N5819, SOD-123, 1 A / 40 V** gefunden. Vor Checkout ausdrücklich kontrollieren, dass im Angebot **SOD-123** und nicht DO-41, SMA oder SOD-323 ausgewählt ist.

Ein sinnvolles gemeinsames Sortiment, das gleichzeitig den SOD-123-D5 **und** die beiden großen SMD-Aluminium-Elkos in den benötigten Gehäusegrößen enthält, wurde nicht gefunden. Für die sichere mechanische Passung bleiben daher zwei Bestellpositionen sinnvoll: 1× SMD-Elko-Sortiment + 1× SOD-123-Schottky-Pack.
