class Dendrite {
  Neuron neuron;
  float orientation;
  int fromSomaX, fromSomaY, toBranchesX, toBranchesY, r, rotation, growthRate;
  boolean isFullyDeveloped;
  ArrayList<PioneerDendrite> pioneers = new ArrayList<PioneerDendrite>();
  
  Dendrite(Neuron n) {
    neuron = n;
    r = 8;
    growthRate = 10;
    
    /* setup soma */
    neuron.soma.reposition();
    
    /* get starting point of growth cone */
    fromSomaX = int(random(neuron.soma.x - (neuron.soma.r / 2), neuron.soma.x + (neuron.soma.r / 2)));
    fromSomaY = int(random(neuron.soma.y - (neuron.soma.r / 2), neuron.soma.y + (neuron.soma.r / 2)));
    
    isFullyDeveloped = false;
    
    growPioneerDendrite(fromSomaX, fromSomaY);
    
    /* setup first fascicles */
    /*int attractiveLigand = (neuron.type == neuronTypeCommissural) ? ligandNetrin : ligandDraxin;
    float ligantConcentration = brain.getLigandConcentrationAt(fromSomaX, fromSomaY, attractiveLigand);
    float r = random(0, 1);*/
    
    /* branch out 20% of the time */
    /*if (r < 0.2) {
      growPioneerDendrite();
    }*/
  }
  
  void growPioneerDendrite(int x, int y) {
    int attractiveLigand = (neuron.type == neuronTypeCommissural) ? ligandNetrin : ligandDraxin;
    ArrayList<ArrayList<Float>> unsorted = new ArrayList<ArrayList<Float>>();
    
    for (int xi = 0; xi < 3; xi++) {
      int currentX = (x - 1) + xi;
      for (int yi = 0; yi < 3; yi++) {
        int currentY = (y - 1) + yi;
        float concentration = brain.getLigandConcentrationAt(currentX, currentY, attractiveLigand);
        ArrayList<Float> dot = new ArrayList<Float>();
        dot.add(concentration);
        dot.add(float(currentX));
        dot.add(float(currentY));
        unsorted.add(dot);
      }
    }
    
    ArrayList<ArrayList<Float>> sorted = new ArrayList<ArrayList<Float>>();
    int unsortedSize = unsorted.size();
    while (sorted.size() < unsortedSize) {
      int currentBestI = 0;
      float currentBest = -1;
      
      for (int i = 0; i < unsorted.size(); i++) {
        if (unsorted.get(i).get(0) > currentBest) {
          currentBest = unsorted.get(i).get(0);
          currentBestI = i;
        }
      }
      
      sorted.add(unsorted.get(currentBestI));
      unsorted.remove(currentBestI);
    }
    
    ArrayList<Float> growTowards = sorted.get(1);
    float xDiff = growTowards.get(1) - x;
    float yDiff = growTowards.get(2) - y;
    
    //println(xDiff + ":" + yDiff);
    
    pioneers.add(new PioneerDendrite(this, float(x), float(y), x + (xDiff * growthRate) + (xDiff * r), y + (yDiff * growthRate) + (yDiff * r)));
  }
  
  void frame() {
    if (!isFullyDeveloped) {
      dendriticArborisation();
    }
    
    for (int i = 0; i < pioneers.size(); i++) {
      pioneers.get(i).frame();
    }
  }
  
  void dendriticArborisation() {
    isFullyDeveloped = true;
    
    for (int i = 0; i < pioneers.size(); i++) {
      if (!pioneers.get(i).fullyDeveloped) {
        isFullyDeveloped = false;
        pioneers.get(i).arborise();
      }
    }
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
