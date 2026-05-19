union(){
  translate(v=[0.0,0.0,0.0])
    union(){
      translate(v=[0.0,0.0,0.0])
        circle(d=100.0, $fa=6.0, $fs=0.5);
      translate(v=[100.0,0.0,0.0])
        circle(d=50.0, $fa=6.0, $fs=0.5);
}
  translate(v=[0.0,100.0,0.0])
    union(){
      translate(v=[0.0,0.0,0.0])
        resize(newsize=[100.0,60.0], auto=[false,false])
          circle(d=200.0, $fa=6.0, $fs=0.5);
      translate(v=[100.0,0.0,0.0])
        resize(newsize=[50.0,30.0], auto=[false,false])
          circle(d=100.0, $fa=6.0, $fs=0.5);
}
}