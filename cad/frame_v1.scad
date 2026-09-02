// IceDrone V1 - main frame
// Quad-X frame, dimensions per docs/03_MECHANICAL.md
// All units in mm.

// ---- parameters ----
motor_id          = 8.65;   // motor cup inner diameter (nominal 8.5 mm motor)
motor_od          = 12.8;   // motor cup outer diameter
cup_height        = 10;     // motor cup height
arm_width         = 7;      // arm width
arm_thickness     = 2.5;    // arm / plate thickness
plate_size        = 42;     // central plate, square, side length
motor_offset      = 43.49;  // motor center X/Y offset from origin -> 123 mm diagonal
mount_pattern     = 30;     // M2 mounting pattern, square
mount_hole_d      = 2.2;    // M2 clearance hole
relief_slot_w     = 1.6;    // motor cup wiring/compliance relief slot width
relief_slot_l     = 6;      // relief slot length (radial)
strap_slot_w      = 3;      // battery strap slot width
strap_slot_l      = 16;     // battery strap slot length
$fn               = 64;

motor_positions = [
    [ motor_offset,  motor_offset], // front-right
    [-motor_offset,  motor_offset], // front-left
    [-motor_offset, -motor_offset], // rear-left
    [ motor_offset, -motor_offset], // rear-right
];

module motor_cup() {
    difference() {
        cylinder(d = motor_od, h = cup_height);
        translate([0, 0, -0.1]) cylinder(d = motor_id, h = cup_height + 0.2);
        // wiring / slight compliance relief slot, radial
        translate([motor_od / 2 - relief_slot_l + 1, -relief_slot_w / 2, cup_height / 2 - 1])
            cube([relief_slot_l, relief_slot_w, cup_height / 2 + 1]);
    }
}

module central_plate() {
    difference() {
        translate([-plate_size / 2, -plate_size / 2, 0])
            cube([plate_size, plate_size, arm_thickness]);

        // M2 mounting pattern, 30x30 mm
        for (x = [-mount_pattern / 2, mount_pattern / 2])
            for (y = [-mount_pattern / 2, mount_pattern / 2])
                translate([x, y, -0.1])
                    cylinder(d = mount_hole_d, h = arm_thickness + 0.2);

        // two battery-strap slots, front and rear edge of the plate
        for (yy = [-(plate_size / 2 - strap_slot_w), (plate_size / 2 - strap_slot_w)])
            translate([-strap_slot_l / 2, yy - strap_slot_w / 2, -0.1])
                cube([strap_slot_l, strap_slot_w, arm_thickness + 0.2]);
    }
}

module arm_to(mx, my) {
    hull() {
        translate([mx * 0.32, my * 0.32, 0])
            cube([arm_width, arm_width, arm_thickness], center = true);
        translate([mx, my, 0])
            cylinder(d = motor_od * 0.82, h = arm_thickness);
    }
}

module frame_v1() {
    union() {
        central_plate();
        for (p = motor_positions) arm_to(p[0], p[1]);
        for (p = motor_positions) translate([p[0], p[1], 0]) motor_cup();
    }
}

frame_v1();
