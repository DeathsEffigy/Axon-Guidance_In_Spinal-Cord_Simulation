class FascicleD {
  PioneerDendrite parent;
  float fromX, fromY, toX, toY;
  
  FascicleD(PioneerDendrite p, float fX, float fY, float tX, float tY) {
    parent = p;
    fromX = fX;
    fromY = fY;
    toX = tX;
    toY = tY;
  }
  
  void frame() {
    stroke(parent.parent.neuron.colour);
    strokeWeight(parent.parent.r);
    line(fromX, fromY, toX, toY);
    noStroke();
  }
}
