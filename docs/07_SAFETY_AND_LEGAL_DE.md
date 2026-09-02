# 07 - Safety and Legal (DE/EU)

This section is a practical engineering reminder, not legal advice. Re-check official rules before operation because requirements can change.

## Workshop safety

- Remove props for all bench firmware and electronics tests.
- Treat 1S LiPo/LiHV packs as high-current sources; a short circuit can cause fire.
- Use a charger explicitly supporting the chemistry and final voltage. A LiHV 3.8 V nominal pack may be charged to 4.35 V only with a LiHV-capable charger.
- Do not charge unattended or use a swollen/damaged cell.
- Secure the U.FL antenna before applying sustained Wi-Fi load.
- After crashes, inspect motor cups, arms, battery and propellers before re-arming.

## Operating category

The design target is far below 250 g. A privately built UAS below 250 g can generally be operated in the EU Open category under the applicable A1 conditions, subject to all geographic-zone and operational restrictions. A camera can trigger operator-registration requirements even below 250 g unless an exemption applies. Liability insurance remains a separate German requirement for model aircraft/UAS operation.

Use the official EASA and German authority pages as the authoritative source at time of flight.

Useful starting points:

- EASA drones FAQ: https://www.easa.europa.eu/en/the-agency/faqs/drones-uas
- German UAS portal / geographic zones: https://dipul.de/

## Wi-Fi/video

The XIAO uses 2.4 GHz Wi-Fi. Keep the design within the module's certified radio configuration and antenna arrangement; do not add unapproved high-power RF amplifiers.
