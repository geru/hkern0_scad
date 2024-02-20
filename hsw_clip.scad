include <BOSL2/std.scad>
include <Round-Anything/polyround.scad>
include <hrk_library/hswx.scad>

$fn=90;

module hsw_clip2() {
  _hsw_clip2_strong();
}

plug_base_thickness = 1;
plug_base_lip = 1;
plug_stud_thickness = 1.6;
plug_stud_height = hswx_lock_depth-2;
plug_spring_base = 3;
plug_spring_depth = 6;
plug_spring_thickness = 1.2;

module _hsw_clip2_strong() {
points_clip = [
[ -plug_base_lip,                             0, 0 ],
[              0,                             0, 0.3 ],   // origin
[              0,               hswx_lock_depth, 0 ],     // strong-side base
[ -hswx_lock_lip, hswx_lock_lip+hswx_lock_depth, 0.5 ],   // strong lock
[ -hswx_lock_lip,                    hswx_depth, 0.5 ],

[ plug_stud_thickness,               hswx_depth, 0 ],     // spring
[ plug_spring_base,                  hswx_depth, 6 ],
[ hswx_inside/2,   hswx_depth-plug_spring_depth-0.5, 5 ], // upper spring midpoint
[ hswx_inside-plug_spring_base,      hswx_depth, 6 ],
[ hswx_inside-plug_stud_thickness,   hswx_depth, 0 ],

[    hswx_inside,                    hswx_depth, 1 ],     // weak lock
[ hswx_inside+hswx_lock_lip*0.75, hswx_lock_depth+1, .5 ],
[    hswx_inside,               hswx_lock_depth, 0 ],     // weak-side base
[    hswx_inside,                             0, 0.5 ],
[ hswx_inside+0.5,                            0, 0 ],
[ hswx_inside-plug_stud_thickness-0.5,        0, 0 ],
[ hswx_inside-plug_stud_thickness,            0, 0.5 ],

[ hswx_inside-plug_stud_thickness,   hswx_depth-plug_spring_thickness, 0 ],
[ hswx_inside-plug_spring_base,      hswx_depth-plug_spring_thickness, 4 ],

[ hswx_inside/2,   hswx_depth-plug_spring_depth-plug_spring_thickness, 6 ],

[ plug_spring_base, hswx_depth-plug_spring_thickness, 4 ], 
[ plug_stud_thickness, hswx_depth/3, 4 ],
[ hswx_inside/3.5, 0, 3 ],
[ hswx_inside/3.4, 0, 0 ],
[ plug_stud_thickness, 0, 0 ],
[ 0, 0, 0 ],
];
  rotate([-90,0,0])
    linear_extrude(hswx_inside/2)
      polygon( polyRound( points_clip ) );
}


module hsw_clip2_strong( center=false, anchor=BOTTOM+LEFT, spin=0, orient=UP ) {
/*  anchor = get_anchor(anchor, center, -[1,1,1], -[1,1,1]);
  size = scalar_vec3(1);
  attachable(anchor,spin,orient, size=size) {
    _hsw_clip();
    children();
  }
*/
 // couldn't get anchoring and attachability working. leaving for now  
    _hsw_clip2_strong();
}

/*
hsw_clip2_strong();
translate([-1,0,0])
cube([22,10,3]);
hsw_clip2();
*/
