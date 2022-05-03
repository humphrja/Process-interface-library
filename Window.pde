import java.util.Arrays;

class Window {
  Palette palette;
  Button[] btns = new Button[0];
  Text[] texts = new Text[0];
  ScrollWindow[] sWindows = new ScrollWindow[0];

  int x, y, winWidth, winHeight;
  boolean border;
  int borderStrokeWeight;

  Window(Palette cols) {
    palette = cols;

    x = y = 0;
    winWidth = width;
    winHeight = height;
    border = false;
    borderStrokeWeight = 0;
  }


  void display(PGraphics c) {    // c = canvas
    c.noStroke();
    c.fill(palette.background);
    c.rect(x, y, winWidth, winHeight);

    for (Button b : btns) {
      b.display(c);
    }

    for (Text t : texts) {
      t.display(c);
    }
    
    for (ScrollWindow sw : sWindows){
      sw.display(sw.canvas);
    }

    if (border) {
      c.strokeWeight(borderStrokeWeight);
      c.stroke(palette.stroke);
      c.noFill();
      c.rect(x, y, winWidth, winHeight);
    }
  }

  void setSize(int w, int h) {
    winWidth = w;
    winHeight = h;
  }

  void position(int xpos, int ypos) {
    x = xpos;
    y = ypos;
  }


  Button addButton(String methodName, Object[] methodArgs, Object instance, String label, float btnx, float btny, float w, float h) {
    Button btn = new Button(methodName, methodArgs, instance, label, btnx + x, btny + y, w, h, palette);

    btns = Arrays.copyOf(btns, btns.length + 1);
    btns[btns.length - 1] = btn;

    return btn;
  }

  Text addText(String text, float tx, float ty, int size) {
    Text txt = new Text(text, tx + x, ty + y, size, palette.stroke);

    texts = Arrays.copyOf(texts, texts.length + 1);
    texts[texts.length - 1] = txt;    

    return txt;
  }
}


class ScrollWindow extends Window {
  PGraphics canvas;             // scrollCanvas
  float scroll;                 // Represents the vertical translation of the window
  
  ScrollWindow(Palette cols, int x, int y, int w, int h) {
    super(cols);    // This is like creating a new Window object
    
    setSize(w, h);
    position(x, y);
    
    canvas = createGraphics(w, h);
    scroll = 0;
  }
  
  void displayScrollButtons(){
    ;
  }
}
