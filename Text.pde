class Text {
  String content;
  float x, y;
  color stroke;
  int alignX, alignY, size;

  Text(String t, float xpos, float ypos, int s, color textFill) {
    content = t;
    x = xpos;
    y = ypos;
    stroke = textFill;
    size = s;
    alignX = CENTER;    // Default align is CENTER, CENTER
    alignY = CENTER;
  }

  void display(PGraphics c) {
    c.textAlign(alignX, alignY);
    c.textSize(size);

    c.noFill();
    c.fill(stroke);

    c.text(content, x, y);
  }
  
  void align(int ax, int ay){
    alignX = ax;
    alignY = ay;
  }
}
