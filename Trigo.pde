import garciadelcastillo.dashedlines.*;
DashedLines dash;

float width = 1000;
float height = 1000;

float circleDiameter = 600;
float circleRayon = circleDiameter / 2;
float miniLinesCount = 10;
float minilineWidth = 5;

PVector pi3, pi4, pi5;

float deg = 0;
float rad;
float rate = 1;
PVector point;

PVector dir;
PVector mousePos;


void settings()
{
  size((int)width,(int)height);
}

void setup()
{
  dash = new DashedLines(this);
  
  pi3 = new PVector(cos(PI/3) * circleRayon + width/2,  -sin(PI/3) * circleRayon + height/2);
  pi4 = new PVector(cos(PI/4) * circleRayon + width/2,  -sin(PI/4) * circleRayon + height/2);
  pi5 = new PVector(cos(PI/6) * circleRayon + width/2,  -sin(PI/6) * circleRayon + height/2);
  
}

void draw()
{
  background(0);
  deg += rate;
  rad = deg * (PI/180);
  mousePos = new PVector();
  mousePos.y = mouseY;
  mousePos.x = mouseX;
  dir = new PVector(mousePos.x - width/2, mousePos.y - height/2);
  
  drawLines();
  drawNumbers();
  drawCircle();
  drawPoint();  
}

void drawPoint()
{
  point = new PVector(cos(rad) * circleRayon + width/2, -sin(rad) * circleRayon + height/2);
  fill(255,0,0);
  noStroke();
  circle(point.x, point.y, 20);
  drawPointLines();
}

void drawPointLines()
{
  stroke(255,0,0);
  strokeWeight(2);
  dash.pattern(10, 10);
  dash.line(width/2, point.y, point.x, point.y);
  dash.line(point.x, height/2, point.x, point.y);
  circle(width/2, point.y, 10);
  circle(point.x, height/2, 10);
}

void drawCircle()
{
  fill(0, 0);
  stroke(255);
  strokeWeight(4);
  circle(width/2, height/2, circleDiameter); 
}

void drawLines()
{
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
  
  drawDottedLineToAxes(pi3);
  drawDottedLineToAxes(pi4);
  drawDottedLineToAxes(pi5);
}

void drawDottedLineToAxes(PVector coord)
{
  stroke(255);
  strokeWeight(2.5);
  dash.pattern(5, 5);
  dash.line(width/2, height/2, coord.x, coord.y);
  stroke(150);
  strokeWeight(1);
  dash.pattern(10, 10);
  dash.line(coord.x, coord.y, width/2, coord.y);
  dash.line(coord.x, coord.y, coord.x, height/2);
}

void drawNumbers()
{
  fill(255);
  textSize(20);
  textAlign(CENTER);
  text("1", width/2 + circleRayon + 20, height/2);
  text("-1", width/2 - circleRayon - 20, height/2);
  text("1", width/2, height/2 - circleRayon - 20);
  text("-1", width/2, height/2 + circleRayon + 20);
  
  text("cos", width/2 + circleRayon + 60, height/2);
  text("sin", width/2, height/2 + circleRayon + 60);
}
