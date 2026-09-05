// IceDrone Airframe V2 - parametric printable flight kit
// Designed for icepaule/IceDrone BOM: 123 mm Quad-X, 8520 brushed motors,
// XIAO ESP32-S3 Sense, GY-91, 1S 550-650 mAh battery.
// Units: mm. Propellers intentionally NOT modeled/exported.

// ---------- Global design parameters ----------
$fn = 64;

// Frame / propulsion
motor_id = 8.65;            // press-fit bore for nominal 8.5 mm 8520 motor
motor_od = 12.8;
motor_cup_h = 10.0;
motor_offset = 43.49;       // X/Y -> 123 mm diagonal wheelbase
arm_w = 7.2;
arm_h = 2.6;
center_size = 44;
center_radius = 5;
mount_pattern = 30;
m2_clear = 2.25;
wire_slot_w = 2.0;
wire_slot_depth = 0.55;

// Electronics / universal carrier
deck_size = 40;
deck_h = 1.6;
deck_r = 4;
zip_slot_w = 2.2;
zip_slot_l = 8.0;

// XIAO ESP32-S3 Sense (Seeed footprint)
xiao_w = 17.8;
xiao_h = 21.0;             // vertical mounting height when USB-C is up
xiao_stack_d = 15.0;
xiao_clear = 0.6;
camera_down_deg = 15;      // camera optical axis approximately 15 deg downward
camera_mount_wall = 1.6;

// GY-91 generic module envelope. Marketplace boards vary: measure yours.
gy91_w = 16.5;
gy91_l = 21.5;
gy91_clear = 0.6;
imu_pad_h = 1.4;
imu_lip_h = 2.5;

// Battery envelope per IceDrone BOM
battery_l = 62;
battery_w = 20;
battery_h = 8;
battery_clear = 0.7;
battery_floor = 1.1;
battery_wall = 1.4;

// Canopy
canopy_w = 44;
canopy_l = 42;
canopy_h = 25;
canopy_wall = 1.0;
canopy_roof = 1.0;
canopy_r = 5;

// Optional 75/76 mm prop protection
prop_radius = 38;           // works for 75-76 mm prop families
guard_clear = 4.0;
guard_ring_t = 1.8;
guard_h = 4.5;
guard_arc = 105;

// ---------- Helpers ----------
module rounded_rect_2d(w,l,r) {
    hull() {
        for (x=[-w/2+r, w/2-r])
            for (y=[-l/2+r, l/2-r])
                translate([x,y]) circle(r=r);
    }
}

module rounded_plate(w,l,r,h) {
    linear_extrude(height=h) rounded_rect_2d(w,l,r);
}

module slot2d(w,l) {
    hull() {
        translate([0,-(l-w)/2]) circle(d=w);
        translate([0, (l-w)/2]) circle(d=w);
    }
}

module slot3d(w,l,h) {
    linear_extrude(height=h) slot2d(w,l);
}

module tube(od,id,h) {
    difference() {
        cylinder(d=od,h=h);
        translate([0,0,-0.1]) cylinder(d=id,h=h+0.2);
    }
}

// ---------- Main frame ----------
motor_positions = [
    [ motor_offset, motor_offset],
    [-motor_offset, motor_offset],
    [-motor_offset,-motor_offset],
    [ motor_offset,-motor_offset]
];

module _central_plate_raw() {
    rounded_plate(center_size, center_size, center_radius, arm_h);
}

module _arm_raw(mx,my) {
    hull() {
        translate([mx*0.30,my*0.30,0]) cylinder(d=arm_w,h=arm_h);
        translate([mx,my,0]) cylinder(d=motor_od*0.88,h=arm_h);
    }
}

module _motor_cup(mx,my) {
    angle = atan2(-my,-mx);
    translate([mx,my,0])
    difference() {
        cylinder(d=motor_od,h=motor_cup_h);
        translate([0,0,-0.1]) cylinder(d=motor_id,h=motor_cup_h+0.2);
        rotate([0,0,angle])
            translate([0,-wire_slot_w/2,1.0])
                cube([motor_od/2+1,wire_slot_w,motor_cup_h],center=false);
    }
}

module _wire_groove(mx,my) {
    hull() {
        translate([mx*0.30,my*0.30,arm_h-wire_slot_depth]) cylinder(d=wire_slot_w,h=wire_slot_depth+0.2);
        translate([mx*0.88,my*0.88,arm_h-wire_slot_depth]) cylinder(d=wire_slot_w,h=wire_slot_depth+0.2);
    }
}

module frame_v2() {
    difference() {
        union() {
            _central_plate_raw();
            for (p=motor_positions) _arm_raw(p[0],p[1]);
            for (p=motor_positions) _motor_cup(p[0],p[1]);
        }
        for (x=[-mount_pattern/2,mount_pattern/2])
            for (y=[-mount_pattern/2,mount_pattern/2])
                translate([x,y,-0.2]) cylinder(d=m2_clear,h=arm_h+0.4);
        for (x=[-16,16])
            for (y=[-7,7])
                translate([x,y,-0.1]) rotate([0,0,90]) slot3d(zip_slot_w,zip_slot_l,arm_h+0.2);
        for (p=motor_positions) _wire_groove(p[0],p[1]);
        translate([-2,center_size/2-1.0,-0.1]) cube([4,2.2,arm_h+0.2]);
    }
}

// ---------- Electronics deck ----------
module electronics_deck_v2() {
    difference() {
        rounded_plate(deck_size,deck_size,deck_r,deck_h);
        for (x=[-mount_pattern/2,mount_pattern/2])
            for (y=[-mount_pattern/2,mount_pattern/2])
                translate([x,y,-0.1]) cylinder(d=m2_clear,h=deck_h+0.2);
        for (x=[-13,13])
            for (y=[-9,9])
                translate([x,y,-0.1]) rotate([0,0,90]) slot3d(zip_slot_w,zip_slot_l,deck_h+0.2);
        for (x=[-10,10])
            translate([x,0,-0.1]) cylinder(d=5,h=deck_h+0.2);
        for (x=[-10,10]) translate([x,13,-0.1]) cylinder(d=m2_clear,h=deck_h+0.2);
    }
}

// ---------- Printed M2 spacers ----------
module m2_spacer(h=5, od=5.5) { tube(od,m2_clear,h); }
module spacer_set_4(h=5) {
    for (x=[-9,9]) for (y=[-9,9]) translate([x,y,0]) m2_spacer(h=h);
}

// ---------- GY-91 vibration-isolation saddle ----------
module imu_gy91_saddle() {
    inner_w = gy91_w + gy91_clear;
    inner_l = gy91_l + gy91_clear;
    outer_w = inner_w + 2*1.3;
    outer_l = inner_l + 2*1.3;
    difference() {
        union() {
            rounded_plate(outer_w,outer_l,2.0,imu_pad_h);
            for (x=[-outer_w/2+1.3,outer_w/2-1.3])
                for (y=[-outer_l/2+2.3,outer_l/2-2.3])
                    translate([x,y,imu_pad_h]) cube([2.6,4.6,imu_lip_h],center=true);
        }
        for (y=[-outer_l/2+4,outer_l/2-4])
            translate([0,y,-0.1]) rotate([0,0,90]) slot3d(2.0,8.0,imu_pad_h+0.2);
    }
}

// ---------- XIAO Sense forward camera bracket ----------
module xiao_camera_mount_v2() {
    base_w = 28;
    base_l = 13;
    back_w = xiao_w + 4.0;
    back_h = xiao_h + 4.0;
    back_t = camera_mount_wall;
    lean = camera_down_deg;
    union() {
        difference() {
            translate([-base_w/2,-base_l/2,0]) cube([base_w,base_l,camera_mount_wall]);
            for (x=[-10,10]) translate([x,0,-0.1]) cylinder(d=m2_clear,h=camera_mount_wall+0.2);
            translate([-5,-2,-0.1]) cube([10,6,camera_mount_wall+0.2]);
        }
        translate([0,base_l/2-2,camera_mount_wall])
        rotate([lean,0,0])
        difference() {
            union() {
                translate([-back_w/2,-back_t,0]) cube([back_w,back_t,back_h]);
                translate([-back_w/2,-back_t,0]) cube([back_w,4.0,2.2]);
                translate([-back_w/2,-back_t,0]) cube([2.0,3.0,back_h]);
                translate([ back_w/2-2.0,-back_t,0]) cube([2.0,3.0,back_h]);
            }
            translate([-(xiao_w-5)/2,-back_t-0.1,5]) cube([xiao_w-5,back_t+0.2,xiao_h-7]);
            for (z=[6,back_h-6])
                translate([0,-back_t-0.1,z]) rotate([90,0,0]) slot3d(2.0,10.0,back_t+0.2);
        }
    }
}

// ---------- Lightweight ventilated canopy ----------
module canopy_v2() {
    tab_h = 1.8;
    difference() {
        union() {
            difference() {
                rounded_plate(canopy_w,canopy_l,canopy_r,canopy_h);
                translate([0,0,-0.2])
                    rounded_plate(canopy_w-2*canopy_wall,
                                  canopy_l-2*canopy_wall,
                                  max(1,canopy_r-canopy_wall),
                                  canopy_h-canopy_roof+0.2);
            }
            for (x=[-mount_pattern/2,mount_pattern/2])
                for (y=[-mount_pattern/2,mount_pattern/2]) {
                    translate([x,y,0]) cylinder(d=6,h=tab_h);
                    hull() {
                        translate([x,y,0]) cylinder(d=4.5,h=tab_h);
                        translate([x,sign(y)*(canopy_l/2-1.0),0]) cylinder(d=2.0,h=tab_h);
                    }
                }
        }
        for (x=[-mount_pattern/2,mount_pattern/2])
            for (y=[-mount_pattern/2,mount_pattern/2])
                translate([x,y,-0.1]) cylinder(d=m2_clear,h=tab_h+0.4);
        translate([-14,canopy_l/2-2,4]) cube([28,5,18]);
        translate([-8,-canopy_l/2-2,7]) cube([16,5,10]);
        for (x=[-1,1]) {
            translate([x*(canopy_w/2+1.5),-7,6]) rotate([0,90,0]) cube([12,15,5],center=true);
            translate([x*(canopy_w/2+1.5), 9,8]) rotate([0,90,0]) cube([10,10,5],center=true);
        }
        for (x=[-8,0,8]) translate([x,-4,canopy_h-canopy_roof-0.2]) cube([4,15,canopy_roof+0.5],center=false);
    }
}

// ---------- Ultra-light flight cage ----------
module flight_cage_v2() {
    post_x = 19.0;
    post_y = 18.0;
    post_d = 3.0;
    cage_h = 24.0;
    foot_h = 1.8;
    rail_d = 3.0;
    difference() {
        union() {
            for (x=[-mount_pattern/2,mount_pattern/2])
                for (y=[-mount_pattern/2,mount_pattern/2]) {
                    translate([x,y,0]) cylinder(d=6,h=foot_h);
                    hull() {
                        translate([x,y,0]) cylinder(d=3.5,h=foot_h);
                        translate([sign(x)*post_x,sign(y)*post_y,0]) cylinder(d=post_d,h=foot_h);
                    }
                }
            for (x=[-post_x,post_x])
                for (y=[-post_y,post_y])
                    translate([x,y,0]) cylinder(d=post_d,h=cage_h);
            for (y=[-post_y,post_y])
                hull() {
                    translate([-post_x,y,cage_h-rail_d]) cylinder(d=rail_d,h=rail_d);
                    translate([ post_x,y,cage_h-rail_d]) cylinder(d=rail_d,h=rail_d);
                }
            for (x=[-post_x,post_x])
                hull() {
                    translate([x,-post_y,cage_h-rail_d]) cylinder(d=rail_d,h=rail_d);
                    translate([x, post_y,cage_h-rail_d]) cylinder(d=rail_d,h=rail_d);
                }
            hull() {
                translate([-post_x,-post_y,10]) cylinder(d=rail_d,h=rail_d);
                translate([ post_x,-post_y,10]) cylinder(d=rail_d,h=rail_d);
            }
        }
        for (x=[-mount_pattern/2,mount_pattern/2])
            for (y=[-mount_pattern/2,mount_pattern/2])
                translate([x,y,-0.1]) cylinder(d=m2_clear,h=foot_h+0.3);
    }
}

// ---------- Adjustable underside battery sled ----------
module battery_sled_650_v2() {
    L = battery_l + 2*battery_clear;
    W = battery_w + 2*battery_clear;
    floor_w = W + 2*battery_wall;
    floor_l = L + 2*battery_wall;
    wall_h = battery_h*0.62 + battery_floor;
    difference() {
        union() {
            translate([-floor_w/2,-floor_l/2,0]) cube([floor_w,floor_l,battery_floor]);
            translate([-floor_w/2,-floor_l/2,0]) cube([battery_wall,floor_l,wall_h]);
            translate([ floor_w/2-battery_wall,-floor_l/2,0]) cube([battery_wall,floor_l,wall_h]);
            for (x=[-mount_pattern/2,mount_pattern/2])
                for (y=[-mount_pattern/2,mount_pattern/2]) {
                    translate([x,y,0]) slot3d(7,16,battery_floor);
                    hull() {
                        translate([x,y-6,0]) cylinder(d=4,h=battery_floor);
                        translate([sign(x)*(floor_w/2-1),y-6,0]) cylinder(d=4,h=battery_floor);
                    }
                    hull() {
                        translate([x,y+6,0]) cylinder(d=4,h=battery_floor);
                        translate([sign(x)*(floor_w/2-1),y+6,0]) cylinder(d=4,h=battery_floor);
                    }
                }
        }
        for (y=[-23,0,23])
            translate([-W/2+2,y-4.5,-0.1]) cube([W-4,9,battery_floor+0.2]);
        for (x=[-mount_pattern/2,mount_pattern/2])
            for (y=[-mount_pattern/2,mount_pattern/2])
                translate([x,y,-0.1]) slot3d(m2_clear,11,battery_floor+0.2);
        for (y=[-20,20])
            for (x=[-floor_w/2+4,floor_w/2-4])
                translate([x,y,-0.1]) slot3d(2.5,9,battery_floor+0.2);
    }
}

// ---------- Optional corner prop guard ----------
module _arc_wedge(r,deg,h) {
    linear_extrude(height=h)
        polygon(points=concat([[0,0]],[for(a=[-deg/2:4:deg/2]) [r*cos(a),r*sin(a)]]));
}

module prop_guard_corner_v2() {
    gr = prop_radius + guard_clear;
    difference() {
        union() {
            intersection() {
                difference() {
                    cylinder(r=gr,h=guard_h);
                    translate([0,0,-0.1]) cylinder(r=gr-guard_ring_t,h=guard_h+0.2);
                }
                _arc_wedge(gr+5,guard_arc,guard_h);
            }
            hull() {
                translate([0,0,0]) cylinder(d=12.0,h=2.0);
                translate([gr-guard_ring_t/2,0,0]) cylinder(d=5,h=2.0);
            }
        }
        translate([0,0,-0.1]) cylinder(d=motor_od+0.5,h=2.2);
    }
}

// ---------- Motor cup fit coupon ----------
module motor_cup_test_v2() {
    ids=[8.55,8.60,8.65,8.70,8.75];
    for (i=[0:len(ids)-1])
        translate([(i-(len(ids)-1)/2)*16,0,0])
        difference() {
            cylinder(d=motor_od,h=8);
            translate([0,0,-0.1]) cylinder(d=ids[i],h=8.2);
            translate([0,-0.8,2]) cube([motor_od/2+1,1.6,7]);
        }
}

// ---------- Simple component mockups for assembly preview only ----------
module mock_motor() { color([0.35,0.35,0.38]) cylinder(d=8.5,h=20); }
module mock_battery() { color([0.55,0.75,0.95,0.7]) translate([-battery_w/2,-battery_l/2,0]) cube([battery_w,battery_l,battery_h]); }
module mock_carrier() { color([0.15,0.35,0.7]) translate([-15,-15,0]) cube([30,30,1.6]); }
module mock_gy91() { color([0.1,0.55,0.2]) translate([-gy91_w/2,-gy91_l/2,0]) cube([gy91_w,gy91_l,1.6]); }
module mock_xiao_vertical() {
    color([0.12,0.18,0.15]) translate([-xiao_w/2,0,0]) cube([xiao_w,1.6,xiao_h]);
    color([0.1,0.1,0.1]) translate([-6,1.6,8]) cube([12,4,12]);
}

module assembly_preview_v2(show_canopy=true,show_guards=false) {
    color([0.25,0.25,0.25]) translate([0,0,-10]) battery_sled_650_v2();
    translate([0,0,-8.8]) mock_battery();
    color([0.82,0.82,0.82]) frame_v2();
    for (p=motor_positions) translate([p[0],p[1],0]) mock_motor();
    for (x=[-15,15]) for (y=[-15,15]) color([0.4,0.4,0.4]) translate([x,y,arm_h]) m2_spacer(5);
    color([0.95,0.65,0.15]) translate([0,0,arm_h+5]) electronics_deck_v2();
    translate([0,0,arm_h+5+deck_h]) mock_carrier();
    color([0.2,0.7,0.7]) translate([0,0,arm_h+5+deck_h+1.6]) imu_gy91_saddle();
    translate([0,0,arm_h+5+deck_h+1.6+imu_pad_h]) mock_gy91();
    color([0.85,0.45,0.15]) translate([0,13,arm_h+5+deck_h]) xiao_camera_mount_v2();
    translate([0,15.5,arm_h+5+deck_h+3]) rotate([camera_down_deg,0,0]) mock_xiao_vertical();
    if(show_canopy) color([0.7,0.8,0.9,0.35]) translate([0,0,arm_h+5]) flight_cage_v2();
    if(show_guards) for (p=motor_positions)
        translate([p[0],p[1],0]) rotate([0,0,atan2(p[1],p[0])]) color([0.8,0.3,0.25,0.5]) prop_guard_corner_v2();
}
