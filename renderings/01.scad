
union(){
  union(){
    union()
      translate(v=[0, 0, 0])
        // Circle
        union(){
          translate(v=[0, 0, 0])
            // circleR
            circle(d=100, $fa=6, $fs=0.5);
          translate(v=[200, 0, 0])
            // circleD
            circle(d=50, $fa=6, $fs=0.5);
        }
    union()
      translate(v=[0, 200, 0])
        // Ellipse
        union(){
          translate(v=[0, 0, 0])
            resize(newsize=[100, 60])
              circle(d=200, $fa=6, $fs=0.5);
          translate(v=[200, 0, 0])
            resize(newsize=[50, 30])
              circle(d=100, $fa=6, $fs=0.5);
        }
    union()
      translate(v=[0, 400, 0])
        union(){
          translate(v=[0, 0, 0])
            square(size=[50, 30]);
          translate(v=[200, 0, 0])
            square(size=[50, 30], center=true);
        }
    union()
      translate(v=[0, 600, 0])
        union(){
          translate(v=[0, 0, 0])
            square(size=[50, 50]);
          translate(v=[200, 0, 0])
            square(size=[50, 50], center=true);
        }
    union()
      translate(v=[0, 800, 0])
        union()
          translate(v=[0, 0, 0])
            polygon(points=[[17, 17], [38, 33], [58, 15], [90, 35], [81, 75], [59, 59], [43, 68], [45, 80], [18, 86], [8, 46], [17, 17]], convexity=10);
    union()
      translate(v=[0, 1000, 0])
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
    union()
      translate(v=[0, 1200, 0])
        union(){
          translate(v=[0, 0, 0])
            square(size=[20, 30]);
          translate(v=[200, 0, 0])
            resize(newsize=[40, 0])
              square(size=[20, 30]);
          translate(v=[400, 0, 0])
            resize(newsize=[0, 60])
              resize(newsize=[20, 0])
                square(size=[20, 30]);
          translate(v=[600, 0, 0])
            resize(newsize=[40, 60])
              resize(newsize=[20, 0])
                square(size=[20, 30]);
        }
    union()
      translate(v=[0, 1400, 0])
        union(){
          translate(v=[0, 0, 0])
            square(size=[50, 30]);
          translate(v=[200, 0, 0])
            rotate(a=45)
              square(size=[50, 30]);
          translate(v=[400, 0, 0])
            rotate(a=90)
              square(size=[50, 30]);
          translate(v=[600, 0, 0])
            rotate(a=135)
              square(size=[50, 30]);
          translate(v=[800, 0, 0])
            rotate(a=180)
              square(size=[50, 30]);
          translate(v=[1000, 0, 0])
            rotate(a=225)
              square(size=[50, 30]);
          translate(v=[1200, 0, 0])
            rotate(a=270)
              square(size=[50, 30]);
          translate(v=[1400, 0, 0])
            rotate(a=315)
              square(size=[50, 30]);
          translate(v=[1600, 0, 0])
            rotate(a=360)
              square(size=[50, 30]);
        }
    union()
      translate(v=[0, 1600, 0])
        union(){
          translate(v=[0, 0, 0])
            square(size=[50, 30]);
          translate(v=[200, 0, 0])
            mirror(v=[1, 0])
              square(size=[50, 30]);
        }
    union()
      translate(v=[0, 1800, 0])
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
            color(alpha=0.5)
              square(size=[50, 30]);
        }
  }
  // Grid
  color(c=[0.5, 0.5, 0.5], alpha=0.8)
    union(){
      // X: 0
      union(){
        // Y: 0
        translate(v=[0, 0, -5])
          square(size=[190, 190], center=true);
        // Y: 1
        translate(v=[0, 200, -5])
          square(size=[190, 190], center=true);
        // Y: 2
        translate(v=[0, 400, -5])
          square(size=[190, 190], center=true);
        // Y: 3
        translate(v=[0, 600, -5])
          square(size=[190, 190], center=true);
        // Y: 4
        translate(v=[0, 800, -5])
          square(size=[190, 190], center=true);
        // Y: 5
        translate(v=[0, 1000, -5])
          square(size=[190, 190], center=true);
        // Y: 6
        translate(v=[0, 1200, -5])
          square(size=[190, 190], center=true);
        // Y: 7
        translate(v=[0, 1400, -5])
          square(size=[190, 190], center=true);
        // Y: 8
        translate(v=[0, 1600, -5])
          square(size=[190, 190], center=true);
        // Y: 9
        translate(v=[0, 1800, -5])
          square(size=[190, 190], center=true);
        // Y: 10
        translate(v=[0, 2000, -5])
          square(size=[190, 190], center=true);
      }
      // X: 1
      union(){
        // Y: 0
        translate(v=[200, 0, -5])
          square(size=[190, 190], center=true);
        // Y: 1
        translate(v=[200, 200, -5])
          square(size=[190, 190], center=true);
        // Y: 2
        translate(v=[200, 400, -5])
          square(size=[190, 190], center=true);
        // Y: 3
        translate(v=[200, 600, -5])
          square(size=[190, 190], center=true);
        // Y: 4
        translate(v=[200, 800, -5])
          square(size=[190, 190], center=true);
        // Y: 5
        translate(v=[200, 1000, -5])
          square(size=[190, 190], center=true);
        // Y: 6
        translate(v=[200, 1200, -5])
          square(size=[190, 190], center=true);
        // Y: 7
        translate(v=[200, 1400, -5])
          square(size=[190, 190], center=true);
        // Y: 8
        translate(v=[200, 1600, -5])
          square(size=[190, 190], center=true);
        // Y: 9
        translate(v=[200, 1800, -5])
          square(size=[190, 190], center=true);
        // Y: 10
        translate(v=[200, 2000, -5])
          square(size=[190, 190], center=true);
      }
      // X: 2
      union(){
        // Y: 0
        translate(v=[400, 0, -5])
          square(size=[190, 190], center=true);
        // Y: 1
        translate(v=[400, 200, -5])
          square(size=[190, 190], center=true);
        // Y: 2
        translate(v=[400, 400, -5])
          square(size=[190, 190], center=true);
        // Y: 3
        translate(v=[400, 600, -5])
          square(size=[190, 190], center=true);
        // Y: 4
        translate(v=[400, 800, -5])
          square(size=[190, 190], center=true);
        // Y: 5
        translate(v=[400, 1000, -5])
          square(size=[190, 190], center=true);
        // Y: 6
        translate(v=[400, 1200, -5])
          square(size=[190, 190], center=true);
        // Y: 7
        translate(v=[400, 1400, -5])
          square(size=[190, 190], center=true);
        // Y: 8
        translate(v=[400, 1600, -5])
          square(size=[190, 190], center=true);
        // Y: 9
        translate(v=[400, 1800, -5])
          square(size=[190, 190], center=true);
        // Y: 10
        translate(v=[400, 2000, -5])
          square(size=[190, 190], center=true);
      }
      // X: 3
      union(){
        // Y: 0
        translate(v=[600, 0, -5])
          square(size=[190, 190], center=true);
        // Y: 1
        translate(v=[600, 200, -5])
          square(size=[190, 190], center=true);
        // Y: 2
        translate(v=[600, 400, -5])
          square(size=[190, 190], center=true);
        // Y: 3
        translate(v=[600, 600, -5])
          square(size=[190, 190], center=true);
        // Y: 4
        translate(v=[600, 800, -5])
          square(size=[190, 190], center=true);
        // Y: 5
        translate(v=[600, 1000, -5])
          square(size=[190, 190], center=true);
        // Y: 6
        translate(v=[600, 1200, -5])
          square(size=[190, 190], center=true);
        // Y: 7
        translate(v=[600, 1400, -5])
          square(size=[190, 190], center=true);
        // Y: 8
        translate(v=[600, 1600, -5])
          square(size=[190, 190], center=true);
        // Y: 9
        translate(v=[600, 1800, -5])
          square(size=[190, 190], center=true);
        // Y: 10
        translate(v=[600, 2000, -5])
          square(size=[190, 190], center=true);
      }
      // X: 4
      union(){
        // Y: 0
        translate(v=[800, 0, -5])
          square(size=[190, 190], center=true);
        // Y: 1
        translate(v=[800, 200, -5])
          square(size=[190, 190], center=true);
        // Y: 2
        translate(v=[800, 400, -5])
          square(size=[190, 190], center=true);
        // Y: 3
        translate(v=[800, 600, -5])
          square(size=[190, 190], center=true);
        // Y: 4
        translate(v=[800, 800, -5])
          square(size=[190, 190], center=true);
        // Y: 5
        translate(v=[800, 1000, -5])
          square(size=[190, 190], center=true);
        // Y: 6
        translate(v=[800, 1200, -5])
          square(size=[190, 190], center=true);
        // Y: 7
        translate(v=[800, 1400, -5])
          square(size=[190, 190], center=true);
        // Y: 8
        translate(v=[800, 1600, -5])
          square(size=[190, 190], center=true);
        // Y: 9
        translate(v=[800, 1800, -5])
          square(size=[190, 190], center=true);
        // Y: 10
        translate(v=[800, 2000, -5])
          square(size=[190, 190], center=true);
      }
      // X: 5
      union(){
        // Y: 0
        translate(v=[1000, 0, -5])
          square(size=[190, 190], center=true);
        // Y: 1
        translate(v=[1000, 200, -5])
          square(size=[190, 190], center=true);
        // Y: 2
        translate(v=[1000, 400, -5])
          square(size=[190, 190], center=true);
        // Y: 3
        translate(v=[1000, 600, -5])
          square(size=[190, 190], center=true);
        // Y: 4
        translate(v=[1000, 800, -5])
          square(size=[190, 190], center=true);
        // Y: 5
        translate(v=[1000, 1000, -5])
          square(size=[190, 190], center=true);
        // Y: 6
        translate(v=[1000, 1200, -5])
          square(size=[190, 190], center=true);
        // Y: 7
        translate(v=[1000, 1400, -5])
          square(size=[190, 190], center=true);
        // Y: 8
        translate(v=[1000, 1600, -5])
          square(size=[190, 190], center=true);
        // Y: 9
        translate(v=[1000, 1800, -5])
          square(size=[190, 190], center=true);
        // Y: 10
        translate(v=[1000, 2000, -5])
          square(size=[190, 190], center=true);
      }
      // X: 6
      union(){
        // Y: 0
        translate(v=[1200, 0, -5])
          square(size=[190, 190], center=true);
        // Y: 1
        translate(v=[1200, 200, -5])
          square(size=[190, 190], center=true);
        // Y: 2
        translate(v=[1200, 400, -5])
          square(size=[190, 190], center=true);
        // Y: 3
        translate(v=[1200, 600, -5])
          square(size=[190, 190], center=true);
        // Y: 4
        translate(v=[1200, 800, -5])
          square(size=[190, 190], center=true);
        // Y: 5
        translate(v=[1200, 1000, -5])
          square(size=[190, 190], center=true);
        // Y: 6
        translate(v=[1200, 1200, -5])
          square(size=[190, 190], center=true);
        // Y: 7
        translate(v=[1200, 1400, -5])
          square(size=[190, 190], center=true);
        // Y: 8
        translate(v=[1200, 1600, -5])
          square(size=[190, 190], center=true);
        // Y: 9
        translate(v=[1200, 1800, -5])
          square(size=[190, 190], center=true);
        // Y: 10
        translate(v=[1200, 2000, -5])
          square(size=[190, 190], center=true);
      }
      // X: 7
      union(){
        // Y: 0
        translate(v=[1400, 0, -5])
          square(size=[190, 190], center=true);
        // Y: 1
        translate(v=[1400, 200, -5])
          square(size=[190, 190], center=true);
        // Y: 2
        translate(v=[1400, 400, -5])
          square(size=[190, 190], center=true);
        // Y: 3
        translate(v=[1400, 600, -5])
          square(size=[190, 190], center=true);
        // Y: 4
        translate(v=[1400, 800, -5])
          square(size=[190, 190], center=true);
        // Y: 5
        translate(v=[1400, 1000, -5])
          square(size=[190, 190], center=true);
        // Y: 6
        translate(v=[1400, 1200, -5])
          square(size=[190, 190], center=true);
        // Y: 7
        translate(v=[1400, 1400, -5])
          square(size=[190, 190], center=true);
        // Y: 8
        translate(v=[1400, 1600, -5])
          square(size=[190, 190], center=true);
        // Y: 9
        translate(v=[1400, 1800, -5])
          square(size=[190, 190], center=true);
        // Y: 10
        translate(v=[1400, 2000, -5])
          square(size=[190, 190], center=true);
      }
      // X: 8
      union(){
        // Y: 0
        translate(v=[1600, 0, -5])
          square(size=[190, 190], center=true);
        // Y: 1
        translate(v=[1600, 200, -5])
          square(size=[190, 190], center=true);
        // Y: 2
        translate(v=[1600, 400, -5])
          square(size=[190, 190], center=true);
        // Y: 3
        translate(v=[1600, 600, -5])
          square(size=[190, 190], center=true);
        // Y: 4
        translate(v=[1600, 800, -5])
          square(size=[190, 190], center=true);
        // Y: 5
        translate(v=[1600, 1000, -5])
          square(size=[190, 190], center=true);
        // Y: 6
        translate(v=[1600, 1200, -5])
          square(size=[190, 190], center=true);
        // Y: 7
        translate(v=[1600, 1400, -5])
          square(size=[190, 190], center=true);
        // Y: 8
        translate(v=[1600, 1600, -5])
          square(size=[190, 190], center=true);
        // Y: 9
        translate(v=[1600, 1800, -5])
          square(size=[190, 190], center=true);
        // Y: 10
        translate(v=[1600, 2000, -5])
          square(size=[190, 190], center=true);
      }
      // X: 9
      union(){
        // Y: 0
        translate(v=[1800, 0, -5])
          square(size=[190, 190], center=true);
        // Y: 1
        translate(v=[1800, 200, -5])
          square(size=[190, 190], center=true);
        // Y: 2
        translate(v=[1800, 400, -5])
          square(size=[190, 190], center=true);
        // Y: 3
        translate(v=[1800, 600, -5])
          square(size=[190, 190], center=true);
        // Y: 4
        translate(v=[1800, 800, -5])
          square(size=[190, 190], center=true);
        // Y: 5
        translate(v=[1800, 1000, -5])
          square(size=[190, 190], center=true);
        // Y: 6
        translate(v=[1800, 1200, -5])
          square(size=[190, 190], center=true);
        // Y: 7
        translate(v=[1800, 1400, -5])
          square(size=[190, 190], center=true);
        // Y: 8
        translate(v=[1800, 1600, -5])
          square(size=[190, 190], center=true);
        // Y: 9
        translate(v=[1800, 1800, -5])
          square(size=[190, 190], center=true);
        // Y: 10
        translate(v=[1800, 2000, -5])
          square(size=[190, 190], center=true);
      }
      // X: 10
      union(){
        // Y: 0
        translate(v=[2000, 0, -5])
          square(size=[190, 190], center=true);
        // Y: 1
        translate(v=[2000, 200, -5])
          square(size=[190, 190], center=true);
        // Y: 2
        translate(v=[2000, 400, -5])
          square(size=[190, 190], center=true);
        // Y: 3
        translate(v=[2000, 600, -5])
          square(size=[190, 190], center=true);
        // Y: 4
        translate(v=[2000, 800, -5])
          square(size=[190, 190], center=true);
        // Y: 5
        translate(v=[2000, 1000, -5])
          square(size=[190, 190], center=true);
        // Y: 6
        translate(v=[2000, 1200, -5])
          square(size=[190, 190], center=true);
        // Y: 7
        translate(v=[2000, 1400, -5])
          square(size=[190, 190], center=true);
        // Y: 8
        translate(v=[2000, 1600, -5])
          square(size=[190, 190], center=true);
        // Y: 9
        translate(v=[2000, 1800, -5])
          square(size=[190, 190], center=true);
        // Y: 10
        translate(v=[2000, 2000, -5])
          square(size=[190, 190], center=true);
      }
    }
}