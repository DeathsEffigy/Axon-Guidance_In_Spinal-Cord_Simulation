class Dendrite {
  Neuron neuron;
  int fromSomaX, fromSomaY, toBranchesX, toBranchesY, r, l, rotation;
  
  Dendrite(Neuron n) {
    neuron = n;
    r = 8;
    l = int(random(30, 45));
    
    float[] ratio = neuron.getOrientationRatio();
    do {
      neuron.soma.reposition();
      
      fromSomaX = int(random(neuron.soma.x - (neuron.soma.r / 2), neuron.soma.x + (neuron.soma.r / 2)));
      fromSomaY = int(random(neuron.soma.y - (neuron.soma.r / 2), neuron.soma.y + (neuron.soma.r / 2)));
      //toBranchesX = int(fromSomaX - (l * ratio[0]));
      //toBranchesY = int(fromSomaY - (l * ratio[1]));
      
    } while (!brain.isVacantThrough(fromSomaX, fromSomaY, r, l, ratio, neuron.colour));
  }
  
  void frame() {
    stroke(neuron.colour);
    strokeWeight(r);
    line(fromSomaX, fromSomaY, toBranchesX, toBranchesY);
    noStroke();
  }
}
