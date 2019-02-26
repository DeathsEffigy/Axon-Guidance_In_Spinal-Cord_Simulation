class Dendrite {
  Neuron neuron;
  float orientation;
  int fromSomaX, fromSomaY, toBranchesX, toBranchesY, r, rotation;
  boolean isFullyDeveloped;
  ArrayList<Fascicle> fascicles = new ArrayList<Fascicle>();
  
  Dendrite(Neuron n) {
    neuron = n;
    r = 8;
    
    /* setup soma */
    neuron.soma.reposition();
    
    /* get starting point of growth cone */
    fromSomaX = int(random(neuron.soma.x - (neuron.soma.r / 2), neuron.soma.x + (neuron.soma.r / 2)));
    fromSomaY = int(random(neuron.soma.y - (neuron.soma.r / 2), neuron.soma.y + (neuron.soma.r / 2)));
    
    isFullyDeveloped = false;
    
    /* setup first fascicles */
    int attractiveLigand = (neuron.type == neuronTypeCommissural) ? ligandNetrin : ligandDraxin;
    float ligantConcentration = brain.getLigandConcentrationAt(fromSomaX, fromSomaY, attractiveLigand);
    if (neuron.type == neuronTypeCommissural) {
      
    }
  }
  
  void frame() {
    if (!isFullyDeveloped) {
      dendriticArborisation();
    }
  }
  
  void dendriticArborisation() {
    
  }


/* 
    //float[] ratio = neuron.getOrientationRatio();
    do {
      neuron.soma.reposition();
      
      fromSomaX = int(random(neuron.soma.x - (neuron.soma.r / 2), neuron.soma.x + (neuron.soma.r / 2)));
      fromSomaY = int(random(neuron.soma.y - (neuron.soma.r / 2), neuron.soma.y + (neuron.soma.r / 2)));
      //toBranchesX = int(fromSomaX - (l * ratio[0]));
      //toBranchesY = int(fromSomaY - (l * ratio[1]));
      
    } while (!brain.isVacantThrough(fromSomaX, fromSomaY, r, l, ratio, neuron.colour));
    */
    
    /*void frame() {
    stroke(neuron.colour);
    strokeWeight(r);
    line(fromSomaX, fromSomaY, toBranchesX, toBranchesY);
    noStroke();
  }*/
}
