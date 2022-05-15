Window[] windows;
int currentWindow;

void setup() {
  size(1000, 1000);

  currentWindow = 0;
  windows = new Window[7];

  Events E = new Events();

  Palette winPalette = new Palette(color(#352D39), color(#FFFFFF), color(#3a9bd8), color(#E05263), color(#DC6BAD));

  int nx = 3;
  int ny = 2;
  int btnW = 150;
  int btnH = 100;
  int spacing = 25;

  Window w = new Window(winPalette);        // Main menu - select an example window
  Text t = w.addText("Choose an example window", width/2, 100, 35);
  t.align(CENTER, BOTTOM);

  float ix = width/2 - (ny*btnW + (ny-1)*spacing)/2;
  float iy = height - (ny*btnH + (ny-1)*spacing);

  createStartBtnGrid(w);

  windows[0] = w;
  w.addButton("close", new Object[] {}, this, "Exit", width/2 - 100, height - 100, 200, 70);


  Palette p2 = new Palette(color(#05F140), color(#1A181B), color(#2CDA9D), color(#3E8989), color(#564D65));
  Window w1 = new Window(p2);      // Different colour palette
  createBackToHomeBtn(w1);
  w1.addHeading("Windows can have different colour palettes.");

  windows[1] = w1;


  Window w2 = new Window(winPalette);      // Display different content
  createBackToHomeBtn(w2);
  w2.addHeading("Windows can display content from custom methods too");
  w2.addContent("exampleDisplayMethod", new Object[] {}, this);

  windows[2] = w2;


  Window w3 = new Window(winPalette);      // Be of different sizes and be within each other
  createBackToHomeBtn(w3);
  w3.addHeading("Windows can exist within different windows!");

  windows[3] = w3;


  Window w4 = new Window(winPalette);      // Scroll window
  createBackToHomeBtn(w4);
  w4.addHeading("Scroll windows allow you to have scroll features :)");

  windows[4] = w4;


  Window w5 = new Window(winPalette);      // Buttons - shows different type of button activations -> on_press, on_release, hold
  createBackToHomeBtn(w5);
  w5.addHeading("Buttons can have different activation types...");
  Button btn1 = w5.addButton("testString", new Object[] {"aa"}, E, "On Release", 100, 300, 200, 70);
  Button btn2 = w5.addButton("testString", new Object[] {"aa"}, E, "On Press", 350, 300, 200, 70);
  btn2.setActivation("on_press");
  Button btn3 = w5.addButton("testString", new Object[] {"aa"}, E, "Hold", 600, 300, 200, 70);
  btn3.setActivation("hold");
  

  windows[5] = w5;


  Window w6 = new Window(winPalette);      // Button recursion
  createBackToHomeBtn(w6);
  w6.addHeading("Recursion?!");
  w6.addButton("addNewButton", new Object[] {w6}, E, "btn", random(width), random(height), 100, 100);

  windows[6] = w6;


  frameRate(120);

  arms[0] = new Arm(200, 0.02, -0.05);
  arms[1] = new Arm(100, -0.04, 0);

  prevPoint = PVector.add(arms[0].position, arms[1].position);

  dotCanvas = createGraphics(width, height);
}

void draw() {
  background(0);

  windows[currentWindow].display(g);                    // g is the default PGraphics object for the main sketch
}

Button[] createBtns() {
  Palette btnPalette = new Palette(color(#3a9bd8), color(#E05263), color(#DC6BAD), color(#FFFCF9));

  Button btn1 = new Button("testString", new Object[] {"Hello"}, new Events(), "string", 20, 20, 200, 100, btnPalette);
  Button btn2 = new Button("testInt", new Object[] {4, 'a'}, new Events(), "int", 300, 150, 50, 50, btnPalette);

  Object[] btnArgs = new Object[] {new PVector(10, 200)};
  Button btn3 = new Button("testVector", btnArgs, new Events(), "vector", 50, 180, 100, 70, btnPalette);

  Button[] btns = {btn1, btn2, btn3};

  return btns;
}


void createStartBtnGrid(Window w) {
  int nx = 3;
  int ny = 2;
  int btnW = 150;
  int btnH = 100;
  int spacing = 25;

  float ix = width/2 - (nx*btnW + (nx-1)*spacing)/2;
  float iy = height - (ny*btnH + (ny+1)*spacing) - 150;

  String f = "setWindow";


  String[] labels = {"Colour", "Visuals", "Sub-windows", "Scroll windows", "Buttons", "Recursion"};

  for (int row = 0; row < ny; row++) {
    for (int col = 0; col < nx; col++) {
      float x = ix + col*(btnW + spacing);
      float y  = iy + row*(btnH + spacing);

      Object[] args = new Object[] {col + row*nx + 1};
      w.addButton(f, args, this, labels[col + row*nx], x, y, btnW, btnH);
    }
  }
}


void createBackToHomeBtn(Window w) {
  w.addButton("setWindow", new Object[] {0}, this, "Back to main menu", w.winWidth - 120, w.winHeight - 120, 100, 100);
}

void close(){
  exit();
}


class Events {

  void testString(String str) {
    fill(255, 0, 0);
    ellipse(width/2, height/2 + 200, 150, 150);
    println(str);
  }

  void testChar(char c) {
    ellipse(100, 100, 100, 100);
    println(c);
  }

  void testInt(int i, char c) {
    ellipse(200, 100, 100, 100);
    println(i, c);
  }

  void testVector(PVector r) {
    ellipse(r.x, r.y, 80, 80);
  }

  void addNewButton(Window window) {
    window.addButton("addNewButton", new Object[] {window}, new Events(), "btn", random(width - 100), random(height - 100), 100, 100);
  }
}


void setWindow(int newWindowNum) {
  currentWindow = newWindowNum;
}


void testFunction() {
  println("Testing PApplet base class");
}


void testWindowDisplay(int offset) {
  println(frameCount % 200);
  float a = map(frameCount % 200, 0, 200, 0, 360);

  colorMode(HSB, 360, 100, 100); 
  fill(a, 255, 255);
  ellipse(mouseX + offset, mouseY, 100, 100);
}



Arm[] arms = new Arm[2];
PGraphics dotCanvas;
PVector prevPoint;

void exampleDisplayMethod() {
  float w = width - 100;
  float h = height - 300;
  fill(255);
  rect(50, 150, w, h);

  translate(width/2, height/2); 

  PVector resultant = new PVector(0, 0);
  for (Arm tempArm : arms) {
    //tempArm.display();
    if (tempArm.visible) {
      stroke(0);
    } else {
      stroke(255, 0);
    }

    strokeWeight(2);
    circle(resultant.x + tempArm.position.x, resultant.y + tempArm.position.y, 0.25*tempArm.position.mag());


    resultant.add(tempArm.position);
    tempArm.update();
  }
  circle(0, 0, 60);

  dotCanvas.beginDraw();
  dotCanvas.translate(width/2.0, height/2.0);
  dotCanvas.stroke(0, 100);
  //dotCanvas.strokeWeight(4)
  //dotCanvas.point(resultant.x, resultant.y)
  dotCanvas.strokeWeight(2);
  dotCanvas.line(prevPoint.x, prevPoint.y, resultant.x, resultant.y);
  dotCanvas.endDraw();
  image(dotCanvas, -width/2.0, -height/2.0);

  prevPoint = resultant;
}



class Arm {
  float rotRate;
  float growRate;

  PVector position = new PVector(1.0, 0.0);

  boolean visible = true;
  boolean pMousePressed = false;

  Arm(float radius, float dtheta, float dr) {
    position.setMag(radius);

    rotRate = dtheta;
    growRate = dr;
  }

  void update() {
    position.rotate(rotRate);
    position.setMag(position.mag() + growRate);

    if (mousePressed && !pMousePressed) {
      visible = !visible;
    }

    pMousePressed = mousePressed;
  }

  void display() {
    if (visible) {
      strokeWeight(2);
    }
  }
}
