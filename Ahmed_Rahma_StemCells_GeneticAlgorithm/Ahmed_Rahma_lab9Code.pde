//Make a cell that is a random walker that can walk 10 steps in either direction

Tumor tumorPop; //our population
//CellWalker cell;
PVector[] source;

int lifetime;     // How long each generation lives
int lifecycle;   // Timer for cycle of generation
int recordtime; // Fastest time to target

void setup() {
  size(640, 360);
  background(155);
  float mutationRate = 0.01;
  lifecycle = 0;
  lifetime= 300;
  recordtime = lifetime;
  //mutation rate used to initialize Tumow
  tumorPop = new Tumor(mutationRate);
  //cell = new CellWalker(new PVector(width, height));
  source = new PVector[10];
  for (int i = 0; i<source.length; i++) {
    source[i] = new PVector(random(40, width-30), random(40, height-100));
  }
}

void draw() {
  // Run the walker object
  background(255);
  //draw source
  fill(150, 0, 0);
  for (int i = 0; i<source.length; i++) {
    ellipse(source[i].x, source[i].y, 40, 40);
  }
  println(frameCount);//count frames to make graph


  // If the generation hasn't ended yet
    tumorPop.live();
    if ((tumorPop.targetReached()) && (lifecycle < recordtime)) {
      recordtime = lifecycle;
    }
   if (lifecycle < lifetime) lifecycle++;
   else lifecycle = 0; // Otherwise a new generation
    tumorPop.fitness();
    tumorPop.run(); //this is for reproduction
  
  if (tumorPop.isPSDead()) {
    stop();
  }
}