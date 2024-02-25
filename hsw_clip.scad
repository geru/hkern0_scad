include <BOSL2/std.scad>
include <BOSL2/rounding.scad>
include <hrk_library/hswx.scad>

$fn=10;

plug_base_thickness = 1;
plug_base_lip = 1;
plug_stud_thickness = 1.6;
plug_stud_height = hswx_lock_depth-2;
plug_spring_base = 3;
plug_spring_depth = 6;
plug_spring_thickness = 1.2;

/* a simple, uninteresting clip made of rectangles. testing only, won't work as a clip
module hsw_clip0() {
  clip_points = [
[              0,                        0 ],     // origin
[              0,               hswx_depth ],     // strong-side base
[    hswx_inside,               hswx_depth ],     // strong lock
[    hswx_inside,                        0 ],     //                    hswx_depth ],
[ hswx_inside-plug_stud_thickness,  0 ],
[ hswx_inside-plug_stud_thickness, plug_spring_depth ],
[ plug_stud_thickness, plug_spring_depth ],
[ plug_stud_thickness,              0 ],

];
  rotate([-90,0,0])
    linear_extrude(hswx_inside/2)
  polygon(clip_points);
}*/

module hsw_clip( center=false, rotate=0, type=0, hexbase=0 ) {
clip_points = [ [ [
[ -plug_base_lip,                             0 ],
[              0,                             0 ],   // origin
[              0,               hswx_lock_depth ],   // strong-side base
[ -hswx_lock_lip, hswx_lock_lip+hswx_lock_depth ],   // strong lock

[ -hswx_lock_lip,                    hswx_depth ],

[ plug_stud_thickness,               hswx_depth ],   // spring
[ plug_spring_base,                  hswx_depth ],
[ hswx_inside/2, hswx_depth-plug_spring_depth-0.5 ], // upper spring midpoint
[ hswx_inside-plug_spring_base,      hswx_depth ],
[ hswx_inside-plug_stud_thickness,   hswx_depth ],

[    hswx_inside,                    hswx_depth ],    // weak lock
[ hswx_inside+hswx_lock_lip, hswx_lock_depth+hswx_lock_lip ],
[    hswx_inside,               hswx_lock_depth ],   // weak-side base
[    hswx_inside,                           0.2 ],
[ hswx_inside+0.5,                            0 ],
[ hswx_inside-plug_stud_thickness-0.5,        0 ],
[ hswx_inside-plug_stud_thickness,          0.5 ],
/**/
[ hswx_inside-plug_stud_thickness, hswx_depth-plug_spring_thickness-1.4 ],
[ hswx_inside-plug_spring_base+.1, hswx_depth-plug_spring_thickness-.1 ],

[ hswx_inside/2, hswx_depth-plug_spring_depth-plug_spring_thickness ],

[ plug_spring_base, hswx_depth-plug_spring_thickness ], 
[ plug_stud_thickness,             hswx_depth/3 ],
[ hswx_inside/3.4,                            0 ],
[ plug_stud_thickness,                        0 ],

], [
  0,
0.3,   // origin
  0,   // strong-side base
0.5,   // strong lock

0.5,

  0,   // spring
3.5,
5.0,  // upper spring midpoint
3.5,  // 6,
  0,

1.0,  // weak lock
0.5,
  0,  // weak-side base
0.5,
  0,
  0,
1.0,
/**/
1.5, // todo inside corner
1.0,

6.0,

2.0, 
1.0,
  0,
  0,

] ] ];
  translate(center?[0,0,0]:[hswx_inside/2,hswx_inside/4,0])
  rotate([0,0,rotate])
    union() {
      translate([-hswx_inside/2,-hswx_inside/4,0])
        rotate([-90,0,0])
          linear_extrude(hswx_inside/2)
            polygon( round_corners(path=clip_points[type][0], radius=clip_points[type][1], $fn=90) );
      if( hexbase ) {
        cyl(l=hexbase, d=hswx_od-1, $fn=6, anchor=BOTTOM, spin=30, rounding2=hexbase/2);
      }  
  }
}

// hsw_clip(center=true, rotate=0, type=0, hexbase=3);
