class PioneerDendrite {
  Dendrite parent;
  float fromX, fromY, toX, toY;
  boolean fullyDeveloped;
  ArrayList<FascicleD> fascicles = new ArrayList<FascicleD>();
  float growthRate = 0.5;
  
  PioneerDendrite(Dendrite p, float fX, float fY, float tX, float tY) {
    parent = p;
    fromX = fX;
    fromY = fY;
    toX = tX;
    toY = tY;
    
    fascicles.add(new FascicleD(this, fromX, fromY, toX, toY));
    
    if (toY >= (height - (height / brain.shrinkMod) - (brain.ligandPatchSize / 2)) || toY <= (height / brain.shrinkMod) + (brain.ligandPatchSize / 2)) {
      fullyDeveloped = true;
    } else {
      fullyDeveloped = false;
    }
  }
  
  void arborise() {
    int x = int(fascicles.get(fascicles.size() - 1).toX);
    int y = int(fascicles.get(fascicles.size() - 1).toY);
    
    int attractiveLigand = (parent.neuron.type == neuronTypeCommissural) ? ligandNetrin : ligandDraxin;
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
    float xx = fascicles.get(fascicles.size() - 1).toX;
    float yy = fascicles.get(fascicles.size() - 1).toY;
    float tx = xx + (xDiff * growthRate);
    float ty = yy + (yDiff * growthRate);
    
    fascicles.add(new FascicleD(this, xx, yy, tx, ty));
    
    if ((ty + parent.r) >= (height - (height / brain.shrinkMod) - (brain.ligandPatchSize / 2)) || (ty - parent.r) <= (height / brain.shrinkMod) + (brain.ligandPatchSize / 2)) {
      fullyDeveloped = true;
    } else {
      fullyDeveloped = false;
    }
  }
  
  void frame() {
    for (int i = 0; i < fascicles.size(); i++) {
      fascicles.get(i).frame();
    }
  }
}
