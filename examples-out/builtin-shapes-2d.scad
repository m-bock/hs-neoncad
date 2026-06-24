
union(){
  translate(v=[0, 0, 0])
    // row Circle
    union(){
      // row label
      translate(v=[-100, 0, 0])
        translate(v=[0, -170, 0])
          scale(v=[2, 2, 2])
            linear_extrude(height=2, convexity=10)
              text(text="Circle", $fa=6, $fs=0.5);
      // cells
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
                        translate(v=[-100, -100, 0])
                          square(size=[200, 200]);
                  // Label
                  translate(v=[-90, -90, 0])
                    color(c=[0.894, 0.341, 0.337], alpha=1)
                      linear_extrude(height=1, convexity=10)
                        text(text="Default", $fa=6, $fs=0.5);
                  // Axis
                  color(c=[0.894, 0.341, 0.337], alpha=1)
                    union(){
                      // X
                      translate(v=[-0.5, -100, -0.5])
                        cube(size=[1, 200, 1]);
                      // Y
                      translate(v=[-100, -0.5, -0.5])
                        cube(size=[200, 1, 1]);
                      // Z
                      translate(v=[-0.5, -0.5, -100])
                        cube(size=[1, 1, 200]);
                    }
                }
                // Model
                union()
                  // color 0
                  color(c=[0.298, 0.471, 0.659], alpha=0.7)
                    linear_extrude(height=0.8, convexity=10)
                      difference(){
                        offset(delta=0.5)
                          translate(v=[0, 0, 0])
                            circle(d=100, $fa=6, $fs=0.5);
                        offset(delta=-0.5)
                          translate(v=[0, 0, 0])
                            circle(d=100, $fa=6, $fs=0.5);
                      }
              }
        translate(v=[0, 230, 0])
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
                        translate(v=[-100, -100, 0])
                          square(size=[200, 200]);
                  // Label
                  translate(v=[-90, -90, 0])
                    color(c=[0.894, 0.341, 0.337], alpha=1)
                      linear_extrude(height=1, convexity=10)
                        text(text="radius vs diameter", $fa=6, $fs=0.5);
                  // Axis
                  color(c=[0.894, 0.341, 0.337], alpha=1)
                    union(){
                      // X
                      translate(v=[-0.5, -100, -0.5])
                        cube(size=[1, 200, 1]);
                      // Y
                      translate(v=[-100, -0.5, -0.5])
                        cube(size=[200, 1, 1]);
                      // Z
                      translate(v=[-0.5, -0.5, -100])
                        cube(size=[1, 1, 200]);
                    }
                }
                // Model
                union(){
                  // color 0
                  color(c=[0.298, 0.471, 0.659], alpha=0.7)
                    linear_extrude(height=0.8, convexity=10)
                      difference(){
                        offset(delta=0.5)
                          translate(v=[0, 0, 0])
                            circle(d=100, $fa=6, $fs=0.5);
                        offset(delta=-0.5)
                          translate(v=[0, 0, 0])
                            circle(d=100, $fa=6, $fs=0.5);
                      }
                  // color 1
                  color(c=[0.961, 0.522, 9.4e-2], alpha=0.7)
                    linear_extrude(height=0.8, convexity=10)
                      difference(){
                        offset(delta=0.5)
                          translate(v=[0, 0, 0])
                            circle(d=50, $fa=6, $fs=0.5);
                        offset(delta=-0.5)
                          translate(v=[0, 0, 0])
                            circle(d=50, $fa=6, $fs=0.5);
                      }
                }
              }
        translate(v=[0, 460, 0])
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
                        translate(v=[-100, -100, 0])
                          square(size=[200, 200]);
                  // Label
                  translate(v=[-90, -90, 0])
                    color(c=[0.894, 0.341, 0.337], alpha=1)
                      linear_extrude(height=1, convexity=10)
                        text(text="placements", $fa=6, $fs=0.5);
                  // Axis
                  color(c=[0.894, 0.341, 0.337], alpha=1)
                    union(){
                      // X
                      translate(v=[-0.5, -100, -0.5])
                        cube(size=[1, 200, 1]);
                      // Y
                      translate(v=[-100, -0.5, -0.5])
                        cube(size=[200, 1, 1]);
                      // Z
                      translate(v=[-0.5, -0.5, -100])
                        cube(size=[1, 1, 200]);
                    }
                }
                // Model
                union(){
                  // color 0
                  color(c=[0.298, 0.471, 0.659], alpha=0.7)
                    linear_extrude(height=0.8, convexity=10)
                      difference(){
                        offset(delta=0.5)
                          translate(v=[25, 25, 0])
                            circle(d=50, $fa=6, $fs=0.5);
                        offset(delta=-0.5)
                          translate(v=[25, 25, 0])
                            circle(d=50, $fa=6, $fs=0.5);
                      }
                  // color 1
                  color(c=[0.961, 0.522, 9.4e-2], alpha=0.7)
                    linear_extrude(height=0.8, convexity=10)
                      difference(){
                        offset(delta=0.5)
                          translate(v=[0, 0, 0])
                            circle(d=50, $fa=6, $fs=0.5);
                        offset(delta=-0.5)
                          translate(v=[0, 0, 0])
                            circle(d=50, $fa=6, $fs=0.5);
                      }
                }
              }
      }
    }
  translate(v=[250, 0, 0])
    // row Ellipse
    union(){
      // row label
      translate(v=[-100, 0, 0])
        translate(v=[0, -170, 0])
          scale(v=[2, 2, 2])
            linear_extrude(height=2, convexity=10)
              text(text="Ellipse", $fa=6, $fs=0.5);
      // cells
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
                        translate(v=[-100, -100, 0])
                          square(size=[200, 200]);
                  // Label
                  translate(v=[-90, -90, 0])
                    color(c=[0.894, 0.341, 0.337], alpha=1)
                      linear_extrude(height=1, convexity=10)
                        text(text="Default", $fa=6, $fs=0.5);
                  // Axis
                  color(c=[0.894, 0.341, 0.337], alpha=1)
                    union(){
                      // X
                      translate(v=[-0.5, -100, -0.5])
                        cube(size=[1, 200, 1]);
                      // Y
                      translate(v=[-100, -0.5, -0.5])
                        cube(size=[200, 1, 1]);
                      // Z
                      translate(v=[-0.5, -0.5, -100])
                        cube(size=[1, 1, 200]);
                    }
                }
                // Model
                union()
                  // color 0
                  color(c=[0.298, 0.471, 0.659], alpha=0.7)
                    linear_extrude(height=0.8, convexity=10)
                      difference(){
                        offset(delta=0.5)
                          translate(v=[0, 0, 0])
                            resize(newsize=[142.7299292922217, 89.20620580763855])
                              translate(v=[0, 0, 0])
                                circle(d=142.7299292922217, $fa=6, $fs=0.5);
                        offset(delta=-0.5)
                          translate(v=[0, 0, 0])
                            resize(newsize=[142.7299292922217, 89.20620580763855])
                              translate(v=[0, 0, 0])
                                circle(d=142.7299292922217, $fa=6, $fs=0.5);
                      }
              }
        translate(v=[0, 230, 0])
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
                        translate(v=[-100, -100, 0])
                          square(size=[200, 200]);
                  // Label
                  translate(v=[-90, -90, 0])
                    color(c=[0.894, 0.341, 0.337], alpha=1)
                      linear_extrude(height=1, convexity=10)
                        text(text="placements", $fa=6, $fs=0.5);
                  // Axis
                  color(c=[0.894, 0.341, 0.337], alpha=1)
                    union(){
                      // X
                      translate(v=[-0.5, -100, -0.5])
                        cube(size=[1, 200, 1]);
                      // Y
                      translate(v=[-100, -0.5, -0.5])
                        cube(size=[200, 1, 1]);
                      // Z
                      translate(v=[-0.5, -0.5, -100])
                        cube(size=[1, 1, 200]);
                    }
                }
                // Model
                union(){
                  // color 0
                  color(c=[0.298, 0.471, 0.659], alpha=0.7)
                    linear_extrude(height=0.8, convexity=10)
                      difference(){
                        offset(delta=0.5)
                          translate(v=[25, 15, 0])
                            resize(newsize=[50, 30])
                              translate(v=[0, 0, 0])
                                circle(d=50, $fa=6, $fs=0.5);
                        offset(delta=-0.5)
                          translate(v=[25, 15, 0])
                            resize(newsize=[50, 30])
                              translate(v=[0, 0, 0])
                                circle(d=50, $fa=6, $fs=0.5);
                      }
                  // color 1
                  color(c=[0.961, 0.522, 9.4e-2], alpha=0.7)
                    linear_extrude(height=0.8, convexity=10)
                      difference(){
                        offset(delta=0.5)
                          translate(v=[0, 0, 0])
                            resize(newsize=[50, 30])
                              translate(v=[0, 0, 0])
                                circle(d=50, $fa=6, $fs=0.5);
                        offset(delta=-0.5)
                          translate(v=[0, 0, 0])
                            resize(newsize=[50, 30])
                              translate(v=[0, 0, 0])
                                circle(d=50, $fa=6, $fs=0.5);
                      }
                }
              }
      }
    }
  translate(v=[500, 0, 0])
    // row Rect
    union(){
      // row label
      translate(v=[-100, 0, 0])
        translate(v=[0, -170, 0])
          scale(v=[2, 2, 2])
            linear_extrude(height=2, convexity=10)
              text(text="Rect", $fa=6, $fs=0.5);
      // cells
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
                        translate(v=[-100, -100, 0])
                          square(size=[200, 200]);
                  // Label
                  translate(v=[-90, -90, 0])
                    color(c=[0.894, 0.341, 0.337], alpha=1)
                      linear_extrude(height=1, convexity=10)
                        text(text="Default", $fa=6, $fs=0.5);
                  // Axis
                  color(c=[0.894, 0.341, 0.337], alpha=1)
                    union(){
                      // X
                      translate(v=[-0.5, -100, -0.5])
                        cube(size=[1, 200, 1]);
                      // Y
                      translate(v=[-100, -0.5, -0.5])
                        cube(size=[200, 1, 1]);
                      // Z
                      translate(v=[-0.5, -0.5, -100])
                        cube(size=[1, 1, 200]);
                    }
                }
                // Model
                union()
                  // color 0
                  color(c=[0.298, 0.471, 0.659], alpha=0.7)
                    linear_extrude(height=0.8, convexity=10)
                      difference(){
                        offset(delta=0.5)
                          translate(v=[-63.245553203367585, -39.528470752104745, 0])
                            square(size=[126.49110640673517, 79.05694150420949]);
                        offset(delta=-0.5)
                          translate(v=[-63.245553203367585, -39.528470752104745, 0])
                            square(size=[126.49110640673517, 79.05694150420949]);
                      }
              }
        translate(v=[0, 230, 0])
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
                        translate(v=[-100, -100, 0])
                          square(size=[200, 200]);
                  // Label
                  translate(v=[-90, -90, 0])
                    color(c=[0.894, 0.341, 0.337], alpha=1)
                      linear_extrude(height=1, convexity=10)
                        text(text="Size, (50, 30)", $fa=6, $fs=0.5);
                  // Axis
                  color(c=[0.894, 0.341, 0.337], alpha=1)
                    union(){
                      // X
                      translate(v=[-0.5, -100, -0.5])
                        cube(size=[1, 200, 1]);
                      // Y
                      translate(v=[-100, -0.5, -0.5])
                        cube(size=[200, 1, 1]);
                      // Z
                      translate(v=[-0.5, -0.5, -100])
                        cube(size=[1, 1, 200]);
                    }
                }
                // Model
                union()
                  // color 0
                  color(c=[0.298, 0.471, 0.659], alpha=0.7)
                    linear_extrude(height=0.8, convexity=10)
                      difference(){
                        offset(delta=0.5)
                          translate(v=[-25, -15, 0])
                            square(size=[50, 30]);
                        offset(delta=-0.5)
                          translate(v=[-25, -15, 0])
                            square(size=[50, 30]);
                      }
              }
        translate(v=[0, 460, 0])
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
                        translate(v=[-100, -100, 0])
                          square(size=[200, 200]);
                  // Label
                  translate(v=[-90, -90, 0])
                    color(c=[0.894, 0.341, 0.337], alpha=1)
                      linear_extrude(height=1, convexity=10)
                        text(text="placements", $fa=6, $fs=0.5);
                  // Axis
                  color(c=[0.894, 0.341, 0.337], alpha=1)
                    union(){
                      // X
                      translate(v=[-0.5, -100, -0.5])
                        cube(size=[1, 200, 1]);
                      // Y
                      translate(v=[-100, -0.5, -0.5])
                        cube(size=[200, 1, 1]);
                      // Z
                      translate(v=[-0.5, -0.5, -100])
                        cube(size=[1, 1, 200]);
                    }
                }
                // Model
                union(){
                  // color 0
                  color(c=[0.298, 0.471, 0.659], alpha=0.7)
                    linear_extrude(height=0.8, convexity=10)
                      difference(){
                        offset(delta=0.5)
                          translate(v=[0, 0, 0])
                            square(size=[50, 30]);
                        offset(delta=-0.5)
                          translate(v=[0, 0, 0])
                            square(size=[50, 30]);
                      }
                  // color 1
                  color(c=[0.961, 0.522, 9.4e-2], alpha=0.7)
                    linear_extrude(height=0.8, convexity=10)
                      difference(){
                        offset(delta=0.5)
                          translate(v=[-25, -15, 0])
                            square(size=[50, 30]);
                        offset(delta=-0.5)
                          translate(v=[-25, -15, 0])
                            square(size=[50, 30]);
                      }
                }
              }
      }
    }
  translate(v=[750, 0, 0])
    // row Square
    union(){
      // row label
      translate(v=[-100, 0, 0])
        translate(v=[0, -170, 0])
          scale(v=[2, 2, 2])
            linear_extrude(height=2, convexity=10)
              text(text="Square", $fa=6, $fs=0.5);
      // cells
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
                        translate(v=[-100, -100, 0])
                          square(size=[200, 200]);
                  // Label
                  translate(v=[-90, -90, 0])
                    color(c=[0.894, 0.341, 0.337], alpha=1)
                      linear_extrude(height=1, convexity=10)
                        text(text="Default", $fa=6, $fs=0.5);
                  // Axis
                  color(c=[0.894, 0.341, 0.337], alpha=1)
                    union(){
                      // X
                      translate(v=[-0.5, -100, -0.5])
                        cube(size=[1, 200, 1]);
                      // Y
                      translate(v=[-100, -0.5, -0.5])
                        cube(size=[200, 1, 1]);
                      // Z
                      translate(v=[-0.5, -0.5, -100])
                        cube(size=[1, 1, 200]);
                    }
                }
                // Model
                union()
                  // color 0
                  color(c=[0.298, 0.471, 0.659], alpha=0.7)
                    linear_extrude(height=0.8, convexity=10)
                      difference(){
                        offset(delta=0.5)
                          translate(v=[-50, -50, 0])
                            square(size=[100, 100]);
                        offset(delta=-0.5)
                          translate(v=[-50, -50, 0])
                            square(size=[100, 100]);
                      }
              }
        translate(v=[0, 230, 0])
          // Sizes
          union()
            translate(v=[0, 0, -5])
              union(){
                // Field
                union(){
                  // Background
                  color(c=[1, 1, 1], alpha=1)
                    translate(v=[0, 0, -1])
                      linear_extrude(height=1, convexity=10)
                        translate(v=[-100, -100, 0])
                          square(size=[200, 200]);
                  // Label
                  translate(v=[-90, -90, 0])
                    color(c=[0.894, 0.341, 0.337], alpha=1)
                      linear_extrude(height=1, convexity=10)
                        text(text="Sizes", $fa=6, $fs=0.5);
                  // Axis
                  color(c=[0.894, 0.341, 0.337], alpha=1)
                    union(){
                      // X
                      translate(v=[-0.5, -100, -0.5])
                        cube(size=[1, 200, 1]);
                      // Y
                      translate(v=[-100, -0.5, -0.5])
                        cube(size=[200, 1, 1]);
                      // Z
                      translate(v=[-0.5, -0.5, -100])
                        cube(size=[1, 1, 200]);
                    }
                }
                // Model
                union(){
                  // color 0
                  color(c=[0.298, 0.471, 0.659], alpha=0.7)
                    linear_extrude(height=0.8, convexity=10)
                      difference(){
                        offset(delta=0.5)
                          translate(v=[-10, -10, 0])
                            square(size=[20, 20]);
                        offset(delta=-0.5)
                          translate(v=[-10, -10, 0])
                            square(size=[20, 20]);
                      }
                  // color 1
                  color(c=[0.961, 0.522, 9.4e-2], alpha=0.7)
                    linear_extrude(height=0.8, convexity=10)
                      difference(){
                        offset(delta=0.5)
                          translate(v=[-20, -20, 0])
                            square(size=[40, 40]);
                        offset(delta=-0.5)
                          translate(v=[-20, -20, 0])
                            square(size=[40, 40]);
                      }
                  // color 2
                  color(c=[0.329, 0.635, 0.294], alpha=0.7)
                    linear_extrude(height=0.8, convexity=10)
                      difference(){
                        offset(delta=0.5)
                          translate(v=[-30, -30, 0])
                            square(size=[60, 60]);
                        offset(delta=-0.5)
                          translate(v=[-30, -30, 0])
                            square(size=[60, 60]);
                      }
                  // color 3
                  color(c=[0.894, 0.341, 0.337], alpha=0.7)
                    linear_extrude(height=0.8, convexity=10)
                      difference(){
                        offset(delta=0.5)
                          translate(v=[-40, -40, 0])
                            square(size=[80, 80]);
                        offset(delta=-0.5)
                          translate(v=[-40, -40, 0])
                            square(size=[80, 80]);
                      }
                  // color 4
                  color(c=[0.698, 0.475, 0.635], alpha=0.7)
                    linear_extrude(height=0.8, convexity=10)
                      difference(){
                        offset(delta=0.5)
                          translate(v=[-50, -50, 0])
                            square(size=[100, 100]);
                        offset(delta=-0.5)
                          translate(v=[-50, -50, 0])
                            square(size=[100, 100]);
                      }
                }
              }
        translate(v=[0, 460, 0])
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
                        translate(v=[-100, -100, 0])
                          square(size=[200, 200]);
                  // Label
                  translate(v=[-90, -90, 0])
                    color(c=[0.894, 0.341, 0.337], alpha=1)
                      linear_extrude(height=1, convexity=10)
                        text(text="placements", $fa=6, $fs=0.5);
                  // Axis
                  color(c=[0.894, 0.341, 0.337], alpha=1)
                    union(){
                      // X
                      translate(v=[-0.5, -100, -0.5])
                        cube(size=[1, 200, 1]);
                      // Y
                      translate(v=[-100, -0.5, -0.5])
                        cube(size=[200, 1, 1]);
                      // Z
                      translate(v=[-0.5, -0.5, -100])
                        cube(size=[1, 1, 200]);
                    }
                }
                // Model
                union(){
                  // color 0
                  color(c=[0.298, 0.471, 0.659], alpha=0.7)
                    linear_extrude(height=0.8, convexity=10)
                      difference(){
                        offset(delta=0.5)
                          translate(v=[0, 0, 0])
                            square(size=[50, 50]);
                        offset(delta=-0.5)
                          translate(v=[0, 0, 0])
                            square(size=[50, 50]);
                      }
                  // color 1
                  color(c=[0.961, 0.522, 9.4e-2], alpha=0.7)
                    linear_extrude(height=0.8, convexity=10)
                      difference(){
                        offset(delta=0.5)
                          translate(v=[-25, -25, 0])
                            square(size=[50, 50]);
                        offset(delta=-0.5)
                          translate(v=[-25, -25, 0])
                            square(size=[50, 50]);
                      }
                }
              }
      }
    }
  translate(v=[1000, 0, 0])
    // row Polygon
    union(){
      // row label
      translate(v=[-100, 0, 0])
        translate(v=[0, -170, 0])
          scale(v=[2, 2, 2])
            linear_extrude(height=2, convexity=10)
              text(text="Polygon", $fa=6, $fs=0.5);
      // cells
      union()
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
                        translate(v=[-100, -100, 0])
                          square(size=[200, 200]);
                  // Label
                  translate(v=[-90, -90, 0])
                    color(c=[0.894, 0.341, 0.337], alpha=1)
                      linear_extrude(height=1, convexity=10)
                        text(text="Default", $fa=6, $fs=0.5);
                  // Axis
                  color(c=[0.894, 0.341, 0.337], alpha=1)
                    union(){
                      // X
                      translate(v=[-0.5, -100, -0.5])
                        cube(size=[1, 200, 1]);
                      // Y
                      translate(v=[-100, -0.5, -0.5])
                        cube(size=[200, 1, 1]);
                      // Z
                      translate(v=[-0.5, -0.5, -100])
                        cube(size=[1, 1, 200]);
                    }
                }
                // Model
                union()
                  // color 0
                  color(c=[0.298, 0.471, 0.659], alpha=0.7)
                    linear_extrude(height=0.8, convexity=10)
                      difference(){
                        offset(delta=0.5)
                          polygon(points=[[0, 57.735026918962575], [57.735026918962575, 57.735026918962575], [57.735026918962575, 0], [0, -57.735026918962575], [-57.735026918962575, -57.735026918962575], [-57.735026918962575, 0]], convexity=10);
                        offset(delta=-0.5)
                          polygon(points=[[0, 57.735026918962575], [57.735026918962575, 57.735026918962575], [57.735026918962575, 0], [0, -57.735026918962575], [-57.735026918962575, -57.735026918962575], [-57.735026918962575, 0]], convexity=10);
                      }
              }
    }
  translate(v=[1250, 0, 0])
    // row Text
    union(){
      // row label
      translate(v=[-100, 0, 0])
        translate(v=[0, -170, 0])
          scale(v=[2, 2, 2])
            linear_extrude(height=2, convexity=10)
              text(text="Text", $fa=6, $fs=0.5);
      // cells
      union()
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
                        translate(v=[-100, -100, 0])
                          square(size=[200, 200]);
                  // Label
                  translate(v=[-90, -90, 0])
                    color(c=[0.894, 0.341, 0.337], alpha=1)
                      linear_extrude(height=1, convexity=10)
                        text(text="Default", $fa=6, $fs=0.5);
                  // Axis
                  color(c=[0.894, 0.341, 0.337], alpha=1)
                    union(){
                      // X
                      translate(v=[-0.5, -100, -0.5])
                        cube(size=[1, 200, 1]);
                      // Y
                      translate(v=[-100, -0.5, -0.5])
                        cube(size=[200, 1, 1]);
                      // Z
                      translate(v=[-0.5, -0.5, -100])
                        cube(size=[1, 1, 200]);
                    }
                }
                // Model
                union()
                  // color 0
                  color(c=[0.298, 0.471, 0.659], alpha=0.7)
                    linear_extrude(height=0.8, convexity=10)
                      difference(){
                        offset(delta=0.5)
                          text(text="Hello, World!", $fa=6, $fs=0.5);
                        offset(delta=-0.5)
                          text(text="Hello, World!", $fa=6, $fs=0.5);
                      }
              }
    }
}