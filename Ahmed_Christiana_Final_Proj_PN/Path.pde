//Allows us to easily make multiple paths in the future
//"Glial cells that make up the path"

class Path {
  float radius; 
  PVector start; 
  PVector end;
  Path() {
    radius = width/20;
  
    start = new PVector(width/2, height-len*3);
    end = new PVector(width/2, len*4);
  }
  void display() {  // Display the path.
    strokeWeight(radius*2);
    stroke(0, 100);
    line(start.x, start.y, end.x, end.y);
    strokeWeight(1);
    stroke(0);
    line(start.x, start.y, end.x, end.y);
  }
}


//class Path {
//  //A Path is now an ArrayList of points (PVector objects).
//  ArrayList<PVector> points; 
//  float radius;
//  PVector start;
//  PVector end;

//  Path() {
//    radius = 20;
//    points = new ArrayList<PVector>();
//  }
//  //This function allows us to add points to the path
//  void addPoint(float x, float y) { 
//    PVector point = new PVector(x, y);
//    points.add(point);
//    start = points.get(0);
//    end = points.get(points.size()-1);
//  }
//  //Display the path as a series of points.
//  void display() {
//    stroke(0);
//    noFill();
//    beginShape();
//    for (PVector v : points) {
//      vertex(v.x, v.y);
//    }
//    endShape();
//  }

//  PVector findEnd() {
//    int lastPoint = points.size()-1;
//    return points.get(lastPoint);
//  }

//  PVector getStart() {
//    return start;
//  }
//}