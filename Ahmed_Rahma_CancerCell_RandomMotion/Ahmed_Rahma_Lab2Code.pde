cancerCell leuk = new cancerCell();

void setup() {
  size(400, 400);
  background(200);
}

void draw() {
  //if mouse pressed, choose random stepSize between 0 and 10
  if (mousePressed) {
    float rand = random(10);  
    leuk.stepSize = rand;
  }
  //60% of the time, cell moves according to Perlin Noise, 40% according to randStep
  float percent = random(1);
  if (percent <= 0.4) {
    leuk.randStep();
  } else {
    leuk.step();
  }
  
  leuk.display();
}