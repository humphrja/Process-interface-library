// The Text object is used to display text to the screen, like a textbox or a title

class Text {
  String content;
  float x, y;
  color stroke;
  int alignX, alignY, size;
  
  boolean underline;
  float underlineLength;

  Text(String t, float xpos, float ypos, int s, color textFill) {
    content = t;
    x = xpos;
    y = ypos;
    stroke = textFill;
    size = s;
    alignX = CENTER;            // Default align is CENTER, CENTER
    alignY = CENTER;
    underline = false;
  }

  void display(PGraphics c) {
    c.textAlign(alignX, alignY);
    c.textSize(size);

    c.noFill();
    c.fill(stroke);

    c.text(content, x, y);
    
    if (underline){
      c.stroke(stroke);
      c.strokeWeight(4);
      c.line(x - underlineLength/2, y + 5, x + underlineLength/2, y + 5);
    }
  }
  
  void align(int ax, int ay){
    alignX = ax;                // LEFT, CENTER or RIGHT
    alignY = ay;                // TOP, CENTER or BOTTOM
  }
  
  void underline(float l){
    underline = true;
    underlineLength = l;
  }
}
