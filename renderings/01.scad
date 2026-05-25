
union(){
  // Circle
  translate(v=[0, 0, 0])
    union(){
      translate(v=[-200, 0, 0])
        scale(v=[2, 2, 2])
          linear_extrude(height=2, convexity=10)
            text(text="Circle", $fa=6, $fs=0.5);
      union(){
        translate(v=[0, 0, 0])
          // radius vs diameter
          union()
            translate(v=[0, 0, -5])
              union(){
                // Field
                union(){
                  // Background
                  color(c=[1, 1, 1], alpha=1)
                    translate(v=[0, 0, -1])
                      linear_extrude(height=1, convexity=10)
                        square(size=[200, 200], center=true);
                  // Label
                  translate(v=[-90, -90, 0])
                    color(c=[0.894, 0.341, 0.337])
                      linear_extrude(height=1, convexity=10)
                        text(text="radius vs diameter", $fa=6, $fs=0.5);
                  // Axis
                  color(c=[0.894, 0.341, 0.337])
                    union(){
                      // X
                      cube(size=[1, 200, 1], center=true);
                      // Y
                      cube(size=[200, 1, 1], center=true);
                      // Z
                      cube(size=[1, 1, 200], center=true);
                    }
                }
                union(){
                  color(c=[0.298, 0.471, 0.659], alpha=0.7)
                    translate(v=[0, 0, 0])
                      linear_extrude(height=0.8, convexity=10)
                        circle(d=100, $fa=6, $fs=0.5);
                  color(c=[0.961, 0.522, 9.4e-2], alpha=0.7)
                    translate(v=[0, 0, 1])
                      linear_extrude(height=0.8, convexity=10)
                        circle(d=50, $fa=6, $fs=0.5);
                }
              }
        translate(v=[210, 0, 0])
          // placements
          union()
            translate(v=[0, 0, -5])
              union(){
                // Field
                union(){
                  // Background
                  color(c=[1, 1, 1], alpha=1)
                    translate(v=[0, 0, -1])
                      linear_extrude(height=1, convexity=10)
                        square(size=[200, 200], center=true);
                  // Label
                  translate(v=[-90, -90, 0])
                    color(c=[0.894, 0.341, 0.337])
                      linear_extrude(height=1, convexity=10)
                        text(text="placements", $fa=6, $fs=0.5);
                  // Axis
                  color(c=[0.894, 0.341, 0.337])
                    union(){
                      // X
                      cube(size=[1, 200, 1], center=true);
                      // Y
                      cube(size=[200, 1, 1], center=true);
                      // Z
                      cube(size=[1, 1, 200], center=true);
                    }
                }
                union(){
                  color(c=[0.298, 0.471, 0.659], alpha=0.7)
                    translate(v=[0, 0, 0])
                      linear_extrude(height=0.8, convexity=10)
                        translate(v=[25, 0, 0])
                          translate(v=[0, 25, 0])
                            circle(d=50, $fa=6, $fs=0.5);
                  color(c=[0.961, 0.522, 9.4e-2], alpha=0.7)
                    translate(v=[0, 0, 1])
                      linear_extrude(height=0.8, convexity=10)
                        translate(v=[25, 0, 0])
                          circle(d=50, $fa=6, $fs=0.5);
                  color(c=[0.329, 0.635, 0.294], alpha=0.7)
                    translate(v=[0, 0, 2])
                      linear_extrude(height=0.8, convexity=10)
                        translate(v=[25, 0, 0])
                          translate(v=[0, -25, 0])
                            circle(d=50, $fa=6, $fs=0.5);
                  color(c=[0.894, 0.341, 0.337], alpha=0.7)
                    translate(v=[0, 0, 3])
                      linear_extrude(height=0.8, convexity=10)
                        translate(v=[0, 25, 0])
                          circle(d=50, $fa=6, $fs=0.5);
                  color(c=[0.698, 0.475, 0.635], alpha=0.7)
                    translate(v=[0, 0, 4])
                      linear_extrude(height=0.8, convexity=10)
                        circle(d=50, $fa=6, $fs=0.5);
                  color(c=[0.447, 0.718, 0.698], alpha=0.7)
                    translate(v=[0, 0, 5])
                      linear_extrude(height=0.8, convexity=10)
                        translate(v=[0, -25, 0])
                          circle(d=50, $fa=6, $fs=0.5);
                  color(c=[0.855, 0.647, 0.125], alpha=0.7)
                    translate(v=[0, 0, 6])
                      linear_extrude(height=0.8, convexity=10)
                        translate(v=[-25, 0, 0])
                          translate(v=[0, 25, 0])
                            circle(d=50, $fa=6, $fs=0.5);
                  color(c=[0.906, 0.541, 0.765], alpha=0.7)
                    translate(v=[0, 0, 7])
                      linear_extrude(height=0.8, convexity=10)
                        translate(v=[-25, 0, 0])
                          circle(d=50, $fa=6, $fs=0.5);
                  color(c=[0.337, 0.706, 0.914], alpha=0.7)
                    translate(v=[0, 0, 8])
                      linear_extrude(height=0.8, convexity=10)
                        translate(v=[-25, 0, 0])
                          translate(v=[0, -25, 0])
                            circle(d=50, $fa=6, $fs=0.5);
                }
              }
      }
    }
  // Rect
  translate(v=[0, 210, 0])
    union(){
      translate(v=[-200, 0, 0])
        scale(v=[2, 2, 2])
          linear_extrude(height=2, convexity=10)
            text(text="Rect", $fa=6, $fs=0.5);
      union(){
        translate(v=[0, 0, 0])
          // Default
          union()
            translate(v=[0, 0, -5])
              union(){
                // Field
                union(){
                  // Background
                  color(c=[1, 1, 1], alpha=1)
                    translate(v=[0, 0, -1])
                      linear_extrude(height=1, convexity=10)
                        square(size=[200, 200], center=true);
                  // Label
                  translate(v=[-90, -90, 0])
                    color(c=[0.894, 0.341, 0.337])
                      linear_extrude(height=1, convexity=10)
                        text(text="Default", $fa=6, $fs=0.5);
                  // Axis
                  color(c=[0.894, 0.341, 0.337])
                    union(){
                      // X
                      cube(size=[1, 200, 1], center=true);
                      // Y
                      cube(size=[200, 1, 1], center=true);
                      // Z
                      cube(size=[1, 1, 200], center=true);
                    }
                }
                linear_extrude(height=10, convexity=10)
                  square(size=[100, 100], center=true);
              }
        translate(v=[210, 0, 0])
          // Size, (50, 30)
          union()
            translate(v=[0, 0, -5])
              union(){
                // Field
                union(){
                  // Background
                  color(c=[1, 1, 1], alpha=1)
                    translate(v=[0, 0, -1])
                      linear_extrude(height=1, convexity=10)
                        square(size=[200, 200], center=true);
                  // Label
                  translate(v=[-90, -90, 0])
                    color(c=[0.894, 0.341, 0.337])
                      linear_extrude(height=1, convexity=10)
                        text(text="Size, (50, 30)", $fa=6, $fs=0.5);
                  // Axis
                  color(c=[0.894, 0.341, 0.337])
                    union(){
                      // X
                      cube(size=[1, 200, 1], center=true);
                      // Y
                      cube(size=[200, 1, 1], center=true);
                      // Z
                      cube(size=[1, 1, 200], center=true);
                    }
                }
                linear_extrude(height=10, convexity=10)
                  square(size=[50, 30], center=true);
              }
        translate(v=[420, 0, 0])
          // placements
          union()
            translate(v=[0, 0, -5])
              union(){
                // Field
                union(){
                  // Background
                  color(c=[1, 1, 1], alpha=1)
                    translate(v=[0, 0, -1])
                      linear_extrude(height=1, convexity=10)
                        square(size=[200, 200], center=true);
                  // Label
                  translate(v=[-90, -90, 0])
                    color(c=[0.894, 0.341, 0.337])
                      linear_extrude(height=1, convexity=10)
                        text(text="placements", $fa=6, $fs=0.5);
                  // Axis
                  color(c=[0.894, 0.341, 0.337])
                    union(){
                      // X
                      cube(size=[1, 200, 1], center=true);
                      // Y
                      cube(size=[200, 1, 1], center=true);
                      // Z
                      cube(size=[1, 1, 200], center=true);
                    }
                }
                union(){
                  color(c=[0.298, 0.471, 0.659], alpha=0.7)
                    translate(v=[0, 0, 0])
                      linear_extrude(height=0.8, convexity=10)
                        square(size=[50, 30]);
                  color(c=[0.961, 0.522, 9.4e-2], alpha=0.7)
                    translate(v=[0, 0, 1])
                      linear_extrude(height=0.8, convexity=10)
                        translate(v=[0, -15, 0])
                          square(size=[50, 30]);
                  color(c=[0.329, 0.635, 0.294], alpha=0.7)
                    translate(v=[0, 0, 2])
                      linear_extrude(height=0.8, convexity=10)
                        translate(v=[0, -30, 0])
                          square(size=[50, 30]);
                  color(c=[0.894, 0.341, 0.337], alpha=0.7)
                    translate(v=[0, 0, 3])
                      linear_extrude(height=0.8, convexity=10)
                        translate(v=[-25, 0, 0])
                          square(size=[50, 30]);
                  color(c=[0.698, 0.475, 0.635], alpha=0.7)
                    translate(v=[0, 0, 4])
                      linear_extrude(height=0.8, convexity=10)
                        square(size=[50, 30], center=true);
                  color(c=[0.447, 0.718, 0.698], alpha=0.7)
                    translate(v=[0, 0, 5])
                      linear_extrude(height=0.8, convexity=10)
                        translate(v=[-25, -30, 0])
                          square(size=[50, 30]);
                  color(c=[0.855, 0.647, 0.125], alpha=0.7)
                    translate(v=[0, 0, 6])
                      linear_extrude(height=0.8, convexity=10)
                        translate(v=[-50, 0, 0])
                          square(size=[50, 30]);
                  color(c=[0.906, 0.541, 0.765], alpha=0.7)
                    translate(v=[0, 0, 7])
                      linear_extrude(height=0.8, convexity=10)
                        translate(v=[-50, -15, 0])
                          square(size=[50, 30]);
                  color(c=[0.337, 0.706, 0.914], alpha=0.7)
                    translate(v=[0, 0, 8])
                      linear_extrude(height=0.8, convexity=10)
                        translate(v=[-50, -30, 0])
                          square(size=[50, 30]);
                }
              }
      }
    }
}