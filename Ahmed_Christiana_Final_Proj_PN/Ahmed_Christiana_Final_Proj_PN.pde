int len;//value to measure relative sizes of things
Path glialCell; 
CorticalPlate grid1; //grid for path glialCell
ArrayList<StemCell> stemCells; //stemCells that can reproduce or become neurons
ArrayList<Neuron> neurons; //new neurons that have not yet found their home

ArrayList<StemCell> deadCells = new ArrayList<StemCell>(); //stem cells that become neurons

boolean moved;
float sWidth;//screen width
float sHeight;//screen height

float neuralProb; //probability a cell will become a nerom
float glialProb; //probability a cell will become a glial cell
//float StemCellCount;


//if its not neural prob or glial prob then it will divide

// the walls of the neural tube contain neural stem cells, 
//which drive brain growth as they divide many times. 
//Gradually some of the cells stop dividing and differentiate 
//into neurons and glial cells, which are the main cellular 
//components of the CNS.

void setup() {
  size (400, 600);
  sWidth = width;
  sHeight = height;

  len = 20;
  //Path -> len * 4 to height
  glialCell = new Path();
  grid1 = new CorticalPlate();
  //may need to add more points if we decide path isn't just straight line
  //glialCell.addPoint(width/2, height-len*3); //start point
  //glialCell.start = glialCell.getStart();
  //glialCell.addPoint(width/2, len*4); //end point (must be last thing addd to arrayList)
  stemCells = new ArrayList<StemCell>();
  neurons = new ArrayList<Neuron>();

  stemCells.add(new StemCell());
  stemCells.add(new StemCell());
}

void draw () {
  background(255);
  glialCell.display();
  noStroke();
  fill(0, 150, 200);
  rect(0, 0, width, len);
  fill(250, 150, 0);
  rect(0, len, width, len*3);
  StemCellGrow();
  Neurons();
  for (int i = 0; i< neurons.size(); i++) {
    neurons.get(i).follow(glialCell);
    neurons.get(i).display();
  }
  travel(glialCell);
  grid1.display(glialCell);
  if (moved) {
    for (int i = 0; i< grid1.columns; i++) {
      for (int j = 0; j< grid1.rows; j++) {
        if (grid1.cells[i][j] != null) {
          grid1.cells[i][j].age();
        }
      }
    }
    //cell reches top, bool is true
    //run corticalplate
    //set bool to false again
  }
}

//this is the stem cell array getting bigger an dbeing displayed
void StemCellGrow() {
  stemCells.remove(deadCells);

  ArrayList<StemCell> newCells = new ArrayList<StemCell>(); 

  //StemCell closestCell;
  PVector closestPos = new PVector(500,500);
  float magClosest = closestPos.mag();
  
  for (int i = 0; i<stemCells.size(); i++) {
    StemCell me = stemCells.get(i);
    stemCells.get(i).display();
   
    for (int j = 0; j<stemCells.size(); j++) {
      if (stemCells.get(j) != stemCells.get(i)) {
        PVector pos = stemCells.get(j).position;
        //PVector closestPos = closestCell.position;
        //float closestVal = 
        PVector dist = PVector.sub(me.position, pos);
        if (dist.mag() < magClosest){
           closestPos =  stemCells.get(j).position;
        }
        // if stem cell !sense other stem cell
        // reproduce new stem cell
        if (stemCells.get(j).sensesOther(closestPos) == false || stemCells.size() <= 30) {   
          StemCell newCell = stemCells.get(j).reproduce();
          newCells.add(newCell);
          newCell.display();
          //stemCells.get(j).display();
        }
      }
    }
  }
  stemCells.addAll(newCells);
 
}


//this is the stem cell array getting bigger an dbeing displayed
//void StemCellGrow() {
//  stemCells.remove(deadCells);

//  ArrayList<StemCell> newCells = new ArrayList<StemCell>(); 
//  for (int i = 0; i<stemCells.size(); i++) {
//    stemCells.get(i).display();
//    float rand = random(1);
//    if (rand< 0.01) {   
//      StemCell newCell = stemCells.get(i).reproduce();
//      newCells.add(newCell);
//    }
//  }
//  stemCells.addAll(newCells);
//}

//StemCells become neurons (make new neuron, stem cell dies)
void Neurons() {
  for (int i =stemCells.size()-1;i >=0; i--) {
    float rand = random(10);
    if (rand < 0.001) {//small probability that a neuorn is made
      //PVector spos = stemCells.get(i).position;
      //PVector blank = new PVector(0, 0);
      //PVector pos = PVector.add(spos, blank);
      float xVal = stemCells.get(i).position.x;
      float yVal = stemCells.get(i).position.y;
      PVector pos2 = new PVector(xVal, yVal);
      Neuron newNeuron = new Neuron(pos2);//new neuron is made
      newNeuron.follow(glialCell);
      neurons.add(newNeuron);//neuron added to the arrayList
      stemCells.remove(i);//stem cell that became a neuron is added to deadCells
    }
  }
  println("before ", stemCells.size());
  println(deadCells.size());
  //stemCells.remove(deadCells);
    println("after ", stemCells.size());
}


//reaches end, remove from arrayList
//call the moveDown function
//neurons gotta age
//ADD GRID(corti..) AS INPUT AS WELL!!!
boolean travel(Path glia) {
  moved = false;
  for (int i = 0; i<neurons.size(); i++) {
    Neuron currNeuron = neurons.get(i);
    int columnVal = 0;
    float rand = random(1);
    if (glia.end.y >= currNeuron.position.y) {
      println("test");
      neurons.get(i).velocity = new PVector(0, 0);
      moved = true;
      //if grid is empty, choose random spot to putfir cell into
      if (grid1.numNeurons == 0) {
        if (rand<0.5) {
          columnVal = 0;
        } else {
          columnVal = 1;
        }
      }
      //otherwise check which cell has a null
      else if (grid1.cells[0][0] == null && grid1.cells[1][0] != null) {
        columnVal = 0;
      } else if (grid1.cells[0][0] != null && grid1.cells[1][0] == null) {
        columnVal = 1;
      } //otherwise check which cell is olde
      else {
        if (grid1.cells[0][0].age > grid1.cells[1][0].age) {
          columnVal = 0;
        } else { 
          columnVal = 1;
        }
      }
      grid1.moveCellsDown(columnVal, currNeuron);
      neurons.remove(currNeuron);
    }
  }
  return moved;
}