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
    pushMatrix();
    translate(x, y);

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
      rect(0, 0, winWidth, winHeight);
    }
    popMatrix();
  }


  Button addButton(String methodName, Object[] methodArgs, String label, float x, float y, float w, float h) {
    Button btn = new Button(methodName, methodArgs, label, x, y, w, h, palette);

    btns = Arrays.copyOf(btns, btns.length + 1);
    btns[btns.length - 1] = btn;

    return btn;
  }

  Text addText(String text, float x, float y, int size) {
    Text txt = new Text(text, x, y, size, palette.stroke);

    texts = Arrays.copyOf(texts, texts.length + 1);
    texts[texts.length - 1] = txt;    

    return txt;
  }
}
