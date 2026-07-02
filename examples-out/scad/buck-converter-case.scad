
union(){
  // place lid
  translate(v=[0, 45, 0])
    translate(v=[0, 0, 20])
      rotate(a=[180, 0, 0])
        // lid
        difference(){
          // outer box
          translate(v=[-30, -17.5, 0])
            cube(size=[60, 35, 20]);
          // inner box
          translate(v=[0, 0, -0.1])
            translate(v=[-28.5, -16, 0])
              cube(size=[57, 32, 18.6]);
          // screw holes
          union(){
            translate(v=[26, 13.5, 0])
              // screw hole
              translate(v=[0, 0, -100])
                cylinder(h=200, d1=2.5, d2=2.5, $fa=6, $fs=0.5);
            translate(v=[26, -13.5, 0])
              // screw hole
              translate(v=[0, 0, -100])
                cylinder(h=200, d1=2.5, d2=2.5, $fa=6, $fs=0.5);
            translate(v=[-26, 13.5, 0])
              // screw hole
              translate(v=[0, 0, -100])
                cylinder(h=200, d1=2.5, d2=2.5, $fa=6, $fs=0.5);
            translate(v=[-26, -13.5, 0])
              // screw hole
              translate(v=[0, 0, -100])
                cylinder(h=200, d1=2.5, d2=2.5, $fa=6, $fs=0.5);
          }
          // tunnel
          rotate(a=[0, 90, 0])
            linear_extrude(height=100, center=true, convexity=10)
              translate(v=[0, 0, 0])
                resize(newsize=[34, 32])
                  translate(v=[0, 0, 0])
                    circle(d=34, $fa=6, $fs=0.5);
        }
  difference(){
    union(){
      // wall
      difference(){
        // base box
        difference(){
          translate(v=[-28, -15.5, 0])
            cube(size=[56, 31, 18]);
          translate(v=[0, 0, 1.5])
            translate(v=[-26.5, -14, 0])
              cube(size=[53, 28, 16.6]);
        }
        // half pipe
        translate(v=[0, 0, 21])
          rotate(a=[90, 0, 0])
            linear_extrude(height=31.2, center=true, convexity=10)
              #
              translate(v=[0, 0, 0])
                resize(newsize=[53, 36])
                  translate(v=[0, 0, 0])
                    circle(d=53, $fa=6, $fs=0.5);
      }
      // pillars
      union(){
        translate(v=[26, 13.5, 0])
          // pillar
          translate(v=[-2, -2, 0])
            cube(size=[4, 4, 18]);
        translate(v=[26, -13.5, 0])
          // pillar
          translate(v=[-2, -2, 0])
            cube(size=[4, 4, 18]);
        translate(v=[-26, 13.5, 0])
          // pillar
          translate(v=[-2, -2, 0])
            cube(size=[4, 4, 18]);
        translate(v=[-26, -13.5, 0])
          // pillar
          translate(v=[-2, -2, 0])
            cube(size=[4, 4, 18]);
      }
    }
    // wire holes
    translate(v=[0, 0, 9])
      rotate(a=[0, 90, 0])
        translate(v=[0, 0, -100])
          cylinder(h=200, d1=4, d2=4, $fa=6, $fs=0.5);
    // screw holders
    union(){
      translate(v=[26, 13.5, 0])
        // screw holder
        translate(v=[0, 0, 13])
          translate(v=[0, 0, 0])
            cylinder(h=5.1, d1=2.5, d2=2.5, $fa=6, $fs=0.5);
      translate(v=[26, -13.5, 0])
        // screw holder
        translate(v=[0, 0, 13])
          translate(v=[0, 0, 0])
            cylinder(h=5.1, d1=2.5, d2=2.5, $fa=6, $fs=0.5);
      translate(v=[-26, 13.5, 0])
        // screw holder
        translate(v=[0, 0, 13])
          translate(v=[0, 0, 0])
            cylinder(h=5.1, d1=2.5, d2=2.5, $fa=6, $fs=0.5);
      translate(v=[-26, -13.5, 0])
        // screw holder
        translate(v=[0, 0, 13])
          translate(v=[0, 0, 0])
            cylinder(h=5.1, d1=2.5, d2=2.5, $fa=6, $fs=0.5);
    }
  }
}