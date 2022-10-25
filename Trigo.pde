import garciadelcastillo.dashedlines.*;
DashedLines dash;

float width = 1100;
float height = 1100;

float circleDiameter = 500;
float circleRayon = circleDiameter / 2;
float pointDiameter = 20;
float pointCoordCirclesDiameter = 10;

float miniLinesCount = 10;
float minilineWidth = 5;

float legendMargin = 30;

PVector pi3, pi4, pi6;
PVector point;

float deg = 0;
float manualDeg;
float rad;
float manualRad;
float turnRate = 0.9;

PVector mousePos;
PVector dir;

color green = #2DAD4C;
color blue = #5375EA;
color orange = #C68336;
color red = #FF0000;
color Cvisible = #EAEAEA;
color Chidden = #675D5D;
color Chovered = #AAAAAA;

float arrayHeight = 50;
float arrayWidth = 90;
int arrayLines = 3;
int arrayColumns = 4;
PVector arrayOrigin;

boolean B3 = true;
boolean B4 = true;
boolean B6 = true;
PVector B3c;
PVector B4c;
PVector B6c;
float piButtonDiameter = 18;

PVector switchBtn;
boolean manual = false;


void settings(){size((int)width,(int)height);}

void setup()
{
  dash = new DashedLines(this);
  textAlign(CENTER, CENTER);
  
  mousePos = new PVector();
  arrayOrigin = new PVector(700,70);
  B3c = new PVector(arrayOrigin.x + arrayWidth/2 + arrayWidth, arrayOrigin.y - 20);
  B4c = new PVector(arrayOrigin.x + arrayWidth/2 + arrayWidth * 2, arrayOrigin.y - 20);
  B6c = new PVector(arrayOrigin.x + arrayWidth/2 + arrayWidth * 3, arrayOrigin.y - 20);
  
  pi3 = new PVector(cos(PI/3) * circleRayon + width/2,  -sin(PI/3) * circleRayon + height/2);
  pi4 = new PVector(cos(PI/4) * circleRayon + width/2,  -sin(PI/4) * circleRayon + height/2);
  pi6 = new PVector(cos(PI/6) * circleRayon + width/2,  -sin(PI/6) * circleRayon + height/2);
  
  switchBtn = new PVector(970, 920);
}

void draw()
{
  background(0);
  
  
  
  drawLines();
  drawCircle();
  drawArray();
  drawPoint(manual); 
  drawResults();
  drawSwitch();
  
}

void drawPoint(boolean man)
{
  if(!man)
  {
    deg = (deg +turnRate) % 360;
    rad = deg * (PI/180);
  }
  else
  {
    rad = calcAngle();
    deg = rad * (180/PI);
  }
  point = new PVector(cos(rad) * circleRayon + width/2, -sin(rad) * circleRayon + height/2);
 
  fill(255,0,0);
  noStroke();
  circle(point.x, point.y, pointDiameter);
  drawPointLines();
}

void drawPointLines()
{
  stroke(red);
  strokeWeight(2);
  dash.pattern(10, 10);
  dash.line(width/2, point.y, point.x, point.y);
  dash.line(point.x, height/2, point.x, point.y);
  circle(width/2, point.y, pointCoordCirclesDiameter);
  circle(point.x, height/2, pointCoordCirclesDiameter);
}

void drawSwitch()
{
  fill(255);
  textSize(42);
  text("Manual :", 860, 910);
  noStroke();
  if(!manual)
  {
    fill(255,0,0);
  }
  else
  {
    fill(0,255,0);
  }
  circle(switchBtn.x, switchBtn.y, 30);
}

void drawLines()
{  
  if(B3) drawDottedLineToAxes(pi3, green);
  if(B4) drawDottedLineToAxes(pi4, blue);
  if(B6) drawDottedLineToAxes(pi6, orange);
}

void drawDottedLineToAxes(PVector coord, color col)
{
  stroke(col, 180);
  strokeWeight(2.5);
  dash.pattern(5, 5);
  dash.line(width/2, height/2, coord.x, coord.y);
  stroke(col, 100);
  strokeWeight(2);
  dash.pattern(10, 10);
  dash.line(coord.x, coord.y, width/2, coord.y);
  dash.line(coord.x, coord.y, coord.x, height/2);
}


void drawResults()
{
  textAlign(LEFT, CENTER);
  fill(255);
  textSize(42);
  String degree = "DEG : " + nf(deg, 3, 1) + "°";
  String radian = "RAD : " + nf(rad, 1, 2);
  String pi = nf(rad/PI, 1, 1) + " π ";
  String cos = "Cos x : " + nf(cos(rad), 1, 2);
  String sin = "Sin x : " + nf(sin(rad), 1, 2);
  text(degree, 60, 80);
  text(radian, 60, 140);
  text(pi, 60, 200);
  text(cos, 60, 850);
  text(sin, 60, 910);
  textAlign(CENTER, CENTER);
}


void drawCircle()
{
  fill(0, 0);
  stroke(255);
  strokeWeight(4);
  circle(width/2, height/2, circleDiameter);
  
  stroke(255);
  strokeWeight(1);
  line(width/2 - circleRayon, height/2, width/2 + circleRayon, height / 2);     
  line(width/2, height/2 - circleRayon, width/2, height / 2 + circleRayon);
  
  float threshold = circleRayon / miniLinesCount;
  for(int i=1; i<=miniLinesCount; i++)
  {
    line(width/2 - minilineWidth, height/2 - threshold*i, width/2 + minilineWidth, height/2 - threshold*i);
    line(width/2 + threshold*i, height/2 - minilineWidth, width/2 + threshold*i, height/2 + minilineWidth);
    
    line(width/2 - minilineWidth, height/2 - threshold*-i, width/2 + minilineWidth, height/2 - threshold*-i);
    line(width/2 + threshold*-i, height/2 - minilineWidth, width/2 + threshold*-i, height/2 + minilineWidth);
  }
  
  drawLegend();
}

void drawLegend()
{
  fill(255);
  textSize(24);
  
  text("0 | 2π", width/2 + circleRayon + legendMargin*3, height/2);
  text("π/2", width/2, height/2 - circleRayon - legendMargin*3);
  text("π", width/2 - circleRayon - legendMargin*3, height/2);
  text("3π/2", width/2, height/2 + circleRayon + legendMargin*3);
  
  textSize(17);
  
  text("1", width/2 + circleRayon + legendMargin, height/2);
  text("-1", width/2 - circleRayon - legendMargin, height/2);
  text("1", width/2, height/2 - circleRayon - legendMargin);
  text("-1", width/2, height/2 + circleRayon + legendMargin);
  
  if(B3)
  {
    text("1/2", width/2 + (circleRayon /2), height/2 + legendMargin);
    text("√3/2", width/2 -legendMargin, height/2 - ((circleRayon / 2) * sqrt(3)));
    text("π/3", pi3.x + calcVecOffset(pi3).x * 40, pi3.y - calcVecOffset(pi3).y * 40);
  }
  if(B6)
  {
    text("√3/2", width/2 + ((circleRayon / 2) * sqrt(3)), height/2 +legendMargin);
    text("1/2", width/2 - legendMargin, height/2 - (circleRayon /2));
    text("π/6", pi6.x + calcVecOffset(pi6).x * 40, pi6.y - calcVecOffset(pi6).y * 40);
  }
  if(B4)
  {
    text("√2/2", width/2 + ((circleRayon / 2) * sqrt(2)), height/2 + legendMargin);
    text("√2/2", width/2 - legendMargin, height/2 - ((circleRayon / 2) * sqrt(2)));
    text("π/4", pi4.x + calcVecOffset(pi4).x * 40, pi4.y - calcVecOffset(pi4).y * 40);
  }
}

PVector calcVecOffset(PVector point)
{  
  PVector newDir = new PVector(point.x - width/2, point.y - height/2);
  newDir.y = -newDir.y;
  newDir.normalize();
  return newDir;
}

float calcAngle()
{
  mousePos.y = mouseY;
  mousePos.x = mouseX;
  dir = new PVector(mousePos.x - width/2, mousePos.y - height/2);
  return myAngleBetween(new PVector(dir.x, -dir.y), new PVector(0,1));
}

float myAngleBetween (PVector myPVector1, PVector myPVector2) {
  float a = atan2(myPVector1.y-myPVector2.y, myPVector1.x-myPVector2.x);
  if (a<0) { a+=TWO_PI; }
  return a;
}

void drawArray()
{
  for(int i=0; i<=arrayLines; i++)
    line(arrayOrigin.x, arrayOrigin.y + arrayHeight*i, arrayOrigin.x + arrayWidth*arrayColumns, arrayOrigin.y + arrayHeight*i);
  for(int i=0; i<=arrayColumns; i++)
    line(arrayOrigin.x + arrayWidth*i, arrayOrigin.y, arrayOrigin.x + arrayWidth*i, arrayOrigin.y + arrayLines * arrayHeight);
  writeArrayInfos();
  drawVisibilityCircle(B3c, B3);
  drawVisibilityCircle(B4c, B4);
  drawVisibilityCircle(B6c, B6);
}

void writeArrayInfos()
{
  fill(255);
  textSize(20);
  text("x", arrayOrigin.x + arrayWidth /2 , arrayOrigin.y + arrayHeight/2);
  text("Cos  x", arrayOrigin.x + arrayWidth /2 , arrayOrigin.y + arrayHeight + arrayHeight/2);
  text("Sin  x", arrayOrigin.x + arrayWidth /2 , arrayOrigin.y + arrayHeight*2 + arrayHeight/2);
  if(B3) fill(green);
  else fill(green, 150);
  text("π/3", arrayOrigin.x + arrayWidth /2 + arrayWidth , arrayOrigin.y + arrayHeight/2);
  text("1/2", arrayOrigin.x + arrayWidth /2 + arrayWidth , arrayOrigin.y + arrayHeight/2 + arrayHeight);
  text("√3/2", arrayOrigin.x + arrayWidth /2 + arrayWidth , arrayOrigin.y + arrayHeight/2 + arrayHeight * 2);
  if(B4) fill(blue);
  else fill(blue, 150);
  text("π/4", arrayOrigin.x + arrayWidth /2 + arrayWidth *2, arrayOrigin.y + arrayHeight/2);
  text("√2/2", arrayOrigin.x + arrayWidth /2 + arrayWidth * 2 , arrayOrigin.y + arrayHeight/2 + arrayHeight);
  text("√2/2", arrayOrigin.x + arrayWidth /2 + arrayWidth * 2 , arrayOrigin.y + arrayHeight/2 + arrayHeight * 2);
  if(B6) fill(orange);
  else fill(orange, 150);
  text("π/6", arrayOrigin.x + arrayWidth /2 + arrayWidth *3, arrayOrigin.y + arrayHeight/2);
  text("1/2", arrayOrigin.x + arrayWidth /2 + arrayWidth * 3 , arrayOrigin.y + arrayHeight/2 + arrayHeight *2);
  text("√3/2", arrayOrigin.x + arrayWidth /2 + arrayWidth * 3 , arrayOrigin.y + arrayHeight/2 + arrayHeight);
}

void drawVisibilityCircle(PVector vec, boolean visible)
{
  
  if(overCircle(vec.x, vec.y, piButtonDiameter) && visible) fill(Chovered);
  else
  {
    if(visible){fill(Cvisible);}
    else{fill(Chidden);}
  }
  
  noStroke();
  circle(vec.x, vec.y, piButtonDiameter);
}

boolean overCircle(float x, float y, float diameter)
{
  float disX = x - mouseX;
  float disY = y - mouseY;
  if (sqrt(sq(disX) + sq(disY)) < diameter/2 ) {
    return true;
  } else {
    return false;
  }
}

void mousePressed() 
{
  if(overCircle(B3c.x, B3c.y, piButtonDiameter))
    B3 = !B3;
  else if(overCircle(B4c.x, B4c.y, piButtonDiameter))
    B4 = !B4;
  else if(overCircle(B6c.x, B6c.y, piButtonDiameter))
    B6 = !B6;
  if(overCircle(switchBtn.x, switchBtn.y, 30))
    manual = !manual;
}
