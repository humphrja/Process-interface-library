import java.util.Arrays;

class Window {
  Palette palette;
  Button[] btns = new Button[0];
  Text[] texts = new Text[0];
  ScrollWindow[] sWindows = new ScrollWindow[0];


  Method[] displayMethods = new Method[0];
  Object[][] displayArgs = new Object[0][0];
  Object[] classInstances = new Object[0];


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
    c.rect(x, y, winWidth, winHeight);                // Background


    for (int i = 0; i < displayMethods.length; i++) { // Content
      try {
        c.pushMatrix();
        displayMethods[i].invoke(classInstances[i], displayArgs[i]);
        c.popMatrix();
      } 
      catch (Exception e) {
        e.printStackTrace();
      }
    }

    for (Button b : btns) {                           // Buttons
      b.display(c);
    }

    for (Text t : texts) {                            // Text
      t.display(c);
    }

    for (ScrollWindow sw : sWindows) {                // Scroll windows
      sw.display(sw.canvas);
    }

    if (border) {                                     // Border
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


  //Object[] appendObject(Object object, Object[] array){
  //  array = Arrays.copyOf(array, array.length + 1);
  //  array[array.length - 1] = object;
  //  return array;
  //}


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

  Method addContent(String mName, Object[] args, Object classInstance) {    // Provide the appropriate visual function(s) the window should display by adding a method to the window
    Method displayContent = null;

    Method[] methods = classInstance.getClass().getDeclaredMethods();       // Returns all methods within the appropriate class into an array

    for (Method m : methods) {                                              // Searches through the array by method name and assigns onPress to the corresponding method
      if (m.getName() == mName) {
        println(m);
        displayContent = m;
      }
    }


    displayMethods = Arrays.copyOf(displayMethods, displayMethods.length + 1);
    displayMethods[displayMethods.length - 1] = displayContent;

    displayArgs = Arrays.copyOf(displayArgs, displayArgs.length + 1);
    displayArgs[displayArgs.length - 1] = args;

    classInstances = Arrays.copyOf(classInstances, classInstances.length + 1);
    classInstances[classInstances.length - 1] = classInstance;

    return displayContent;
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

  void displayScrollButtons() {
    ;
  }
}
