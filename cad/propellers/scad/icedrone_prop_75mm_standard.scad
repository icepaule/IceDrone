// IceDrone 75 mm two-blade propeller prototype
// SPDX-License-Identifier: Apache-2.0
//
// Intended as a PARAMETRIC geometry / fit prototype for IceDrone's 8520 motors.
// Reference target: 75 mm diameter, ~1.6 in pitch, 1.0 mm motor shaft.
//
// IMPORTANT: FDM printed propellers can fail at high RPM. Use a protective enclosure,
// eye protection and low-RPM bench tests. For flight, injection-moulded PC props remain
// the safer baseline until this geometry has been dynamically balanced and load-tested.

$fn = 56;

diameter_mm      = 75.0;
pitch_mm         = 40.64;
shaft_bore_mm    = 1.05;
hub_diameter_mm  = 6.4;
hub_height_mm    = 5.8;
rotation         = "CW";
pitch_scale      = 0.95;
min_pitch_deg    = 9.5;
max_pitch_deg    = 32.0;
section_span_mm  = 1.10;
quality          = 28;

stations = [
    [ 2.8,  4.6, 1.65],
    [ 7.0,  6.8, 1.55],
    [13.0,  9.2, 1.40],
    [21.0, 10.0, 1.22],
    [29.0,  8.7, 1.05],
    [35.0,  6.0, 0.95],
    [36.85, 3.3, 0.90]
];

function clamp(v, lo, hi) = min(max(v, lo), hi);
function handed_sign() = rotation == "CW" ? -1 : 1;
function pitch_angle(r) = handed_sign() * clamp(atan(pitch_mm/(2*PI*r)) * pitch_scale,
                                                 min_pitch_deg, max_pitch_deg);

module blade_section(r, chord, thick) {
    translate([r, 0, 0])
        rotate([pitch_angle(r), 0, 0])
            scale([section_span_mm/2, chord/2, thick/2])
                sphere(r=1, $fn=quality);
}

module one_blade() {
    for (i = [0 : len(stations)-2]) {
        hull() {
            blade_section(stations[i][0],   stations[i][1],   stations[i][2]);
            blade_section(stations[i+1][0], stations[i+1][1], stations[i+1][2]);
        }
    }
}

module root_blend(angle=0) {
    rotate([0,0,angle])
        hull() {
            cylinder(d=hub_diameter_mm-0.3, h=hub_height_mm*0.62, center=true, $fn=64);
            blade_section(stations[1][0], stations[1][1], stations[1][2]);
        }
}

module propeller() {
    difference() {
        union() {
            cylinder(d=hub_diameter_mm, h=hub_height_mm, center=true, $fn=64);
            one_blade();
            rotate([0,0,180]) one_blade();
            root_blend(0);
            root_blend(180);
        }
        cylinder(d=shaft_bore_mm, h=hub_height_mm+3, center=true, $fn=48);
        translate([0,0,-hub_height_mm/2-0.01])
            cylinder(d1=shaft_bore_mm+0.45, d2=shaft_bore_mm,
                     h=0.55, center=false, $fn=48);
    }
}

propeller();
