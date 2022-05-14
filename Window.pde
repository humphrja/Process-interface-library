import java.util.Arrays;

// A Window is a class that contains a collection of 'elements' - other interface objects, such as buttons, text or other windows.

class Window {
  Palette palette;                                    // Each window has its own colour palette. This palette is transferred to the interface elements within the window
  Button[] btns = new Button[0];
  Text[] texts = new Text[0];
  ScrollWindow[] sWindows = new ScrollWindow[0];      // These arrays contain the window's elements


  // These 3 arrays are used for displaying any visual methods
  Method[] displayMethods = new Method[0];            // Contains the display methods
  Object[][] displayArgs = new Object[0][0];          // Contains the arguments for the methods
  Object[] classInstances = new Object[0];            // Contains the instances of the methods' classes


  int x, y, winWidth, winHeight;
  boolean border;
  int borderStrokeWeight;


  Window(Palette cols) {
    palette = cols;

    x = y = 0;                                        // By default, the dimensions of a window are the screen size
    winWidth = width;
    winHeight = height;
    border = false;
    borderStrokeWeight = 0;
  }


  void display(PGraphics c) {                         // c is short for canvas
    c.noStroke();
    c.fill(palette.background);
    c.rect(x, y, winWidth, winHeight);                // Background


    // Display non-interface related visual content
    for (int i = 0; i < displayMethods.length; i++) {     // Loops through each display method and invokes it
      try {
        c.pushMatrix();
        displayMethods[i].invoke(classInstances[i], displayArgs[i]);
        c.popMatrix();                                    // pushMatrix() & popMatrix() are used to preserve any changes to the canvas, such as translations, scaling, etc.
      } 
      catch (Exception e) {                               // Handles any errors (Java requirement)
        e.printStackTrace();
      }
    }

    for (Button b : btns) {                           // Display buttons
      b.display(c);
    }

    for (Text t : texts) {                            // Display text
      t.display(c);
    }

    for (ScrollWindow sw : sWindows) {                // Display scroll windows
      sw.display(sw.canvas);                              // Scroll windows display to a different PGraphics object (canvas) than the window itself
    }

    if (border) {                                     // Display border
      c.strokeWeight(borderStrokeWeight);
      c.stroke(palette.stroke);
      c.noFill();
      c.rect(x, y, winWidth, winHeight);
    }
  }

  void setDimensions(int xpos, int ypos, int w, int h) {    // Used to override window's default dimensions
    x = xpos;
    y = ypos;
    winWidth = w;
    winHeight = h;
  }



  // These methods are used to add interface elements to the window. Note that a palette is not required as the elements inherit the window's palette
  // All of these methods are of the form:
  // Create new interface object
  // Append object to appropriate array
  // Return interface object

  // The created object is returned so as to easily override any default parameters

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

    for (Method m : methods) {                                              // Searches through the array by method name and assigns displayContent to the corresponding method
      if (m.getName() == mName) {
        println(m);
        displayContent = m;
      }
    }


    displayMethods = Arrays.copyOf(displayMethods, displayMethods.length + 1);  // Append method details to each array
    displayMethods[displayMethods.length - 1] = displayContent;

    displayArgs = Arrays.copyOf(displayArgs, displayArgs.length + 1);
    displayArgs[displayArgs.length - 1] = args;

    classInstances = Arrays.copyOf(classInstances, classInstances.length + 1);
    classInstances[classInstances.length - 1] = classInstance;

    return displayContent;
  }
}


// A ScrollWindow is like a window, except that it's content can be scrolled through using a scroll bar, scroll buttons or the mouse scroll wheel

class ScrollWindow extends Window {
  PGraphics canvas;             // scrollCanvas
  float scroll;                 // Represents the vertical translation of the content

  ScrollWindow(Palette cols, int x, int y, int w, int h) {
    super(cols);    // This is like creating a new Window object

    setDimensions(x, y, w, h);

    canvas = createGraphics(w, h);
    scroll = 0;
  }

  void displayScrollButtons() {
    ;
  }
}
