class Soma {
  Neuron neuron;
  int x, y;
  int r = 15;
  
  Soma(Neuron n) {
    neuron = n;
  }
  
  void reposition() {
    do {
      float lrSwitch = random(0, 1);
      if (lrSwitch < 0.5) {
        // left (caudal; away from cerebrum)
        x = int(random(r + (width / brain.shrinkMod), r + (width / brain.shrinkMod) + brain.clusterSizes));
        neuron.type = neuronTypeCommissural;
      } else {
        // right (rostral; towards cerebrum)
        x = int(random(width - (r + (width / brain.shrinkMod)) - brain.clusterSizes,  width - (r + (width / brain.shrinkMod))));
        neuron.type = neuronTypeTrochear;
      }
      y = int(random(r + (height / brain.shrinkMod), height - (r + (height / brain.shrinkMod))));
    } while (!brain.isVacantAround(x, y, r));
  }
  
  void frame() {
    fill(neuron.colour);
    ellipse(x, y, r, r);
  }
}
