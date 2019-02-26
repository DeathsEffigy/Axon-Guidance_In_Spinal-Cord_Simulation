int neuronTypeCommissural = 0, neuronTypeTrochear = 1;

class Neuron {
  color colour;
  int no;
  int type;
  
  Soma soma;
  Dendrite dendrite;
  
  Neuron(color c, int id) {
    colour = c;
    no = id;
    
    /* we are  restricting this to bipolar neurons */
    /* we simulate only two ligand-receptors, i.e. netrin (shh/vegf) and draxin (bmp7), during axon guidance */
    /* this is loosely analagous to processes of axon guidance within the spinal cord */
    soma = new Soma(this);
    dendrite = new Dendrite(this);
  }
  
  /*float[] getOrientationRatio(float r) {
    float rX = 0;
    float rY = 0;
    float[] ret = new float[2];
    
    // y downwards
    if ((r <= 0 && r >= -180) || (r >= 180 && r <= 360)) {
      if (r >= -90 && r <= 0) {
        rY = r / 90;
      } else if (r <= -90 && r >= -180) {
        rY = (abs(r + 180) * -1) / 90;
      } else if (r >= 270 && r <= 360) {
        rY = (r - 360) / 90;
      } else if (r <= 270 && r >= 180) {
        rY = (r - 180) / 90;
      }
      rY = abs(rY);
    } else if ((r >= 0 && r <= 180) || (r <= -180 && r >= -360)) {
    // y upwards
      if (r >= 0 && r <= 90) {
        rY = r / 90;
      } else if (r <= -270 && r >= -360) {
        rY = (r + 360) / 90;
      } else if (r >= 90 && r <= 180) {
        rY = (r - 180) / 90;
      } else if (r >= -270 && r <= -180) {
        rY = (r + 180) / 90;
      }
      rY = abs(rY) * -1;
    }
    
    // x direction
    if ((r <= -90 && r >= -270) || (r <= 270 && r >= 90)) {
      rX = 1 - abs(rY);
    } else {
      rX = (1 - abs(rY)) * -1;
    }
    
    ret[0] = rX;
    ret[1] = rY;
    return ret;
  }*/
  
  boolean isSameColourAs(color contender) {
    return (colour == contender);
  }
  
  void frame() {
    soma.frame();
    dendrite.frame();
  }
}
