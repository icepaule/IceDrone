// 1 mm motor-shaft bore calibration coupon for IceDrone
// SPDX-License-Identifier: Apache-2.0
$fn = 48;

holes = [0.90, 0.95, 1.00, 1.05, 1.10, 1.15];
plate_h = 3.0;
spacing = 8.0;
margin = 5.0;

length_x = margin*2 + spacing*(len(holes)-1);
width_y  = 12.0;

difference() {
    translate([-length_x/2, -width_y/2, 0])
        cube([length_x, width_y, plate_h]);

    for (i=[0:len(holes)-1]) {
        x = -length_x/2 + margin + i*spacing;
        translate([x,0,-0.5]) cylinder(d=holes[i], h=plate_h+1);
    }
}
