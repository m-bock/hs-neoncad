
rotate(a=[0, 0, -90])
  union(){
    // main bar
    translate(v=[0, 6, 0])
      difference(){
        // solid
        translate(v=[-63, -6, 0])
          cube(size=[126, 12, 5]);
        // holes
        translate(v=[-55, 0, 0])
          union(){
            translate(v=[0, 0, 0])
              translate(v=[0, 0, -5.0e-2])
                // hole
                translate(v=[0, 0, 0])
                  cylinder(h=5.1, d1=7, d2=7, $fa=6, $fs=0.5);
            translate(v=[11, 0, 0])
              translate(v=[0, 0, -5.0e-2])
                // hole
                translate(v=[0, 0, 0])
                  cylinder(h=5.1, d1=7.2, d2=7.2, $fa=6, $fs=0.5);
            translate(v=[22, 0, 0])
              translate(v=[0, 0, -5.0e-2])
                // hole
                translate(v=[0, 0, 0])
                  cylinder(h=5.1, d1=7.4, d2=7.4, $fa=6, $fs=0.5);
            translate(v=[33, 0, 0])
              translate(v=[0, 0, -5.0e-2])
                // hole
                translate(v=[0, 0, 0])
                  cylinder(h=5.1, d1=7.6000000000000005, d2=7.6000000000000005, $fa=6, $fs=0.5);
            translate(v=[44, 0, 0])
              translate(v=[0, 0, -5.0e-2])
                // hole
                translate(v=[0, 0, 0])
                  cylinder(h=5.1, d1=7.800000000000001, d2=7.800000000000001, $fa=6, $fs=0.5);
            translate(v=[55, 0, 0])
              translate(v=[0, 0, -5.0e-2])
                // hole
                translate(v=[0, 0, 0])
                  cylinder(h=5.1, d1=8, d2=8, $fa=6, $fs=0.5);
            translate(v=[66, 0, 0])
              translate(v=[0, 0, -5.0e-2])
                // hole
                translate(v=[0, 0, 0])
                  cylinder(h=5.1, d1=8.200000000000001, d2=8.200000000000001, $fa=6, $fs=0.5);
            translate(v=[77, 0, 0])
              translate(v=[0, 0, -5.0e-2])
                // hole
                translate(v=[0, 0, 0])
                  cylinder(h=5.1, d1=8.400000000000002, d2=8.400000000000002, $fa=6, $fs=0.5);
            translate(v=[88, 0, 0])
              translate(v=[0, 0, -5.0e-2])
                // hole
                translate(v=[0, 0, 0])
                  cylinder(h=5.1, d1=8.600000000000001, d2=8.600000000000001, $fa=6, $fs=0.5);
            translate(v=[99, 0, 0])
              translate(v=[0, 0, -5.0e-2])
                // hole
                translate(v=[0, 0, 0])
                  cylinder(h=5.1, d1=8.8, d2=8.8, $fa=6, $fs=0.5);
            translate(v=[110, 0, 0])
              translate(v=[0, 0, -5.0e-2])
                // hole
                translate(v=[0, 0, 0])
                  cylinder(h=5.1, d1=9, d2=9, $fa=6, $fs=0.5);
          }
      }
    // label bar
    translate(v=[0, 12, 0])
      union(){
        translate(v=[-63, 0, 0])
          cube(size=[126, 15, 1.5]);
        translate(v=[-55, 0, 0])
          union(){
            translate(v=[0, 0, 0])
              translate(v=[0, 1, 0])
                rotate(a=[0, 0, 90])
                  linear_extrude(height=2, convexity=10)
                    text(text="7.00", size=4, valign="center", $fa=6, $fs=0.5);
            translate(v=[11, 0, 0])
              translate(v=[0, 1, 0])
                rotate(a=[0, 0, 90])
                  linear_extrude(height=2, convexity=10)
                    text(text="7.20", size=4, valign="center", $fa=6, $fs=0.5);
            translate(v=[22, 0, 0])
              translate(v=[0, 1, 0])
                rotate(a=[0, 0, 90])
                  linear_extrude(height=2, convexity=10)
                    text(text="7.40", size=4, valign="center", $fa=6, $fs=0.5);
            translate(v=[33, 0, 0])
              translate(v=[0, 1, 0])
                rotate(a=[0, 0, 90])
                  linear_extrude(height=2, convexity=10)
                    text(text="7.60", size=4, valign="center", $fa=6, $fs=0.5);
            translate(v=[44, 0, 0])
              translate(v=[0, 1, 0])
                rotate(a=[0, 0, 90])
                  linear_extrude(height=2, convexity=10)
                    text(text="7.80", size=4, valign="center", $fa=6, $fs=0.5);
            translate(v=[55, 0, 0])
              translate(v=[0, 1, 0])
                rotate(a=[0, 0, 90])
                  linear_extrude(height=2, convexity=10)
                    text(text="8.00", size=4, valign="center", $fa=6, $fs=0.5);
            translate(v=[66, 0, 0])
              translate(v=[0, 1, 0])
                rotate(a=[0, 0, 90])
                  linear_extrude(height=2, convexity=10)
                    text(text="8.20", size=4, valign="center", $fa=6, $fs=0.5);
            translate(v=[77, 0, 0])
              translate(v=[0, 1, 0])
                rotate(a=[0, 0, 90])
                  linear_extrude(height=2, convexity=10)
                    text(text="8.40", size=4, valign="center", $fa=6, $fs=0.5);
            translate(v=[88, 0, 0])
              translate(v=[0, 1, 0])
                rotate(a=[0, 0, 90])
                  linear_extrude(height=2, convexity=10)
                    text(text="8.60", size=4, valign="center", $fa=6, $fs=0.5);
            translate(v=[99, 0, 0])
              translate(v=[0, 1, 0])
                rotate(a=[0, 0, 90])
                  linear_extrude(height=2, convexity=10)
                    text(text="8.80", size=4, valign="center", $fa=6, $fs=0.5);
            translate(v=[110, 0, 0])
              translate(v=[0, 1, 0])
                rotate(a=[0, 0, 90])
                  linear_extrude(height=2, convexity=10)
                    text(text="9.00", size=4, valign="center", $fa=6, $fs=0.5);
          }
      }
  }