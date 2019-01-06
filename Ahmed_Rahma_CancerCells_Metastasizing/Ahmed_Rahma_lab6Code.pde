//CellWalkerExample
//Make a cell that is a random walker that can walk 10 steps in either direction

Tumor c;
//CellWalker cell;
PVector source;

void setup() {
  size(640, 360);
  background(155);
  c = new Tumor(new PVector(width, height));
  //cell = new CellWalker(new PVector(width, height));
  source = new PVector(40, 60);
}

void draw() {
  // Run the walker object
  background(255);
  c.run();
  //draw source
  fill(150, 0, 0); 
  ellipse(source.x, source.y, 40, 40);
  println(frameCount);//count frames to make graph
  if (c.isPSDead()) {
    stop();
  }
}