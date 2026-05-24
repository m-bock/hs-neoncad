
union(){
  translate(v=[0, 100, 0])
    union(){
      translate(v=[0, 0, 0])
        // Circle
        translate(v=[100, 0, 0])
          union(){
            translate(v=[0, 0, 0])
              // circleR
              circle(d=100, $fa=6, $fs=0.5);
            translate(v=[200, 0, 0])
              // circleD
              circle(d=50, $fa=6, $fs=0.5);
          }
      translate(v=[0, 200, 0])
        // Ellipse
        translate(v=[100, 0, 0])
          union(){
            translate(v=[0, 0, 0])
              resize(newsize=[100, 60])
                circle(d=200, $fa=6, $fs=0.5);
            translate(v=[200, 0, 0])
              resize(newsize=[50, 30])
                circle(d=100, $fa=6, $fs=0.5);
          }
      translate(v=[0, 400, 0])
        // Rect
        translate(v=[100, 0, 0])
          union(){
            translate(v=[0, 0, 0])
              square(size=[50, 30]);
            translate(v=[200, 0, 0])
              square(size=[50, 30], center=true);
          }
      translate(v=[0, 600, 0])
        // Square
        translate(v=[100, 0, 0])
          union(){
            translate(v=[0, 0, 0])
              square(size=[50, 50]);
            translate(v=[200, 0, 0])
              square(size=[50, 50], center=true);
          }
      translate(v=[0, 800, 0])
        // Polygon
        translate(v=[100, 0, 0])
          union()
            translate(v=[0, 0, 0])
              polygon(points=[[17, 17], [38, 33], [58, 15], [90, 35], [81, 75], [59, 59], [43, 68], [45, 80], [18, 86], [8, 46], [17, 17]], convexity=10);
      translate(v=[0, 1000, 0])
        // Scale
        translate(v=[100, 0, 0])
          union(){
            translate(v=[0, 0, 0])
              square(size=[20, 30]);
            translate(v=[200, 0, 0])
              scale(v=[2, 1])
                square(size=[20, 30]);
            translate(v=[400, 0, 0])
              scale(v=[1, 2])
                scale(v=[2, 1])
                  square(size=[20, 30]);
            translate(v=[600, 0, 0])
              scale(v=[2, 2])
                scale(v=[2, 1])
                  square(size=[20, 30]);
          }
      translate(v=[0, 1200, 0])
        // Resize
        translate(v=[100, 0, 0])
          union(){
            translate(v=[0, 0, 0])
              square(size=[20, 30]);
            translate(v=[200, 0, 0])
              resize(newsize=[40, 1])
                square(size=[20, 30]);
            translate(v=[400, 0, 0])
              resize(newsize=[1, 60])
                resize(newsize=[20, 1])
                  square(size=[20, 30]);
            translate(v=[600, 0, 0])
              resize(newsize=[40, 60])
                resize(newsize=[20, 1])
                  square(size=[20, 30]);
          }
      translate(v=[0, 1400, 0])
        // Rotate
        translate(v=[100, 0, 0])
          union(){
            translate(v=[0, 0, 0])
              square(size=[50, 30]);
            translate(v=[200, 0, 0])
              rotate(a=[0, 0, 45])
                square(size=[50, 30]);
            translate(v=[400, 0, 0])
              rotate(a=[0, 0, 90])
                square(size=[50, 30]);
            translate(v=[600, 0, 0])
              rotate(a=[0, 0, 135])
                square(size=[50, 30]);
            translate(v=[800, 0, 0])
              rotate(a=[0, 0, 180])
                square(size=[50, 30]);
            translate(v=[1000, 0, 0])
              rotate(a=[0, 0, 225])
                square(size=[50, 30]);
            translate(v=[1200, 0, 0])
              rotate(a=[0, 0, 270])
                square(size=[50, 30]);
            translate(v=[1400, 0, 0])
              rotate(a=[0, 0, 315])
                square(size=[50, 30]);
            translate(v=[1600, 0, 0])
              rotate(a=[0, 0, 360])
                square(size=[50, 30]);
          }
      translate(v=[0, 1600, 0])
        // Mirror
        translate(v=[100, 0, 0])
          union(){
            translate(v=[0, 0, 0])
              square(size=[50, 30]);
            translate(v=[200, 0, 0])
              mirror(v=[0, 1])
                square(size=[50, 30]);
          }
      translate(v=[0, 1800, 0])
        // Color
        translate(v=[100, 0, 0])
          union(){
            translate(v=[0, 0, 0])
              square(size=[50, 30]);
            translate(v=[200, 0, 0])
              color(c=[1, 0, 0])
                square(size=[50, 30]);
            translate(v=[400, 0, 0])
              color(c=[1, 0, 0], alpha=0.5)
                square(size=[50, 30]);
            translate(v=[600, 0, 0])
              color(c=[1, 0, 0], alpha=0.5)
                square(size=[50, 30]);
          }
      translate(v=[0, 2000, 0])
        // Text
        translate(v=[100, 0, 0])
          union()
            translate(v=[0, 0, 0])
              text(text="Hello, World!", $fa=6, $fs=0.5);
      translate(v=[0, 2200, 0])
        translate(v=[100, 0, 0])
          union()
            translate(v=[0, 0, 0])
              hull()
                union(){
                  #
                  translate(v=[50, 50, 0])
                    square(size=[50, 50], center=true);
                  #
                  circle(d=50, $fa=6, $fs=0.5);
                }
      translate(v=[0, 2400, 0])
        translate(v=[100, 0, 0])
          union()
            translate(v=[0, 0, 0])
              difference(){
                translate(v=[50, 50, 0])
                  square(size=[50, 50], center=true);
                %
                circle(d=100, $fa=6, $fs=0.5);
              }
    }
  // Grid
  translate(v=[100, 100, 0])
    union(){
      // X: 0
      union(){
        // Y: 0
        translate(v=[0, 0, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 1
        translate(v=[0, 200, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 2
        translate(v=[0, 400, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 3
        translate(v=[0, 600, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 4
        translate(v=[0, 800, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 5
        translate(v=[0, 1000, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 6
        translate(v=[0, 1200, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 7
        translate(v=[0, 1400, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 8
        translate(v=[0, 1600, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 9
        translate(v=[0, 1800, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 10
        translate(v=[0, 2000, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 11
        translate(v=[0, 2200, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 12
        translate(v=[0, 2400, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 13
        translate(v=[0, 2600, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 14
        translate(v=[0, 2800, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 15
        translate(v=[0, 3000, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 16
        translate(v=[0, 3200, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 17
        translate(v=[0, 3400, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 18
        translate(v=[0, 3600, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 19
        translate(v=[0, 3800, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 20
        translate(v=[0, 4000, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
      }
      // X: 1
      union(){
        // Y: 0
        translate(v=[200, 0, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 1
        translate(v=[200, 200, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 2
        translate(v=[200, 400, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 3
        translate(v=[200, 600, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 4
        translate(v=[200, 800, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 5
        translate(v=[200, 1000, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 6
        translate(v=[200, 1200, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 7
        translate(v=[200, 1400, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 8
        translate(v=[200, 1600, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 9
        translate(v=[200, 1800, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 10
        translate(v=[200, 2000, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 11
        translate(v=[200, 2200, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 12
        translate(v=[200, 2400, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 13
        translate(v=[200, 2600, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 14
        translate(v=[200, 2800, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 15
        translate(v=[200, 3000, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 16
        translate(v=[200, 3200, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 17
        translate(v=[200, 3400, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 18
        translate(v=[200, 3600, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 19
        translate(v=[200, 3800, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 20
        translate(v=[200, 4000, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
      }
      // X: 2
      union(){
        // Y: 0
        translate(v=[400, 0, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 1
        translate(v=[400, 200, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 2
        translate(v=[400, 400, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 3
        translate(v=[400, 600, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 4
        translate(v=[400, 800, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 5
        translate(v=[400, 1000, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 6
        translate(v=[400, 1200, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 7
        translate(v=[400, 1400, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 8
        translate(v=[400, 1600, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 9
        translate(v=[400, 1800, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 10
        translate(v=[400, 2000, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 11
        translate(v=[400, 2200, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 12
        translate(v=[400, 2400, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 13
        translate(v=[400, 2600, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 14
        translate(v=[400, 2800, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 15
        translate(v=[400, 3000, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 16
        translate(v=[400, 3200, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 17
        translate(v=[400, 3400, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 18
        translate(v=[400, 3600, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 19
        translate(v=[400, 3800, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 20
        translate(v=[400, 4000, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
      }
      // X: 3
      union(){
        // Y: 0
        translate(v=[600, 0, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 1
        translate(v=[600, 200, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 2
        translate(v=[600, 400, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 3
        translate(v=[600, 600, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 4
        translate(v=[600, 800, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 5
        translate(v=[600, 1000, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 6
        translate(v=[600, 1200, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 7
        translate(v=[600, 1400, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 8
        translate(v=[600, 1600, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 9
        translate(v=[600, 1800, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 10
        translate(v=[600, 2000, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 11
        translate(v=[600, 2200, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 12
        translate(v=[600, 2400, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 13
        translate(v=[600, 2600, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 14
        translate(v=[600, 2800, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 15
        translate(v=[600, 3000, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 16
        translate(v=[600, 3200, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 17
        translate(v=[600, 3400, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 18
        translate(v=[600, 3600, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 19
        translate(v=[600, 3800, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 20
        translate(v=[600, 4000, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
      }
      // X: 4
      union(){
        // Y: 0
        translate(v=[800, 0, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 1
        translate(v=[800, 200, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 2
        translate(v=[800, 400, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 3
        translate(v=[800, 600, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 4
        translate(v=[800, 800, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 5
        translate(v=[800, 1000, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 6
        translate(v=[800, 1200, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 7
        translate(v=[800, 1400, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 8
        translate(v=[800, 1600, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 9
        translate(v=[800, 1800, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 10
        translate(v=[800, 2000, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 11
        translate(v=[800, 2200, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 12
        translate(v=[800, 2400, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 13
        translate(v=[800, 2600, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 14
        translate(v=[800, 2800, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 15
        translate(v=[800, 3000, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 16
        translate(v=[800, 3200, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 17
        translate(v=[800, 3400, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 18
        translate(v=[800, 3600, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 19
        translate(v=[800, 3800, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 20
        translate(v=[800, 4000, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
      }
      // X: 5
      union(){
        // Y: 0
        translate(v=[1000, 0, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 1
        translate(v=[1000, 200, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 2
        translate(v=[1000, 400, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 3
        translate(v=[1000, 600, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 4
        translate(v=[1000, 800, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 5
        translate(v=[1000, 1000, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 6
        translate(v=[1000, 1200, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 7
        translate(v=[1000, 1400, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 8
        translate(v=[1000, 1600, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 9
        translate(v=[1000, 1800, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 10
        translate(v=[1000, 2000, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 11
        translate(v=[1000, 2200, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 12
        translate(v=[1000, 2400, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 13
        translate(v=[1000, 2600, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 14
        translate(v=[1000, 2800, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 15
        translate(v=[1000, 3000, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 16
        translate(v=[1000, 3200, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 17
        translate(v=[1000, 3400, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 18
        translate(v=[1000, 3600, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 19
        translate(v=[1000, 3800, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 20
        translate(v=[1000, 4000, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
      }
      // X: 6
      union(){
        // Y: 0
        translate(v=[1200, 0, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 1
        translate(v=[1200, 200, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 2
        translate(v=[1200, 400, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 3
        translate(v=[1200, 600, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 4
        translate(v=[1200, 800, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 5
        translate(v=[1200, 1000, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 6
        translate(v=[1200, 1200, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 7
        translate(v=[1200, 1400, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 8
        translate(v=[1200, 1600, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 9
        translate(v=[1200, 1800, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 10
        translate(v=[1200, 2000, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 11
        translate(v=[1200, 2200, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 12
        translate(v=[1200, 2400, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 13
        translate(v=[1200, 2600, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 14
        translate(v=[1200, 2800, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 15
        translate(v=[1200, 3000, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 16
        translate(v=[1200, 3200, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 17
        translate(v=[1200, 3400, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 18
        translate(v=[1200, 3600, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 19
        translate(v=[1200, 3800, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 20
        translate(v=[1200, 4000, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
      }
      // X: 7
      union(){
        // Y: 0
        translate(v=[1400, 0, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 1
        translate(v=[1400, 200, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 2
        translate(v=[1400, 400, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 3
        translate(v=[1400, 600, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 4
        translate(v=[1400, 800, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 5
        translate(v=[1400, 1000, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 6
        translate(v=[1400, 1200, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 7
        translate(v=[1400, 1400, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 8
        translate(v=[1400, 1600, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 9
        translate(v=[1400, 1800, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 10
        translate(v=[1400, 2000, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 11
        translate(v=[1400, 2200, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 12
        translate(v=[1400, 2400, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 13
        translate(v=[1400, 2600, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 14
        translate(v=[1400, 2800, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 15
        translate(v=[1400, 3000, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 16
        translate(v=[1400, 3200, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 17
        translate(v=[1400, 3400, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 18
        translate(v=[1400, 3600, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 19
        translate(v=[1400, 3800, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 20
        translate(v=[1400, 4000, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
      }
      // X: 8
      union(){
        // Y: 0
        translate(v=[1600, 0, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 1
        translate(v=[1600, 200, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 2
        translate(v=[1600, 400, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 3
        translate(v=[1600, 600, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 4
        translate(v=[1600, 800, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 5
        translate(v=[1600, 1000, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 6
        translate(v=[1600, 1200, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 7
        translate(v=[1600, 1400, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 8
        translate(v=[1600, 1600, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 9
        translate(v=[1600, 1800, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 10
        translate(v=[1600, 2000, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 11
        translate(v=[1600, 2200, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 12
        translate(v=[1600, 2400, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 13
        translate(v=[1600, 2600, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 14
        translate(v=[1600, 2800, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 15
        translate(v=[1600, 3000, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 16
        translate(v=[1600, 3200, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 17
        translate(v=[1600, 3400, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 18
        translate(v=[1600, 3600, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 19
        translate(v=[1600, 3800, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 20
        translate(v=[1600, 4000, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
      }
      // X: 9
      union(){
        // Y: 0
        translate(v=[1800, 0, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 1
        translate(v=[1800, 200, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 2
        translate(v=[1800, 400, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 3
        translate(v=[1800, 600, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 4
        translate(v=[1800, 800, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 5
        translate(v=[1800, 1000, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 6
        translate(v=[1800, 1200, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 7
        translate(v=[1800, 1400, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 8
        translate(v=[1800, 1600, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 9
        translate(v=[1800, 1800, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 10
        translate(v=[1800, 2000, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 11
        translate(v=[1800, 2200, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 12
        translate(v=[1800, 2400, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 13
        translate(v=[1800, 2600, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 14
        translate(v=[1800, 2800, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 15
        translate(v=[1800, 3000, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 16
        translate(v=[1800, 3200, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 17
        translate(v=[1800, 3400, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 18
        translate(v=[1800, 3600, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 19
        translate(v=[1800, 3800, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 20
        translate(v=[1800, 4000, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
      }
      // X: 10
      union(){
        // Y: 0
        translate(v=[2000, 0, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 1
        translate(v=[2000, 200, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 2
        translate(v=[2000, 400, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 3
        translate(v=[2000, 600, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 4
        translate(v=[2000, 800, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 5
        translate(v=[2000, 1000, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 6
        translate(v=[2000, 1200, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 7
        translate(v=[2000, 1400, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 8
        translate(v=[2000, 1600, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 9
        translate(v=[2000, 1800, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 10
        translate(v=[2000, 2000, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 11
        translate(v=[2000, 2200, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 12
        translate(v=[2000, 2400, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 13
        translate(v=[2000, 2600, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 14
        translate(v=[2000, 2800, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 15
        translate(v=[2000, 3000, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 16
        translate(v=[2000, 3200, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 17
        translate(v=[2000, 3400, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 18
        translate(v=[2000, 3600, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 19
        translate(v=[2000, 3800, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
        // Y: 20
        translate(v=[2000, 4000, 0])
          union(){
            translate(v=[0, 0, -5])
              color(c=[1, 1, 1])
                square(size=[190, 190], center=true);
            translate(v=[0, 0, -4])
              color(c=[1, 0, 0], alpha=0.5)
                union(){
                  square(size=[1, 190], center=true);
                  square(size=[190, 1], center=true);
                }
          }
      }
    }
}