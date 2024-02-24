/* [Shape of the hexes] */
hswx_inside=20;                       // hexagon inside width flat-flat
hswx_wall=1.8;                        // hexagon inner wall thickness [:0.01]
hswx_outside=hswx_inside+hswx_wall*2; // hexagon outside width flat-flat

hswx_side = hswx_outside / sqrt(3);   // hexagon outside side length
hswx_od = hswx_side * 2;              // outer diameter of circle containing outer hexagon

hswx_depth=8;                         // depth of grid
hswx_lock_depth=5;                    // depth of locking section start

hswx_lock_lip=1;                      // depth of lip = protrusion of lip = chamfer
hswx_lock_chamfer=hswx_lock_lip;

hswx_id_large = (hswx_inside+hswx_lock_lip) * 2/sqrt(3); 
hswx_id_small = hswx_inside * 2/sqrt(3); // outer diameter of circle containing inside hexagon


