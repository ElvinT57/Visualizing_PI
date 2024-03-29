//location of every digit on the circle
PVector [] digitsLoc;
//radius of the circle
float r = 200;
//current angle
float angle = 0;

float x = 0;
float y = 0;
float [] rgb = {0, 0, 0};

//origin of the circle = width/2 && height/2
float origin = 300;
//index of character
int i = 0;
//current position for display digits
int pos = 0;
//vector for previous digit called
PVector prev;
PVector curr;
String[] lines;



void setup() {
  size(600, 600);
  background(255);
  smooth();

  //initialize every digit location
  digitsLoc = new PVector[10];

  for (int i = 0; i < digitsLoc.length; i++) {
    x =((r) * cos(angle))+origin;
    y =((r) * sin(angle))+origin;

    digitsLoc[i] = new PVector(x, y);

    ////increment angle
    angle += (PI/10)*2;
  }
  //read all the lines of digits and store them in array
  lines = loadStrings("digits.txt");
  //set previous to vector <0,0>
  prev = digitsLoc[0];
  ///set current to zero for the moment
  curr = digitsLoc[0];
}

void draw() {
  //draw circle
  strokeWeight(2);
  stroke(0);
  noFill();
  ellipse(origin, origin, r*2, r*2);
  drawLabels();

  //parse next digit
  int n = Integer.parseInt(Character.toString(lines[0].charAt(i)));
  //print(n);
  //create new current digit vector
  curr = new PVector(digitsLoc[n].x, digitsLoc[n].y);
  //map colors
  angle = atan2(curr.x, curr.y);
  rgb[0] = map(angle, 0, 360, 0, 255);
  rgb[1] = map(curr.x, 100, r*2, 0, 255);
  rgb[2] = map(curr.y, 100, r*2, 0, 255);
  //draw line between those two vectors
  stroke(rgb[0], rgb[1], rgb[2], 50);
  //stroke(0, 200, 100, 20);
  line(prev.x, prev.y, curr.x, curr.y);
  
  delay(500);
  //set new prev to curr
  prev = curr;
  //increment index
  i++;

  //display current digit
  if (pos == width-25) {
    //hide previous digits from the canvas
    stroke(255);
    fill(255);
    rect(0, height-50, width, 50);
    
    //reset pos
    pos = 0;
  }

  fill(0);
  textSize(18);
  text(n, pos, height-15);
  //increment pos
  pos += 25;
}

void drawLabels() {
  //reset angle
  angle = 0;
  for (int i = 0; i <= 9; i++) {
    x =((r+13) * cos(angle))+(origin - 10);  //add origin and center it
    y =((r+13) * sin(angle))+(origin + 7);

    fill(0);
    textSize(20);
    text(i, x, y);
    ////increment angle
    angle += (PI/10)*2;
  }
}

void mousePressed() {
  saveFrame("screenshot.jpg");
}
