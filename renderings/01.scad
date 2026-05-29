
union(){
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
                      color(c=[0.894, 0.341, 0.337], alpha=1)
                        linear_extrude(height=1, convexity=10)
                          text(text="Default", $fa=6, $fs=0.5);
                    // Axis
                    color(c=[0.894, 0.341, 0.337], alpha=1)
                      union(){
                        // X
                        cube(size=[1, 200, 1], center=true);
                        // Y
                        cube(size=[200, 1, 1], center=true);
                        // Z
                        cube(size=[1, 1, 200], center=true);
                      }
                  }
                  // Model
                  linear_extrude(height=0.8, convexity=10)
                    difference(){
                      offset(delta=0.5)
                        circle(d=100, $fa=6, $fs=0.5);
                      offset(delta=-0.5)
                        circle(d=100, $fa=6, $fs=0.5);
                    }
                }
          translate(v=[210, 0, 0])
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
                      color(c=[0.894, 0.341, 0.337], alpha=1)
                        linear_extrude(height=1, convexity=10)
                          text(text="radius vs diameter", $fa=6, $fs=0.5);
                    // Axis
                    color(c=[0.894, 0.341, 0.337], alpha=1)
                      union(){
                        // X
                        cube(size=[1, 200, 1], center=true);
                        // Y
                        cube(size=[200, 1, 1], center=true);
                        // Z
                        cube(size=[1, 1, 200], center=true);
                      }
                  }
                  // Model
                  union(){
                    color(c=[0.298, 0.471, 0.659], alpha=0.7)
                      linear_extrude(height=0.8, convexity=10)
                        difference(){
                          offset(delta=0.5)
                            circle(d=100, $fa=6, $fs=0.5);
                          offset(delta=-0.5)
                            circle(d=100, $fa=6, $fs=0.5);
                        }
                    color(c=[0.961, 0.522, 9.4e-2], alpha=0.7)
                      linear_extrude(height=0.8, convexity=10)
                        difference(){
                          offset(delta=0.5)
                            circle(d=50, $fa=6, $fs=0.5);
                          offset(delta=-0.5)
                            circle(d=50, $fa=6, $fs=0.5);
                        }
                  }
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
                      color(c=[0.894, 0.341, 0.337], alpha=1)
                        linear_extrude(height=1, convexity=10)
                          text(text="placements", $fa=6, $fs=0.5);
                    // Axis
                    color(c=[0.894, 0.341, 0.337], alpha=1)
                      union(){
                        // X
                        cube(size=[1, 200, 1], center=true);
                        // Y
                        cube(size=[200, 1, 1], center=true);
                        // Z
                        cube(size=[1, 1, 200], center=true);
                      }
                  }
                  // Model
                  union(){
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
                    color(c=[0.961, 0.522, 9.4e-2], alpha=0.7)
                      linear_extrude(height=0.8, convexity=10)
                        difference(){
                          offset(delta=0.5)
                            circle(d=50, $fa=6, $fs=0.5);
                          offset(delta=-0.5)
                            circle(d=50, $fa=6, $fs=0.5);
                        }
                  }
                }
        }
      }
    // Ellipse
    translate(v=[0, 210, 0])
      union(){
        translate(v=[-200, 0, 0])
          scale(v=[2, 2, 2])
            linear_extrude(height=2, convexity=10)
              text(text="Ellipse", $fa=6, $fs=0.5);
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
                          square(size=[200, 200], center=true);
                    // Label
                    translate(v=[-90, -90, 0])
                      color(c=[0.894, 0.341, 0.337], alpha=1)
                        linear_extrude(height=1, convexity=10)
                          text(text="Default", $fa=6, $fs=0.5);
                    // Axis
                    color(c=[0.894, 0.341, 0.337], alpha=1)
                      union(){
                        // X
                        cube(size=[1, 200, 1], center=true);
                        // Y
                        cube(size=[200, 1, 1], center=true);
                        // Z
                        cube(size=[1, 1, 200], center=true);
                      }
                  }
                  // Model
                  linear_extrude(height=0.8, convexity=10)
                    difference(){
                      offset(delta=0.5)
                        resize(newsize=[142.7299292922217, 89.20620580763855])
                          circle(d=142.7299292922217, $fa=6, $fs=0.5);
                      offset(delta=-0.5)
                        resize(newsize=[142.7299292922217, 89.20620580763855])
                          circle(d=142.7299292922217, $fa=6, $fs=0.5);
                    }
                }
      }
    // Rect
    translate(v=[0, 420, 0])
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
                      color(c=[0.894, 0.341, 0.337], alpha=1)
                        linear_extrude(height=1, convexity=10)
                          text(text="Default", $fa=6, $fs=0.5);
                    // Axis
                    color(c=[0.894, 0.341, 0.337], alpha=1)
                      union(){
                        // X
                        cube(size=[1, 200, 1], center=true);
                        // Y
                        cube(size=[200, 1, 1], center=true);
                        // Z
                        cube(size=[1, 1, 200], center=true);
                      }
                  }
                  // Model
                  linear_extrude(height=0.8, convexity=10)
                    difference(){
                      offset(delta=0.5)
                        square(size=[126.49110640673517, 79.05694150420949], center=true);
                      offset(delta=-0.5)
                        square(size=[126.49110640673517, 79.05694150420949], center=true);
                    }
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
                      color(c=[0.894, 0.341, 0.337], alpha=1)
                        linear_extrude(height=1, convexity=10)
                          text(text="Size, (50, 30)", $fa=6, $fs=0.5);
                    // Axis
                    color(c=[0.894, 0.341, 0.337], alpha=1)
                      union(){
                        // X
                        cube(size=[1, 200, 1], center=true);
                        // Y
                        cube(size=[200, 1, 1], center=true);
                        // Z
                        cube(size=[1, 1, 200], center=true);
                      }
                  }
                  // Model
                  linear_extrude(height=0.8, convexity=10)
                    difference(){
                      offset(delta=0.5)
                        square(size=[50, 30], center=true);
                      offset(delta=-0.5)
                        square(size=[50, 30], center=true);
                    }
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
                      color(c=[0.894, 0.341, 0.337], alpha=1)
                        linear_extrude(height=1, convexity=10)
                          text(text="placements", $fa=6, $fs=0.5);
                    // Axis
                    color(c=[0.894, 0.341, 0.337], alpha=1)
                      union(){
                        // X
                        cube(size=[1, 200, 1], center=true);
                        // Y
                        cube(size=[200, 1, 1], center=true);
                        // Z
                        cube(size=[1, 1, 200], center=true);
                      }
                  }
                  // Model
                  union(){
                    color(c=[0.298, 0.471, 0.659], alpha=0.7)
                      linear_extrude(height=0.8, convexity=10)
                        difference(){
                          offset(delta=0.5)
                            square(size=[50, 30]);
                          offset(delta=-0.5)
                            square(size=[50, 30]);
                        }
                    color(c=[0.961, 0.522, 9.4e-2], alpha=0.7)
                      linear_extrude(height=0.8, convexity=10)
                        difference(){
                          offset(delta=0.5)
                            square(size=[50, 30], center=true);
                          offset(delta=-0.5)
                            square(size=[50, 30], center=true);
                        }
                  }
                }
        }
      }
    // Square
    translate(v=[0, 630, 0])
      union(){
        translate(v=[-200, 0, 0])
          scale(v=[2, 2, 2])
            linear_extrude(height=2, convexity=10)
              text(text="Square", $fa=6, $fs=0.5);
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
                      color(c=[0.894, 0.341, 0.337], alpha=1)
                        linear_extrude(height=1, convexity=10)
                          text(text="Default", $fa=6, $fs=0.5);
                    // Axis
                    color(c=[0.894, 0.341, 0.337], alpha=1)
                      union(){
                        // X
                        cube(size=[1, 200, 1], center=true);
                        // Y
                        cube(size=[200, 1, 1], center=true);
                        // Z
                        cube(size=[1, 1, 200], center=true);
                      }
                  }
                  // Model
                  linear_extrude(height=0.8, convexity=10)
                    difference(){
                      offset(delta=0.5)
                        square(size=[100, 100], center=true);
                      offset(delta=-0.5)
                        square(size=[100, 100], center=true);
                    }
                }
          translate(v=[210, 0, 0])
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
                          square(size=[200, 200], center=true);
                    // Label
                    translate(v=[-90, -90, 0])
                      color(c=[0.894, 0.341, 0.337], alpha=1)
                        linear_extrude(height=1, convexity=10)
                          text(text="Sizes", $fa=6, $fs=0.5);
                    // Axis
                    color(c=[0.894, 0.341, 0.337], alpha=1)
                      union(){
                        // X
                        cube(size=[1, 200, 1], center=true);
                        // Y
                        cube(size=[200, 1, 1], center=true);
                        // Z
                        cube(size=[1, 1, 200], center=true);
                      }
                  }
                  // Model
                  union(){
                    linear_extrude(height=0.8, convexity=10)
                      difference(){
                        offset(delta=0.5)
                          square(size=[20, 20], center=true);
                        offset(delta=-0.5)
                          square(size=[20, 20], center=true);
                      }
                    linear_extrude(height=0.8, convexity=10)
                      difference(){
                        offset(delta=0.5)
                          square(size=[40, 40], center=true);
                        offset(delta=-0.5)
                          square(size=[40, 40], center=true);
                      }
                    linear_extrude(height=0.8, convexity=10)
                      difference(){
                        offset(delta=0.5)
                          square(size=[60, 60], center=true);
                        offset(delta=-0.5)
                          square(size=[60, 60], center=true);
                      }
                    linear_extrude(height=0.8, convexity=10)
                      difference(){
                        offset(delta=0.5)
                          square(size=[80, 80], center=true);
                        offset(delta=-0.5)
                          square(size=[80, 80], center=true);
                      }
                    linear_extrude(height=0.8, convexity=10)
                      difference(){
                        offset(delta=0.5)
                          square(size=[100, 100], center=true);
                        offset(delta=-0.5)
                          square(size=[100, 100], center=true);
                      }
                  }
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
                      color(c=[0.894, 0.341, 0.337], alpha=1)
                        linear_extrude(height=1, convexity=10)
                          text(text="placements", $fa=6, $fs=0.5);
                    // Axis
                    color(c=[0.894, 0.341, 0.337], alpha=1)
                      union(){
                        // X
                        cube(size=[1, 200, 1], center=true);
                        // Y
                        cube(size=[200, 1, 1], center=true);
                        // Z
                        cube(size=[1, 1, 200], center=true);
                      }
                  }
                  // Model
                  union(){
                    linear_extrude(height=0.8, convexity=10)
                      difference(){
                        offset(delta=0.5)
                          square(size=[50, 50]);
                        offset(delta=-0.5)
                          square(size=[50, 50]);
                      }
                    linear_extrude(height=0.8, convexity=10)
                      difference(){
                        offset(delta=0.5)
                          square(size=[50, 50], center=true);
                        offset(delta=-0.5)
                          square(size=[50, 50], center=true);
                      }
                  }
                }
        }
      }
    // Polygon
    translate(v=[0, 840, 0])
      union(){
        translate(v=[-200, 0, 0])
          scale(v=[2, 2, 2])
            linear_extrude(height=2, convexity=10)
              text(text="Polygon", $fa=6, $fs=0.5);
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
                          square(size=[200, 200], center=true);
                    // Label
                    translate(v=[-90, -90, 0])
                      color(c=[0.894, 0.341, 0.337], alpha=1)
                        linear_extrude(height=1, convexity=10)
                          text(text="Default", $fa=6, $fs=0.5);
                    // Axis
                    color(c=[0.894, 0.341, 0.337], alpha=1)
                      union(){
                        // X
                        cube(size=[1, 200, 1], center=true);
                        // Y
                        cube(size=[200, 1, 1], center=true);
                        // Z
                        cube(size=[1, 1, 200], center=true);
                      }
                  }
                  // Model
                  linear_extrude(height=0.8, convexity=10)
                    difference(){
                      offset(delta=0.5)
                        polygon(points=[[0, 57.735026918962575], [57.735026918962575, 57.735026918962575], [57.735026918962575, 0], [0, -57.735026918962575], [-57.735026918962575, -57.735026918962575], [-57.735026918962575, 0]], convexity=10);
                      offset(delta=-0.5)
                        polygon(points=[[0, 57.735026918962575], [57.735026918962575, 57.735026918962575], [57.735026918962575, 0], [0, -57.735026918962575], [-57.735026918962575, -57.735026918962575], [-57.735026918962575, 0]], convexity=10);
                    }
                }
      }
    // Text
    translate(v=[0, 1050, 0])
      union(){
        translate(v=[-200, 0, 0])
          scale(v=[2, 2, 2])
            linear_extrude(height=2, convexity=10)
              text(text="Text", $fa=6, $fs=0.5);
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
                          square(size=[200, 200], center=true);
                    // Label
                    translate(v=[-90, -90, 0])
                      color(c=[0.894, 0.341, 0.337], alpha=1)
                        linear_extrude(height=1, convexity=10)
                          text(text="Default", $fa=6, $fs=0.5);
                    // Axis
                    color(c=[0.894, 0.341, 0.337], alpha=1)
                      union(){
                        // X
                        cube(size=[1, 200, 1], center=true);
                        // Y
                        cube(size=[200, 1, 1], center=true);
                        // Z
                        cube(size=[1, 1, 200], center=true);
                      }
                  }
                  // Model
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
  translate(v=[1000, 0, 0])
    union(){
      // Box
      translate(v=[0, 0, 0])
        union(){
          translate(v=[-200, 0, 0])
            scale(v=[2, 2, 2])
              linear_extrude(height=2, convexity=10)
                text(text="Box", $fa=6, $fs=0.5);
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
                            square(size=[200, 200], center=true);
                      // Label
                      translate(v=[-90, -90, 0])
                        color(c=[0.894, 0.341, 0.337], alpha=1)
                          linear_extrude(height=1, convexity=10)
                            text(text="Default", $fa=6, $fs=0.5);
                      // Axis
                      color(c=[0.894, 0.341, 0.337], alpha=1)
                        union(){
                          // X
                          cube(size=[1, 200, 1], center=true);
                          // Y
                          cube(size=[200, 1, 1], center=true);
                          // Z
                          cube(size=[1, 1, 200], center=true);
                        }
                    }
                    // Model
                    cube(size=[136.79807573413572, 85.49879733383482, 85.49879733383482], center=true);
                  }
        }
      // Cube
      translate(v=[0, 210, 0])
        union(){
          translate(v=[-200, 0, 0])
            scale(v=[2, 2, 2])
              linear_extrude(height=2, convexity=10)
                text(text="Cube", $fa=6, $fs=0.5);
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
                            square(size=[200, 200], center=true);
                      // Label
                      translate(v=[-90, -90, 0])
                        color(c=[0.894, 0.341, 0.337], alpha=1)
                          linear_extrude(height=1, convexity=10)
                            text(text="Default", $fa=6, $fs=0.5);
                      // Axis
                      color(c=[0.894, 0.341, 0.337], alpha=1)
                        union(){
                          // X
                          cube(size=[1, 200, 1], center=true);
                          // Y
                          cube(size=[200, 1, 1], center=true);
                          // Z
                          cube(size=[1, 1, 200], center=true);
                        }
                    }
                    // Model
                    cube(size=[100, 100, 100], center=true);
                  }
        }
      // Sphere
      translate(v=[0, 420, 0])
        union(){
          translate(v=[-200, 0, 0])
            scale(v=[2, 2, 2])
              linear_extrude(height=2, convexity=10)
                text(text="Sphere", $fa=6, $fs=0.5);
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
                            square(size=[200, 200], center=true);
                      // Label
                      translate(v=[-90, -90, 0])
                        color(c=[0.894, 0.341, 0.337], alpha=1)
                          linear_extrude(height=1, convexity=10)
                            text(text="Default", $fa=6, $fs=0.5);
                      // Axis
                      color(c=[0.894, 0.341, 0.337], alpha=1)
                        union(){
                          // X
                          cube(size=[1, 200, 1], center=true);
                          // Y
                          cube(size=[200, 1, 1], center=true);
                          // Z
                          cube(size=[1, 1, 200], center=true);
                        }
                    }
                    // Model
                    sphere(d=124.07009817987998, $fa=6, $fs=0.5);
                  }
        }
      // Ellipsoid
      translate(v=[0, 630, 0])
        union(){
          translate(v=[-200, 0, 0])
            scale(v=[2, 2, 2])
              linear_extrude(height=2, convexity=10)
                text(text="Ellipsoid", $fa=6, $fs=0.5);
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
                            square(size=[200, 200], center=true);
                      // Label
                      translate(v=[-90, -90, 0])
                        color(c=[0.894, 0.341, 0.337], alpha=1)
                          linear_extrude(height=1, convexity=10)
                            text(text="Default", $fa=6, $fs=0.5);
                      // Axis
                      color(c=[0.894, 0.341, 0.337], alpha=1)
                        union(){
                          // X
                          cube(size=[1, 200, 1], center=true);
                          // Y
                          cube(size=[200, 1, 1], center=true);
                          // Z
                          cube(size=[1, 1, 200], center=true);
                        }
                    }
                    // Model
                    resize(newsize=[169.7255068715288, 106.0784417947055, 106.0784417947055])
                      sphere(d=169.7255068715288, $fa=6, $fs=0.5);
                  }
        }
      // Frustum
      translate(v=[0, 840, 0])
        union(){
          translate(v=[-200, 0, 0])
            scale(v=[2, 2, 2])
              linear_extrude(height=2, convexity=10)
                text(text="Frustum", $fa=6, $fs=0.5);
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
                            square(size=[200, 200], center=true);
                      // Label
                      translate(v=[-90, -90, 0])
                        color(c=[0.894, 0.341, 0.337], alpha=1)
                          linear_extrude(height=1, convexity=10)
                            text(text="Default", $fa=6, $fs=0.5);
                      // Axis
                      color(c=[0.894, 0.341, 0.337], alpha=1)
                        union(){
                          // X
                          cube(size=[1, 200, 1], center=true);
                          // Y
                          cube(size=[200, 1, 1], center=true);
                          // Z
                          cube(size=[1, 1, 200], center=true);
                        }
                    }
                    // Model
                    cylinder(h=169.2858015158772, d1=105.80362594742324, d2=66.12726621713952, center=true, $fa=6, $fs=0.5);
                  }
        }
      // Cylinder
      translate(v=[0, 1050, 0])
        union(){
          translate(v=[-200, 0, 0])
            scale(v=[2, 2, 2])
              linear_extrude(height=2, convexity=10)
                text(text="Cylinder", $fa=6, $fs=0.5);
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
                            square(size=[200, 200], center=true);
                      // Label
                      translate(v=[-90, -90, 0])
                        color(c=[0.894, 0.341, 0.337], alpha=1)
                          linear_extrude(height=1, convexity=10)
                            text(text="Default", $fa=6, $fs=0.5);
                      // Axis
                      color(c=[0.894, 0.341, 0.337], alpha=1)
                        union(){
                          // X
                          cube(size=[1, 200, 1], center=true);
                          // Y
                          cube(size=[200, 1, 1], center=true);
                          // Z
                          cube(size=[1, 1, 200], center=true);
                        }
                    }
                    // Model
                    cylinder(h=93.40354599525887, d1=116.75443249407357, d2=116.75443249407357, center=true, $fa=6, $fs=0.5);
                  }
        }
      // Polyhedron
      translate(v=[0, 1260, 0])
        union(){
          translate(v=[-200, 0, 0])
            scale(v=[2, 2, 2])
              linear_extrude(height=2, convexity=10)
                text(text="Polyhedron", $fa=6, $fs=0.5);
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
                            square(size=[200, 200], center=true);
                      // Label
                      translate(v=[-90, -90, 0])
                        color(c=[0.894, 0.341, 0.337], alpha=1)
                          linear_extrude(height=1, convexity=10)
                            text(text="Default", $fa=6, $fs=0.5);
                      // Axis
                      color(c=[0.894, 0.341, 0.337], alpha=1)
                        union(){
                          // X
                          cube(size=[1, 200, 1], center=true);
                          // Y
                          cube(size=[200, 1, 1], center=true);
                          // Z
                          cube(size=[1, 1, 200], center=true);
                        }
                    }
                    // Model
                    polyhedron(points=[[0, -70, -50], [-70, 0, -50], [70, 0, -50], [70, 0, 50], [0, 70, 50], [-70, 0, 50]], faces=[[0, 1, 2], [3, 5, 4], [0, 1, 5], [0, 2, 3], [3, 5, 0], [2, 1, 4], [1, 5, 4], [2, 3, 4]], convexity=10);
                  }
        }
    }
}