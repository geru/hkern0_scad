/* Library of hex wall bits */

/* Constants relating to the insert part */
INSERT_MAIN_OUTER_AF_DISTANCE = 19.7;
INSERT_MAIN_INNER_AF_DISTANCE = 13.4;
INSERT_LIP_AF_DISTANCE = 22.5;
INSERT_MAIN_OUTER_DIAMETER = af_to_diameter(INSERT_MAIN_OUTER_AF_DISTANCE);
INSERT_MAIN_INNER_DIAMETER = af_to_diameter(INSERT_MAIN_INNER_AF_DISTANCE);
INSERT_LIP_DIAMETER = af_to_diameter(INSERT_LIP_AF_DISTANCE);
INSERT_TOTAL_HEIGHT = 10;
INSERT_LIP_HEIGHT = 2.5;
INSERT_LIP_PROTRUSION = (INSERT_LIP_AF_DISTANCE - INSERT_MAIN_OUTER_AF_DISTANCE)/2;

/* Constants relating to the honeycomb itself */
HEXAGON_WIDTH = 20;
HEX_WALL_THICKNESS = 3.6;
HEX_SEPARATION = HEXAGON_WIDTH + HEX_WALL_THICKNESS;
HORIZONTAL_HEX_SEPARATION = HEX_SEPARATION * 2 / sqrt(3) + af_to_diameter(HEXAGON_WIDTH + HEX_WALL_THICKNESS)/2;

/* Constants relating to the plug that can go into an empty insert */
PLUG_HEXAGON_DIAMETER = 14.7;
PLUG_AF_SIZE = PLUG_HEXAGON_DIAMETER * sqrt(3) / 2;
PLUG_LENGTH = 13;

tiny_distance = .001;

// insert_empty();
// insert_with_plate();
// insert_horizontal();

module hexagon_plug_horizontal(){
    translate([0, 0, PLUG_AF_SIZE/2]){
        rotate([90, 0, 0]){
            hexagon_plug();
        }
    }
}

module hexagon_plug(){
    cylinder(d=PLUG_HEXAGON_DIAMETER, h=PLUG_LENGTH, $fn=6);
}

module insert_with_plate(){
    insert_empty();
        cylinder(d=INSERT_LIP_DIAMETER, h=INSERT_LIP_HEIGHT, $fn=6);
}


module insert_empty(){
    $fn = 6;
    WALL_SIDE_GAP_START_HEIGHT = 6.5;
    WALL_SIDE_GAP_WIDTH = 1;
    WALL_TOP_GAP_WIDTH = 0.8;
    WALL_GAP_LENGTH = 8;
    WALL_TOP_GAP_RADIUS = 8.25;
    TAB_STICKS_OUT_BY = 0.75; // 1; // 0.5;
    TAB_LENGTH = 2;
    difference() {
        union(){
            cylinder(d=INSERT_MAIN_OUTER_DIAMETER, h=INSERT_TOTAL_HEIGHT);
            cylinder(d=INSERT_LIP_DIAMETER, h=INSERT_LIP_HEIGHT);
        }
        cylinder(d=INSERT_MAIN_INNER_DIAMETER, h=INSERT_TOTAL_HEIGHT+1);
        for (i=[0:5]) {
            rotate([0, 0, i*60]){
                translate([-WALL_GAP_LENGTH/2, WALL_TOP_GAP_RADIUS, WALL_SIDE_GAP_START_HEIGHT]) {
                    cube([WALL_GAP_LENGTH, WALL_TOP_GAP_WIDTH, 10]);
                }
                translate([-WALL_GAP_LENGTH/2, WALL_TOP_GAP_RADIUS, WALL_SIDE_GAP_START_HEIGHT]) {
                    cube([WALL_GAP_LENGTH, 10, WALL_SIDE_GAP_WIDTH]);
                }
            }
        }
        
    }
    for (i=[0:5]) {
            rotate([0, 0, i*60]){
            translate([0, INSERT_MAIN_OUTER_AF_DISTANCE/2, 0]){
                hull(){
                    translate([0, 0, WALL_SIDE_GAP_START_HEIGHT + WALL_SIDE_GAP_WIDTH + TAB_STICKS_OUT_BY]) {
                        rotate([0,90,0]){
                            cylinder(r=TAB_STICKS_OUT_BY, h=TAB_LENGTH, center=true, $fn=20);
                        }
                    }
                    translate([0, 0, INSERT_TOTAL_HEIGHT - tiny_distance]) {
                        rotate([0, 90, 0]) {
                            cylinder(r=tiny_distance, h=TAB_LENGTH, center=true, $fn=20);
                        }
                    }
                }
            }
        }
    }
}

module insert_horizontal(){
    difference() {
        translate([0, 0, INSERT_MAIN_OUTER_AF_DISTANCE/2]) {
            rotate([90, 0, 0]){
                insert_with_plate();
            }
        }
        translate([-10, -INSERT_TOTAL_HEIGHT, -10]) {
            cube([20,INSERT_TOTAL_HEIGHT,10]);
        }
    }
}

module insert_horizontal_noplate(){
    difference() {
        translate([0, 0, INSERT_MAIN_OUTER_AF_DISTANCE/2]) {
            rotate([90, 0, 0]){
                insert_empty();
            }
        }
        translate([-10, -INSERT_TOTAL_HEIGHT, -10]) {
            cube([20,INSERT_TOTAL_HEIGHT,10]);
        }
    }
}

/* converts an 'across flats' dimension to a maximum diameter — useful for openScad */
function af_to_diameter(af) = af / sqrt(3) * 2;
function diameter_to_af(diameter) = diameter * sqrt(3) / 2;
