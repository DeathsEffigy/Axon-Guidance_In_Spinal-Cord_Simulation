int ligandNetrin = 1, ligandDraxin = 2;

class Brain {
  int shrinkMod = 8; // this is used so we don't go out of bounds within our window
  int clusterSizes = 200;
  int ligandPatchSize = 50;
  color netrinColour = color(50, 155, 30);
  color draxinColour = color(155, 30, 50); 
  
  ArrayList<Neuron> neurons = new ArrayList<Neuron>();
  
  Brain() {
    
  }
  
  void frame() {
    fill(255);
    text("Rostral>", (width - 50), (height / 2));
    text("<Caudal", 0, (height / 2));
    text("<Spinal Cord; Draxin=red, Netrin=green>", (width - 250) / 2, 15);
    
    drawLigands();
    
    for (int i = 0; i < neurons.size(); i++) {
      neurons.get(i).frame();
    }
  }
  
  color makeUniqueColour() {
    color c;
    boolean unique;
    
    do {
      unique = true;
      
      c = color(random(0, 255), random(0, 255), random(0, 255));
      
      for (int i = 0; i < neurons.size(); i++) {
        if (neurons.get(i).isSameColourAs(c)) {
          unique = false;
          break;
        }
      }
    } while (unique == false || c == bgc);
    
    return c;
  }
  
  boolean isVacantAround(int x, int y, int r) {
    loadPixels();
    
    for (int xx = (x - r); xx < (x + r); xx++) {
      for (int yy = (y - r); yy < (y + r); yy++) {
        int offset = xx + (yy * width);
        color colour = pixels[offset];
        
        if (colour != bgc) {
          return false;
        }
      }
    }
    
    return true;
  }
  
  boolean isVacantAroundColour(int x, int y, int r, color neuronColour) {
    loadPixels();
    
    for (int xx = (x - r); xx < (x + r); xx++) {
      for (int yy = (y - r); yy < (y + r); yy++) {
        int offset = xx + (yy * width);
        color colour = pixels[offset];
        
        if (colour != bgc && colour != neuronColour) {
          return false;
        }
      }
    }
    
    return true;
  }
  
  boolean isVacantThrough(int fromX, int fromY, int r, int l, float[] ratio, color neuronColour) {
    loadPixels();
    
    for (int i = 0; i < l; i++) {
      int x = int(fromX - (i * ratio[0]));
      int y = int(fromY - (i * ratio[1]));
      
      if (!isVacantAroundColour(x, y, r, neuronColour)) {
        return false;
      }
    }
    
    return true;
  }
  
  boolean isVacantThroughNegative(int fromX, int fromY, int r, int l, float[] ratio, color neuronColour) {
    loadPixels();
    
    for (int i = 0; i < l; i++) {
      int x = int(fromX - (i * ratio[0]));
      int y = int(fromY - (i * ratio[1]));
      
      if (!isVacantAroundColour(x, y, r, neuronColour)) {
        return false;
      }
    }
    
    return true;
  }
  
  void drawLigands() {
    /* drawing draxin f roof plates */
    fill(draxinColour);
    rect(width / 2, height / shrinkMod, width, ligandPatchSize);
    /* drawing netrin f floor plates*/
    fill(netrinColour);
    rect(width / 2, height - (height / shrinkMod), width, ligandPatchSize);
  }
  
  void growNeuron() {
    neurons.add(new Neuron(makeUniqueColour(), neurons.size()));
  }
  
  /* the higher returned concentration value, the more ligands in surrounding CSF and the closer to target */
  float getLigandConcentrationAt(int x, int y, int ligandAttraction) {
    float distanceNetrin = abs(y - (height - (height / shrinkMod) - (ligandPatchSize / 2)));
    float concentrationNetrin = (height - distanceNetrin) / height;
    
    float distanceDraxin = abs(y - ((height / shrinkMod) + (ligandPatchSize / 2)));
    float concentrationDraxin = (height - distanceDraxin) / height;
    
    int netrinMod = (ligandAttraction == ligandNetrin) ? 1 : -1;
    int draxinMod = (ligandAttraction == ligandNetrin) ? -1 : 1;
    
    float concentration = (concentrationDraxin + 1) * draxinMod + (concentrationNetrin + 1) * netrinMod;
    
    //println("attracted to " + (ligandAttraction == ligandNetrin ? "netrin" : "draxin") + " w con=" + concentration);
    
    return concentration;
  }
  
  float logisticSigmoid(float x) {
    return ((float) exp(x) / (float) (exp(x) + 1));
  }
}
