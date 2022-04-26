import java.util.Arrays;

class Window {
  Palette palette;
  Button[] btns = new Button[0];
  Text[] texts = new Text[0];

  float x, y, winWidth, winHeight;
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


  void display() {
    noStroke();
    fill(palette.background);
    rect(x, y, winWidth, winHeight);

    for (Button b : btns) {
      b.display();
    }

    for (Text t : texts) {
      t.display();
    }

    if (border) {
      strokeWeight(borderStrokeWeight);
      stroke(palette.stroke);
      noFill();
      rect(x, y, winWidth, winHeight);
    }
  }

  void setSize(float w, float h) {
    winWidth = w;
    winHeight = h;
  }

  void position(float xpos, float ypos) {
    x = xpos;
    y = ypos;
  }


  Button addButton(String methodName, Object[] methodArgs, String label, float btnx, float btny, float w, float h) {
    Button btn = new Button(methodName, methodArgs, label, btnx + x, btny + y, w, h, palette);

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
