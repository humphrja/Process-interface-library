Button[] buttons;

void setup() {
  size(400, 400);
  buttons = createBtns();
}

void draw() {
  background(#352D39);

  for (Button btn : buttons) {
    btn.display();
  }
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
  }

  void testChar(char c) {
    ellipse(100, 100, 100, 100);
    println(c);
  }

  void testInt(int i, char c) {
    ellipse(200, 100, 100, 100);
    println(i, c);
  }
  
  void testVector(PVector r){
    ellipse(r.x, r.y, 80, 80);
  }
  
  void newMethod(){
    print("Git test.");
  }
}
