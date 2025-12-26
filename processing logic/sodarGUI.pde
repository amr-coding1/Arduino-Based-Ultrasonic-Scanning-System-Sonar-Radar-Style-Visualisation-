import processing.serial.*;

Serial myPort;
String rawData = "";
float distanceInPixels;
int angle = 0;
int distance = 999;
boolean showRedLine = false;

PFont myFont;

void setup() {
  size(1080, 720);
  smooth();

  // --- IMPORTANT: pick your Mac port here ---
  myPort = new Serial(this, "/dev/cu.usbmodem1101", 9600);
  myPort.bufferUntil('\n'); 

  myFont = createFont("Arial", 24);
  textFont(myFont);
}

void draw() {
  
  fill(0, 25);
  noStroke();
  rect(0, 0, width, height - 50);

  drawRadar();
  drawLine();
  drawObject();

 
  fill(0);
  noStroke();
  rect(0, height - 50, width, 50);

  drawText();
}

void serialEvent(Serial p) {
  rawData = p.readStringUntil('\n');
  if (rawData == null) return;

  rawData = trim(rawData); // removes \r \n spaces safely
  int commaIndex = rawData.indexOf(',');
  if (commaIndex == -1) return;

  // Parse
  try {
    angle = int(rawData.substring(0, commaIndex));
    distance = int(rawData.substring(commaIndex + 1));
  } catch (Exception e) {
    return;
  }

  // Clamp to sane limits
  angle = constrain(angle, 0, 180);
  distance = constrain(distance, 0, 400);

  // Radar range settings (match your choice)
  if (distance < 100) {
    showRedLine = true;
    distanceInPixels = map(distance, 0, 100, height * 0.025, height * 0.75);
  } else {
    showRedLine = false;
  }
}

void drawRadar() {
  pushMatrix();
  translate(width / 2, height - 50);
  noFill();
  strokeWeight(2);
  stroke(50, 250, 50);

  int numberOfCircles = 4;
  for (int i = 1; i <= numberOfCircles; i++) {
    float r = (height * 0.75) * (i / float(numberOfCircles));
    arc(0, 0, r * 2, r * 2, PI, TWO_PI);
  }

  // baseline
  line(-width/2 + 50, 0, width/2 - 50, 0);

  popMatrix();
}

void drawLine() {
  pushMatrix();
  translate(width / 2, height - 50);

  float lineLength = height * 0.75;
  float x2 = lineLength * cos(radians(angle));
  float y2 = -lineLength * sin(radians(angle));

  strokeWeight(4);
  stroke(50, 250, 50);
  line(0, 0, x2, y2);

  popMatrix();
}

void drawObject() {
  if (!showRedLine) return;

  pushMatrix();
  translate(width / 2, height - 50);

  float x = distanceInPixels * cos(radians(angle));
  float y = -distanceInPixels * sin(radians(angle));

  noStroke();
  fill(255, 0, 0);
  ellipse(x, y, 14, 14);

  popMatrix();
}

void drawText() {
  fill(255);
  textSize(22);

  String status = showRedLine ? "Target: In Range" : "Target: Out Of Range";

  int reversedAngle = 180 - angle;
  float inches = distance * 0.3937;
  String distStr = showRedLine ? nf(inches, 0, 2) + "''" : "0''";

  text("Abdul's Sonar Scan", 10, height - 15);
  text(status, width / 4, height - 15);
  text("Angle: " + reversedAngle + "°", width / 2, height - 15);
  text("Distance: " + distStr, 3 * width / 4, height - 15);
}
