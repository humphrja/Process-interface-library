Window win1;
Window win2;

Window[] windows;

int currentWindow;


void setup() {
  size(1000, 1000);
  background(51);

  Events E = new Events();

  PApplet P = new PApplet();

  windows = new Window[2];
  currentWindow = 0;

  Palette winPalette = new Palette(color(#352D39), color(#FFFFFF), color(#3a9bd8), color(#E05263), color(#DC6BAD));
  windows[0] = new Window(winPalette);
  windows[0].setSize(600, 600);
  windows[0].position(100, 100);
  windows[0].addButton("testFunction", new Object[] {}, this, "This is window 1", 50, 50, 250, 80);
  windows[0].addButton("setWindow", new Object[] {1}, E, "Change to window 1", windows[0].winWidth - 120, windows[0].winHeight - 120, 100, 100);

  windows[1] = new Window(winPalette);
  windows[1].addButton("testString", new Object[] {"Hello"}, E, "This is window 2", 5, 5, 100, 100);
  windows[1].addButton("setWindow", new Object[] {0}, E, "Change to window 2", width - 120, height - 120, 100, 100);

  Text txt = windows[0].addText("test", width/2, 200, 40);
  //txt.align(LEFT, TOP);


  windows[1].addContent("testWindowDisplay", new Object[] {100}, this);
  windows[1].addContent("testWindowDisplay", new Object[] {-100}, this);
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



class Events {

  void testString(String str) {
    fill(255, 0, 0);
    ellipse(width/2, height/2, 50, 50);
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

  void setWindow(int newWindowNum) {
    currentWindow = newWindowNum;
  }
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
