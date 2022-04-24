Window win1;
Window win2;

Window[] windows;

int currentWindow;


void setup() {
  size(400, 400);
  
  windows = new Window[2];
  currentWindow = 0;

  Palette winPalette = new Palette(color(#3a9bd8), color(#E05263), color(#DC6BAD), color(#FFFCF9));
  windows[0] = new Window(winPalette);
  windows[0].addButton("testInt", new Object[] {4, 'a'}, "window0!", 5, 5, 100, 100, 20);
  windows[0].addButton("setWindow", new Object[] {1}, "change to win1", width - 120, height - 120, 100, 100, 20);
  
  windows[1] = new Window(winPalette);
  windows[1].addButton("testString", new Object[] {"Hello"}, "window1!", 5, 5, 100, 100, 20);
  windows[1].addButton("setWindow", new Object[] {0}, "change to win0", width - 120, height - 120, 100, 100, 20);
}

void draw() {
  background(#352D39);
 
  windows[currentWindow].display();
}

Button[] createBtns() {
  Palette btnPalette = new Palette(color(#3a9bd8), color(#E05263), color(#DC6BAD), color(#FFFCF9));

  Button btn1 = new Button("testString", new Object[] {"Hello"}, "string", 20, 20, 200, 100, btnPalette, 20);
  Button btn2 = new Button("testInt", new Object[] {4, 'a'}, "int", 300, 150, 50, 50, btnPalette, 20);

  Object[] btnArgs = new Object[] {new PVector(10, 200)};
  Button btn3 = new Button("testVector", btnArgs, "vector", 50, 180, 100, 70, btnPalette, 20);

  Button[] btns = {btn1, btn2, btn3};

  return btns;
}



class Events {

  void testString(String str) {
    fill(255, 0, 0);
    ellipse(width/2, height/2, 50, 50);
    println(str);
    //btn1.selected = true
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
  
  void addNewButton(Window window){
    window.addButton("addNewButton", new Object[] {window}, "btn", random(width - 100), random(height - 100), 100, 100, 20);
  }
  
  void setWindow(int newWindowNum){
    currentWindow = newWindowNum;
  }
}
