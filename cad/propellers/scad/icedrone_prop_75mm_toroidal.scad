// IceDrone 75 mm toroidal / loop propeller research prototype
// SPDX-License-Identifier: Apache-2.0
//
// Geometry inspired by the closed-loop / toroidal propeller concept publicly described
// by MIT Lincoln Laboratory. This is NOT a copy of an unpublished production profile and
// has not been aerodynamically validated for 8520 motors.
//
// IMPORTANT: The toroidal concept is covered by MIT patent/licensing material in some
// jurisdictions (e.g. US 10,836,466). Apache-2.0 here applies to this OpenSCAD source;
// it does not grant third-party patent rights.
//
// FDM printed propellers can fail at high RPM. Use a protective enclosure, eye protection
// and low-RPM bench testing. Dynamically balance before any flight attempt.

$fn = 52;

diameter_mm      = 75.0;
pitch_mm         = 40.64;
shaft_bore_mm    = 1.05;
hub_diameter_mm  = 7.0;
hub_height_mm    = 6.0;
rotation         = "CW";
pitch_scale      = 0.62;
min_pitch_deg    = 7.5;
max_pitch_deg    = 24.0;
section_span_mm  = 1.00;
quality          = 24;

loop_pts = [
    [ 3.1, -1.8, -0.40, 4.0, 1.55],
    [ 8.5, -3.4, -0.10, 4.8, 1.45],
    [16.0, -5.2,  0.35, 5.3, 1.35],
    [24.5, -6.1,  0.95, 5.2, 1.25],
    [32.0, -5.0,  1.75, 4.7, 1.15],
    [36.2, -2.3,  2.55, 3.9, 1.08],
    [36.8,  1.4,  2.80, 3.6, 1.05],
    [34.2,  4.8,  2.20, 4.0, 1.08],
    [27.0,  6.6,  1.30, 4.6, 1.15],
    [18.0,  6.2,  0.45, 5.0, 1.25],
    [10.0,  4.5, -0.15, 4.7, 1.40],
    [ 3.1,  1.8, -0.40, 4.0, 1.55]
];

function clamp(v, lo, hi) = min(max(v, lo), hi);
function handed_sign() = rotation == "CW" ? -1 : 1;
function rr(p) = sqrt(p[0]*p[0] + p[1]*p[1]);
function radial_yaw(p) = atan2(p[1], p[0]);
function local_pitch(p) = handed_sign() * clamp(atan(pitch_mm/(2*PI*max(rr(p), 4.0))) * pitch_scale,
                                                min_pitch_deg, max_pitch_deg);

module loop_section(p) {
    translate([p[0], p[1], p[2]])
        rotate([0,0,radial_yaw(p)])
            rotate([local_pitch(p),0,0])
                scale([section_span_mm/2, p[3]/2, p[4]/2])
                    sphere(r=1, $fn=quality);
}

module one_loop() {
    for (i = [0 : len(loop_pts)-2]) {
        hull() {
            loop_section(loop_pts[i]);
            loop_section(loop_pts[i+1]);
        }
    }
    hull() {
        cylinder(d=hub_diameter_mm-0.35, h=hub_height_mm*0.58, center=true, $fn=56);
        loop_section(loop_pts[0]);
    }
    hull() {
        cylinder(d=hub_diameter_mm-0.35, h=hub_height_mm*0.58, center=true, $fn=56);
        loop_section(loop_pts[len(loop_pts)-1]);
    }
}

module toroidal_propeller() {
    difference() {
        union() {
            cylinder(d=hub_diameter_mm, h=hub_height_mm, center=true, $fn=64);
            one_loop();
            rotate([0,0,180]) one_loop();
        }
        cylinder(d=shaft_bore_mm, h=hub_height_mm+3, center=true, $fn=48);
        translate([0,0,-hub_height_mm/2-0.01])
            cylinder(d1=shaft_bore_mm+0.45, d2=shaft_bore_mm,
                     h=0.55, center=false, $fn=48);
    }
}

toroidal_propeller();
