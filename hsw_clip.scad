include <Round-Anything/polyround.scad>
include <hrk_library/hswx.scad>

$fn=90;

/*
 ___...
|
|
 \
 |
 |
 |
 |
_|
|___...
*/

plug_base_thickness = 1;
plug_base_lip = 1;
plug_stud_thickness = 1.6;
plug_stud_height = hswx_lock_depth-2;
plug_spring_base = 3;
plug_spring_depth = 6;
plug_spring_thickness = 1.2;

points_base = [
[ -plug_base_lip,          -plug_base_thickness, 0 ],
[ -plug_base_lip,                             0, 0 ],
[              0,                             0, 0.3 ],

[              0,               hswx_lock_depth, 0 ],
[ -hswx_lock_lip, hswx_lock_lip+hswx_lock_depth, 0.5 ],
[ -hswx_lock_lip,                    hswx_depth, 0.5 ],
[ plug_stud_thickness,               hswx_depth, 0 ],
[ plug_stud_thickness,                        0, 4 ],
[ hswx_inside-plug_stud_thickness,            0, 1 ],
[ hswx_inside-plug_stud_thickness,   hswx_depth, 0 ],

[    hswx_inside,                    hswx_depth, 1 ],
[ hswx_inside+hswx_lock_lip*0.75, hswx_lock_depth+1, .5 ],
[    hswx_inside,               hswx_lock_depth, 0 ],
[    hswx_inside,                             0, 0.3 ],
[ hswx_inside+plug_base_lip,                  0, 0 ],
[ hswx_inside+plug_base_lip, -plug_base_thickness,  0 ],
];

points_spring = [
[ plug_stud_thickness,               hswx_depth, 0 ],
[ plug_spring_base,                  hswx_depth, 6 ],
[ hswx_inside/2,   hswx_depth-plug_spring_depth-0.5, 5 ],
[ hswx_inside-plug_spring_base,      hswx_depth, 6 ],
[ hswx_inside-plug_stud_thickness,   hswx_depth, 0 ],
[ hswx_inside-plug_stud_thickness,   hswx_depth-plug_spring_thickness, 0 ],
[ hswx_inside-plug_spring_base,      hswx_depth-plug_spring_thickness, 4 ],

[ hswx_inside/2,   hswx_depth-plug_spring_depth-plug_spring_thickness, 6 ],

[ plug_spring_base, hswx_depth-plug_spring_thickness, 4 ], 
[ plug_stud_thickness, hswx_depth-plug_spring_thickness, 0 ],
];

module hsw_clip() {
linear_extrude(hswx_inside/2)
polygon(polyRound( points_base ));
linear_extrude(hswx_inside/2)
polygon(polyRound(points_spring));
}

// hsw_clip();