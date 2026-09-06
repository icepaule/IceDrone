include <icedrone_v2_lib.scad>

// IceDrone V2 exploded assembly scene.
// Printed parts are shown at separated Z levels; electronics, battery and motors
// are simplified mockups from icedrone_v2_lib.scad for orientation only.

// Battery layer
color([0.25,0.25,0.25]) translate([0,0,-28]) battery_sled_650_v2();
translate([0,0,-26.8]) mock_battery();

// Main frame and motors
color([0.82,0.82,0.82]) translate([0,0,-8]) frame_v2();
for (p=motor_positions) translate([p[0],p[1],-8]) mock_motor();

// Four printed M2 spacers
for (x=[-15,15]) for (y=[-15,15])
    color([0.4,0.4,0.4]) translate([x,y,10]) m2_spacer(5);

// Electronics deck and generic carrier PCB/perfboard mockup
color([0.95,0.65,0.15]) translate([0,0,22]) electronics_deck_v2();
translate([0,0,26]) mock_carrier();

// IMU saddle and GY-91 mockup
color([0.2,0.7,0.7]) translate([0,0,34]) imu_gy91_saddle();
translate([0,0,38]) mock_gy91();

// XIAO camera bracket and XIAO/camera mockup
color([0.85,0.45,0.15]) translate([0,13,31]) xiao_camera_mount_v2();
translate([0,15.5,38]) rotate([camera_down_deg,0,0]) mock_xiao_vertical();

// Lightweight flight cage
color([0.7,0.8,0.9,0.28]) translate([0,0,50]) flight_cage_v2();
