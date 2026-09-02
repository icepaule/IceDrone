// IceDrone V1 - camera / XIAO Sense cradle
// Open cradle, 15 degree camera attitude, per docs/03_MECHANICAL.md.
// Sized for the XIAO ESP32-S3 Sense stack (~21 x 17.8 mm footprint,
// ~15 mm stack height incl. camera module). Intentionally open for cooling.

board_length   = 21;
board_width    = 17.8;
stack_height   = 15;
wall_thickness = 1.6;
tilt_deg       = 15;
mount_hole_d   = 2.2;
mount_pattern  = 30;
$fn            = 48;

module base_plate() {
    difference() {
        translate([-mount_pattern / 2 - 5, -board_width / 2 - 5, 0])
            cube([mount_pattern + 10, board_width + 10, wall_thickness]);
        for (x = [-mount_pattern / 2, mount_pattern / 2])
            translate([x, 0, -0.1])
                cylinder(d = mount_hole_d, h = wall_thickness + 0.2);
    }
}

module side_rail() {
    // open side rail that clips the board edge and holds the tilt angle
    cube([board_length + 4, wall_thickness, stack_height * 0.6]);
}

module camera_cradle_15deg() {
    union() {
        base_plate();
        rotate([tilt_deg, 0, 0]) {
            translate([-(board_length + 4) / 2, -board_width / 2 - wall_thickness, wall_thickness])
                side_rail();
            translate([-(board_length + 4) / 2, board_width / 2, wall_thickness])
                side_rail();
            // open front lip, cooling gap left in the middle on purpose
            translate([-(board_length + 4) / 2, -board_width / 2 - wall_thickness, wall_thickness])
                cube([wall_thickness, board_width + 2 * wall_thickness, stack_height * 0.25]);
        }
    }
}

camera_cradle_15deg();
