// IceDrone V1 - optional corner prop guard
// One printed per motor for low-energy indoor testing, per docs/03_MECHANICAL.md.
// Prop radius 38 mm (76 mm props); guard sits just outside the prop disc.

prop_radius     = 38;
guard_clearance = 4;         // gap between prop tip and guard ring
guard_radius    = prop_radius + guard_clearance;
ring_thickness  = 2.5;
ring_height     = 6;
arc_deg         = 100;       // corner guard covers one quadrant plus a bit
post_d          = 6;
mount_hole_d    = 2.2;
$fn             = 96;

module guard_ring_segment() {
    difference() {
        cylinder(r = guard_radius, h = ring_height);
        translate([0, 0, -0.1]) cylinder(r = guard_radius - ring_thickness, h = ring_height + 0.2);
    }
}

module arc_wedge() {
    // pie wedge from -arc_deg/2 to +arc_deg/2, centered on the +X axis
    linear_extrude(height = ring_height)
        polygon(points = concat(
            [[0, 0]],
            [for (a = [-arc_deg / 2 : 5 : arc_deg / 2]) [
                (guard_radius + 5) * cos(a),
                (guard_radius + 5) * sin(a)
            ]]
        ));
}

module prop_guard_corner() {
    mid_radius = guard_radius - ring_thickness / 2;
    union() {
        intersection() {
            guard_ring_segment();
            arc_wedge();
        }
        // mounting post, on the arc centerline, connects the guard back to the frame arm
        difference() {
            translate([mid_radius, 0, 0]) cylinder(d = post_d, h = ring_height);
            translate([mid_radius, 0, -0.1]) cylinder(d = mount_hole_d, h = ring_height + 0.2);
        }
    }
}

prop_guard_corner();
