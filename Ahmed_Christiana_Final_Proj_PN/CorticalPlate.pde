//Each glia will have a designated grid that cells go to

//reaches end, remove from arrayList
//call the moveDown function

class CorticalPlate {
  Neuron[][] cells;
  int numNeurons;
  int columns =2;
  int rows = 5;
  float cellWidth = sWidth/30;

  CorticalPlate() {
    numNeurons = 0;
    cells = new Neuron[columns][rows]; //2 columns, 5 rows
    //PVector trya = new PVector(400,400);
    //PVector tryb = new PVector(300,200);
    //cells[0][0] = new Neuron(trya);
   // cells[1][0] = new Neuron(tryb);
  }

  void display(Path glialC) {
    //float endPoint = sHeight-len*3;
    for (int i = 0; i< columns; i++) {
      for (int j = 0; j< rows; j++) {
        if (cells[i][j] != null) {
          float yVal = glialC.end.y + cells[i][j].radius + j*20;
          if (i == 0) {
            cells[i][j].position = new PVector(glialC.end.x + (1.5)*glialC.radius, yVal);
          } else {
           cells[i][j].position = new PVector(glialC.end.x - (1.5)*glialC.radius, yVal);
          }
          cells[i][j].velocity = new PVector(0, 0);
          cells[i][j].display();
          //cells only age if they are being moved
          //ony call run if a new cell has reached the top
          //cells[i][j].age();
        }
      }
    }
  }

  void moveCellsDown(int columnVal, Neuron newCell) {
    println("in movedown");
    Neuron[][] newNeurons = new Neuron[columns][rows]; 
    //newCell.velocity = new PVector(0, 0);
    numNeurons++;
    //loop through arraysize-2 (half of the array), ignore last item in array
    //make a new array with that half updated
    for (int i = 0; i< rows-1; i++) { 
      if (cells[columnVal][i] != null) {
        newNeurons[columnVal][i+1] = cells[columnVal][i];
      }
    }
    newNeurons[columnVal][0] = newCell;

    //add updated cells into old arrayList (cells) 
    for (int i = 0; i< rows; i++) { 
      cells[columnVal][i] = newNeurons[columnVal][i];
    }
  }
}




  //MAY NOT NEED THIS!!! DEPENDS ON HOW WE CODE THE MAIN METHOD
  //void age() {
  //  for (int i = 0; i< columns; i++) {
  //    for (int j = 0; j< rows; j++) {
  //      cells[i][j].age++;
  //      cells[i][j].c +=50;
  //    }
  //  }
  //}

  //only run if a new cell is being added!!!
  //void run(Path glia, Neuron newCell) {
  //  int highColumnVal = 0; 
  //  if (newCell.position == glia.findEnd()) {//if the new cell has reached the end of path
  //    if (cells[0][0].age < cells[1][0].age) {
  //      highColumnVal = 1;
  //    }
  //    moveCellsDown(highColumnVal, newCell);
  //    display();
  //  }
  //}





//  int w;
//  int columns; 
//  int rows;
//  //size(w*rows, w*columns);
//  int [][]board;// = new int [columns][rows];
//  int[][] next;// = new int[columns][rows];


//  CorticalPlate(int w_) {
//    w = w_;
//    columns = width/w; 
//    rows = height/w;
//    board = new int [columns][rows];
//    next = new int[columns][rows];
//  }
//  void setupCa() {
//    for (int x = 10; x < 40; x++) {
//      for (int y = 10; y < 40; y++) {
//        board[x][y] = 0;
//      }
//    }
//  }
//  void run() {
//    next = new int[columns][rows];

//    for (int x = 1; x < columns-1; x++) {
//      for (int y = 1; y < rows-1; y++) {
//        int neighbors = 0;
//        //
//        for (int i = -1; i <= 1; i++) {
//          for (int j = -1; j <= 1; j++) {
//            neighbors += board[x+i][y+j];
//          }
//        }

//        neighbors -= board[x][y];

//        if      ((board[x][y] == 1) && (neighbors <  2)) next[x][y] = 0;
//        else if ((board[x][y] == 1) && (neighbors >  3)) next[x][y] = 0;
//        else if ((board[x][y] == 0) && (neighbors == 3)) next[x][y] = 1;
//        else next[x][y] = board[x][y];
//      }
//    }


//    for ( int i = 0; i < columns; i++) {
//      for ( int j = 0; j < rows; j++) {

//        //Black when state = 1
//        if ((board[i][j] == 1)) fill(0);
//        //White when state = 0
//        else fill(255);
//        stroke(0);

//        rect(i*w, j*w, w, w);
//      }
//    }

//    board = next;
//  }

//  PVector checkCA(PVector cell) {
//    int myx, myy;
//    PVector result;
//    myx = int(cell.x/columns);
//    myy = int(cell.y/rows);
//    if (board[myx][myy] == 1) {
//      result = new PVector (-1, 1);
//      return result;
//    } else {
//      result = new PVector(1, -1);
//      return result;
//    }
//  }
//}