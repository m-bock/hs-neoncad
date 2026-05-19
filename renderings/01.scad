
union(){
  translate(v=[0.0, 0.0, 0.0])
    union(){
      translate(v=[0.0, 0.0, 0.0])
        circle(d=100.0, $fa=6.0, $fs=0.5);
      translate(v=[100.0, 0.0, 0.0])
        circle(d=50.0, $fa=6.0, $fs=0.5);
    }
  translate(v=[0.0, 100.0, 0.0])
    union(){
      translate(v=[0.0, 0.0, 0.0])
        resize(newsize=[100.0, 60.0], auto=[false, false])
          circle(d=200.0, $fa=6.0, $fs=0.5);
      translate(v=[100.0, 0.0, 0.0])
        resize(newsize=[50.0, 30.0], auto=[false, false])
          circle(d=100.0, $fa=6.0, $fs=0.5);
    }
  translate(v=[0.0, 200.0, 0.0])
    union(){
      translate(v=[0.0, 0.0, 0.0])
        square(size=[50.0, 30.0], center=false);
      translate(v=[100.0, 0.0, 0.0])
        square(size=[50.0, 30.0], center=true);
    }
  translate(v=[0.0, 300.0, 0.0])
    union(){
      translate(v=[0.0, 0.0, 0.0])
        square(size=[50.0, 50.0], center=false);
      translate(v=[100.0, 0.0, 0.0])
        square(size=[50.0, 50.0], center=true);
    }
  translate(v=[0.0, 400.0, 0.0])
    union()
      translate(v=[0.0, 0.0, 0.0])
        polygon(points=[[17.0, 17.0], [38.0, 33.0], [58.0, 15.0], [90.0, 35.0], [81.0, 75.0], [59.0, 59.0], [43.0, 68.0], [45.0, 80.0], [18.0, 86.0], [8.0, 46.0], [17.0, 17.0]], convexity=10);
  translate(v=[0.0, 500.0, 0.0])
    union(){
      translate(v=[0.0, 0.0, 0.0])
        square(size=[50.0, 30.0], center=false);
      translate(v=[100.0, 0.0, 0.0])
        rotate(a=45.0)
          square(size=[50.0, 30.0], center=false);
      translate(v=[200.0, 0.0, 0.0])
        rotate(a=90.0)
          square(size=[50.0, 30.0], center=false);
      translate(v=[300.0, 0.0, 0.0])
        rotate(a=135.0)
          square(size=[50.0, 30.0], center=false);
      translate(v=[400.0, 0.0, 0.0])
        rotate(a=180.0)
          square(size=[50.0, 30.0], center=false);
      translate(v=[500.0, 0.0, 0.0])
        rotate(a=225.0)
          square(size=[50.0, 30.0], center=false);
      translate(v=[600.0, 0.0, 0.0])
        rotate(a=270.0)
          square(size=[50.0, 30.0], center=false);
      translate(v=[700.0, 0.0, 0.0])
        rotate(a=315.0)
          square(size=[50.0, 30.0], center=false);
      translate(v=[800.0, 0.0, 0.0])
        rotate(a=360.0)
          square(size=[50.0, 30.0], center=false);
    }
  translate(v=[0.0, 600.0, 0.0])
    union(){
      translate(v=[0.0, 0.0, 0.0])
        square(size=[50.0, 30.0], center=false);
      translate(v=[100.0, 0.0, 0.0])
        mirror(v=[1.0, 0.0])
          square(size=[50.0, 30.0], center=false);
    }
  translate(v=[0.0, 700.0, 0.0])
    union(){
      translate(v=[0.0, 0.0, 0.0])
        square(size=[50.0, 30.0], center=false);
      translate(v=[100.0, 0.0, 0.0])
        color(c=[1.0, 0.0, 0.0])
          square(size=[50.0, 30.0], center=false);
      translate(v=[200.0, 0.0, 0.0])
        color(c=[1.0, 0.0, 0.0], alpha=0.5)
          square(size=[50.0, 30.0], center=false);
      translate(v=[300.0, 0.0, 0.0])
        color(alpha=0.5)
          square(size=[50.0, 30.0], center=false);
    }
}