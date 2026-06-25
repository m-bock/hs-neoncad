
// ring
difference(){
  // outer
  translate(v=[0, 0, -1.5])
    cylinder(h=3, d1=60, d2=60, $fa=6, $fs=0.5);
  // inner
  translate(v=[0, 0, -1.55])
    cylinder(h=3.1, d1=50, d2=50, $fa=6, $fs=0.5);
}