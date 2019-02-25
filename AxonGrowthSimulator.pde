color bgc = color(189, 189, 189);
Brain brain;

void setup() {
  frameRate(30);
  rectMode(CENTER);
  ellipseMode(RADIUS);
  noStroke();
  size(1024, 600);
  
  brain = new Brain();
}

void draw() {
  background(bgc);
  brain.frame();
}

void keyPressed() {
  if (key == 'n') { // new neuron
    brain.growNeuron();
  }
}
