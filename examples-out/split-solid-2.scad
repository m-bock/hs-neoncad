
rotate(a=[-30, 0, 0])
  intersection(){
    rotate(a=[30, 0, 0])
      union(){
        %
        // tube
        difference(){
          translate(v=[0, 0, -100])
            cylinder(h=200, d1=60, d2=60, $fa=6, $fs=0.5);
          translate(v=[0, 0, -100.05])
            cylinder(h=200.1, d1=58.5, d2=58.5, $fa=6, $fs=0.5);
        }
        // rings
        translate(v=[0, 0, -98.5])
          union(){
            translate(v=[0, 0, 0])
              // ring
              // ring
              difference(){
                // outer
                translate(v=[0, 0, -1.5])
                  cylinder(h=3, d1=60, d2=60, $fa=6, $fs=0.5);
                // inner
                translate(v=[0, 0, -1.6])
                  cylinder(h=3.2, d1=3, d2=3, $fa=6, $fs=0.5);
              }
            translate(v=[0, 0, 21.88888888888889])
              // ring
              // ring
              difference(){
                // outer
                translate(v=[0, 0, -1.5])
                  cylinder(h=3, d1=60, d2=60, $fa=6, $fs=0.5);
                // inner
                translate(v=[0, 0, -1.6])
                  cylinder(h=3.2, d1=3, d2=3, $fa=6, $fs=0.5);
              }
            translate(v=[0, 0, 43.77777777777778])
              // ring
              // ring
              difference(){
                // outer
                translate(v=[0, 0, -1.5])
                  cylinder(h=3, d1=60, d2=60, $fa=6, $fs=0.5);
                // inner
                translate(v=[0, 0, -1.6])
                  cylinder(h=3.2, d1=3, d2=3, $fa=6, $fs=0.5);
              }
            translate(v=[0, 0, 65.66666666666667])
              // ring
              // ring
              difference(){
                // outer
                translate(v=[0, 0, -1.5])
                  cylinder(h=3, d1=60, d2=60, $fa=6, $fs=0.5);
                // inner
                translate(v=[0, 0, -1.6])
                  cylinder(h=3.2, d1=3, d2=3, $fa=6, $fs=0.5);
              }
            translate(v=[0, 0, 87.55555555555556])
              // ring
              // ring
              difference(){
                // outer
                translate(v=[0, 0, -1.5])
                  cylinder(h=3, d1=60, d2=60, $fa=6, $fs=0.5);
                // inner
                translate(v=[0, 0, -1.6])
                  cylinder(h=3.2, d1=3, d2=3, $fa=6, $fs=0.5);
              }
            translate(v=[0, 0, 109.44444444444444])
              // ring
              // ring
              difference(){
                // outer
                translate(v=[0, 0, -1.5])
                  cylinder(h=3, d1=60, d2=60, $fa=6, $fs=0.5);
                // inner
                translate(v=[0, 0, -1.6])
                  cylinder(h=3.2, d1=3, d2=3, $fa=6, $fs=0.5);
              }
            translate(v=[0, 0, 131.33333333333334])
              // ring
              // ring
              difference(){
                // outer
                translate(v=[0, 0, -1.5])
                  cylinder(h=3, d1=60, d2=60, $fa=6, $fs=0.5);
                // inner
                translate(v=[0, 0, -1.6])
                  cylinder(h=3.2, d1=3, d2=3, $fa=6, $fs=0.5);
              }
            translate(v=[0, 0, 153.22222222222223])
              // ring
              // ring
              difference(){
                // outer
                translate(v=[0, 0, -1.5])
                  cylinder(h=3, d1=60, d2=60, $fa=6, $fs=0.5);
                // inner
                translate(v=[0, 0, -1.6])
                  cylinder(h=3.2, d1=3, d2=3, $fa=6, $fs=0.5);
              }
            translate(v=[0, 0, 175.11111111111111])
              // ring
              // ring
              difference(){
                // outer
                translate(v=[0, 0, -1.5])
                  cylinder(h=3, d1=60, d2=60, $fa=6, $fs=0.5);
                // inner
                translate(v=[0, 0, -1.6])
                  cylinder(h=3.2, d1=3, d2=3, $fa=6, $fs=0.5);
              }
            translate(v=[0, 0, 197])
              // ring
              // ring
              difference(){
                // outer
                translate(v=[0, 0, -1.5])
                  cylinder(h=3, d1=60, d2=60, $fa=6, $fs=0.5);
                // inner
                translate(v=[0, 0, -1.6])
                  cylinder(h=3.2, d1=3, d2=3, $fa=6, $fs=0.5);
              }
          }
      }
    translate(v=[0, 500, 0])
      translate(v=[-500, -500, -500])
        cube(size=[1000, 1000, 1000]);
  }