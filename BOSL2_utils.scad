// BOSL2 helper functions

// round_corners() helper
// to define points and rads together, use these two functions
function points(radpath) =  
    [for (i = [0 : len(radpath) - 1]) [ for (j = [ 0 : 1]) radpath[i][j] ]];
function rads(radpath) = 
    [for (i = [0 : len(radpath) - 1]) (len(radpath[i])<=2)? 0 : radpath[i][2]  ];

/*
Example: Define points with radii
radpoints1 = [ 
  [ 0, 0, 0.5 ],
  [ 2, 0, 1.5 ],
  [ 2, 4, 0 ],
  [ 0, 4, 0 ],
  ];
translate([0,0,0]) linear_extrude( height=1 ) 
  polygon( round_corners(path=points(radpoints1), radius=rads(radpoints1) ) );

Example: Radii of zero need not be specified
radpoints2 = [ 
  [ 0, 0, 0.5 ],
  [ 2, 0, 1.5 ],
  [ 2, 4 ],
  [ 0, 4 ],
  ];
translate([3,0,0]) linear_extrude( height=1 ) 
  polygon( round_corners(path=points(radpoints2), radius=rads(radpoints2) ) );
*/