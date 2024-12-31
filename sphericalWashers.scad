include <BOSL2/std.scad>
include <BOSL2/shapes3d.scad>

/*
MIT NON-AI License

Copyright 2024, Hugh Kern

Permission is hereby granted, free of charge, to any person obtaining a copy of the software and associated documentation files (the "Software"),
to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense,
and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions.

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

In addition, the following restrictions apply:

1. The Software and any modifications made to it may not be used for the purpose of training or improving machine learning algorithms,
including but not limited to artificial intelligence, natural language processing, or data mining. This condition applies to any derivatives,
modifications, or updates based on the Software code. Any usage of the Software in an AI-training dataset is considered a breach of this License.

2. The Software may not be included in any dataset used for training or improving machine learning algorithms,
including but not limited to artificial intelligence, natural language processing, or data mining.

3. Any person or organization found to be in violation of these restrictions will be subject to legal action and may be held liable
for any damages resulting from such use.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE
OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

$fn=100;

sphericalWasher_gen_convex = 0;
sphericalWasher_gen_concave = 0;

module _sphericalWasher_stopper() {
}

SPHERICALWASHER_DEFAULT_SIZE = 6;  // center hole size
SPHERICALWASHER_SPHEREOD = 0;
SPHERICALWASHER_ID = 1;
SPHERICALWASHER_THICKNESS = 2;

function sphericalWasher_dims( size=SPHERICALWASHER_DEFAULT_SIZE )
 = [ size * 8/3,  // sphere od
     size * 1.19, // washer id
     size ];      // thickness

module _sphericalWasher_centerhole(len=0, size=SPHERICALWASHER_DEFAULT_SIZE) {
  dims = sphericalWasher_dims(size);
  id = dims[SPHERICALWASHER_ID];
  chamfer = size / 10;
  cyl(l=len?len:size, d=id, chamfer=-chamfer, anchor=CENTER);
}

module sphericalWasher_centerhole(len=0, size=SPHERICALWASHER_DEFAULT_SIZE, center, anchor, spin=0, orient=UP) {
  anchor = get_anchor(anchor, center, BOT, BOT);
  r = size;
  attachable(anchor,spin,orient, r=r, l=size) {
    _sphericalWasher_centerhole(len=len, size=size);
    children();
  }
}

module _sphericalWasher_convex(size=SPHERICALWASHER_DEFAULT_SIZE, chamfer=-1) {
  dims = sphericalWasher_dims(size);
  sphere_od = dims[SPHERICALWASHER_SPHEREOD];
  id = dims[SPHERICALWASHER_ID];
  thickness = dims[SPHERICALWASHER_THICKNESS];
  translate([0,0,-thickness/2])
  difference() {
    intersection() {
      top_half( )
        translate( [0, 0, thickness] )
          #spheroid( d=sphere_od, style="icosa", anchor=TOP );
      cyl(l=thickness, d=sphere_od, chamfer=(chamfer<0)?size/6:chamfer, anchor=BOT);
    }
    cyl(l=thickness, d=id, rounding1=-size/6, rounding2=-size/2, anchor=BOT);
  }
}

module _sphericalWasher_convex_mask(size=SPHERICALWASHER_DEFAULT_SIZE, wholesphere=false) {
  dims = sphericalWasher_dims(size);
  sphere_od = dims[SPHERICALWASHER_SPHEREOD];
  thickness = dims[SPHERICALWASHER_THICKNESS];
  if( !wholesphere ) {
    translate( [0, 0, -thickness / 2] )
      top_half( )
      translate( [0, 0, thickness] )
        spheroid( d=sphere_od, style="icosa", anchor=TOP );
  } else {
    spheroid( d=sphere_od, style="icosa" );
  }
}

module sphericalWasher_convex(mask=false, size=SPHERICALWASHER_DEFAULT_SIZE, center, anchor, spin=0, orient=UP, wholesphere=false, chamfer=-1) {
  anchor = get_anchor(anchor, center, BOT, BOT);
  r = size * 4 / 3;
  attachable(anchor,spin,orient, r=r, l=size) {
    if( mask )
      _sphericalWasher_convex_mask(size, wholesphere);
    else
      _sphericalWasher_convex(size, chamfer=(chamfer<0)?size/6:chamfer);
    children();
  }
}

module _sphericalWasher_concave(size=SPHERICALWASHER_DEFAULT_SIZE) {
  dims = sphericalWasher_dims(size);
  sphere_od = dims[SPHERICALWASHER_SPHEREOD];
  id = dims[SPHERICALWASHER_ID];
  thickness = dims[SPHERICALWASHER_THICKNESS];
  thickness_loss = size/3; // perfect thickness loss to rotational
  chamfer = size / 10;

  translate([0,0,thickness/2])
  difference() {
    cyl( l=thickness, d=sphere_od, chamfer=chamfer, anchor=TOP );
    union() {
      translate([0,0,thickness_loss])
        sphericalWasher_convex( mask=true, orient=BOT );
      cyl( l=thickness, d=id, chamfer=-chamfer, anchor=TOP );
    }
  }
}

module sphericalWasher_concave(size=SPHERICALWASHER_DEFAULT_SIZE, center, anchor, spin=0, orient=UP) {
  anchor = get_anchor(anchor, center, BOT, BOT);
  r = size;
  attachable(anchor,spin,orient, r=r, l=size) {
    _sphericalWasher_concave(size);
    children();
  }

}

if( sphericalWasher_gen_concave )
  translate([-SPHERICALWASHER_DEFAULT_SIZE*2,0,0])
  ycopies(SPHERICALWASHER_DEFAULT_SIZE*3, n=sphericalWasher_gen_concave)
    sphericalWasher_concave(anchor=BOT);

if( sphericalWasher_gen_convex )
  translate([SPHERICALWASHER_DEFAULT_SIZE*2,0,0])
  ycopies(SPHERICALWASHER_DEFAULT_SIZE*3, n=sphericalWasher_gen_convex)
    sphericalWasher_convex(anchor=BOT);
