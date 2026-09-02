// IceDrone V1 - battery cradle
// Targets a 1S 550-650 mAh pack, per docs/03_MECHANICAL.md.
// Edit L/W/H below to match your actual battery before final printing.

battery_length = 62;  // L
battery_width  = 20;  // W
battery_height = 8;   // H
wall_thickness = 1.4;
clearance      = 0.6; // extra clearance around the pack
floor_thickness = 1.2;
mount_hole_d   = 2.2;
mount_pattern  = 30;
$fn            = 48;

module battery_cradle_650() {
    L = battery_length + 2 * clearance;
    W = battery_width + 2 * clearance;
    H = battery_height + floor_thickness;

    difference() {
        union() {
            // floor
            translate([-L / 2 - wall_thickness, -W / 2 - wall_thickness, 0])
                cube([L + 2 * wall_thickness, W + 2 * wall_thickness, floor_thickness]);
            // side walls, left open at both ends for strap access
            translate([-L / 2 - wall_thickness, -W / 2 - wall_thickness, 0])
                cube([wall_thickness, W + 2 * wall_thickness, H]);
            translate([L / 2, -W / 2 - wall_thickness, 0])
                cube([wall_thickness, W + 2 * wall_thickness, H]);
        }
        // mounting holes through the floor, matching the 30x30 mm frame pattern
        for (x = [-mount_pattern / 2, mount_pattern / 2])
            for (y = [-mount_pattern / 2, mount_pattern / 2])
                translate([x, y, -0.1])
                    cylinder(d = mount_hole_d, h = floor_thickness + 0.2);
    }
}

battery_cradle_650();
