
union(){
  translate(v=[0, 50, 0])
    difference(){
      translate(v=[-25, -15, 0])
        cube(size=[50, 30, 20]);
      #
      translate(v=[0, 0, -0.1])
        translate(v=[-23, -13, 0])
          cube(size=[46, 26, 18.1]);
    }
  difference(){
    translate(v=[-22, -12, 0])
      cube(size=[44, 24, 17]);
    #
    translate(v=[0, 0, 2])
      translate(v=[-20, -10, 0])
        cube(size=[40, 20, 15.1]);
  }
}