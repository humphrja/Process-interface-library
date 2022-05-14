import java.lang.Class;
import java.lang.reflect.*;

// A button is displayed as a rectangle with a text label. Buttons can be activated via the mouse to trigger an external event.

class Button {

  Method event;                    // The button triggers this event (method) when it is activated
  Object[] eventArgs;              // The arguments passed into the event method
  Object tempObj;                  // A temporary instance of the class used for invoking the event method
                                   //      use 'this' without quotation marks if the event is not within a class but just within the sketch (this refers to the instance of the PApplet class, see Processing documentation)

  String label, activationType;
  float minX, minY, btnWidth, btnHeight;
  Palette colours;
  int textSize, strokeWeight;

  boolean disabled, selected, pMousePressed;


  // When passing in args, use the following format:
  // new Object[] {arg1, arg2, arg3}
  
  // Example:
  // new Button("method_1", new Object[] {arg1, arg2, arg3}, this, "Click Me!", 100, 100, 200, 70, btnPalette)

  Button(String mName, Object[] args, Object classInstance, String t, float x, float y, float w, float h, Palette cols) {

    tempObj = classInstance;
    Method[] methods = classInstance.getClass().getDeclaredMethods();    // Returns all methods within the appropriate class into an array

    for (Method m : methods) {                                           // Searches through the array by method name and assigns onPress to the corresponding method
      if (m.getName() == mName) {
        //println(m);
        event = m;
      }
    }

    eventArgs = args;

    label = t;
    minX = x;
    minY = y;
    btnWidth = w;
    btnHeight = h;

    colours = cols;                                    // A Palette object
    textSize = 20;
    strokeWeight = 4;                                  // Thickness of the outline

    //textSize =  int(w*h/(50*t.length()));            // Default values, good for horizontally long rectangles
    strokeWeight = int(2*(w+h)/150);

    activationType = "on_release";
    pMousePressed = false;
  }

  void setActivation(String type) {                    // "on_press" or "on_release" or "hold"
    activationType = type;
  }

  boolean mouseOver() {                            // Returns true if mouse is over button
    return mouseX >= minX && mouseY >= minY && mouseX <= minX + btnWidth && mouseY <= minY + btnHeight;
  }

  boolean activated() {                            // Returns if the button has been activated, i.e. when the method should be triggered
    if (activationType == "on_press") {
      return !pMousePressed && mousePressed;           // True on first frame of mouse being pressed
    } else if (activationType == "on_release") {
      return pMousePressed && !mousePressed;           // True on first frame of mouse not being pressed
    } else if (activationType == "hold") {
      return mousePressed;
    } else {
      return false;
    }
  }

  void display(PGraphics c) {                      // The PGraphics object is passed as an argument - this is akin to a 'canvas' to draw to. g is the default PGraphics object
    if (mouseOver() && !disabled) {
      c.fill(colours.highlight);
    } else if (selected) {
      c.fill(colours.select);
    } else {
      c.fill(colours.primary);                         // Set button colour
    }

    c.strokeWeight(strokeWeight);
    c.stroke(colours.stroke);
    c.rectMode(CORNER);
    c.rect(minX, minY, btnWidth, btnHeight);           // Draw rectangle

    c.noFill();
    c.fill(colours.stroke);
    c.textAlign(CENTER, CENTER);
    c.textSize(textSize);
    c.text(label, minX, minY, btnWidth, btnHeight);    // Draw button text

    if (mouseOver() && activated() && !disabled) {     // If button is activated
      try {
        event.invoke(tempObj, eventArgs);              // Invoke method = call function
      } 
      catch (Exception e) {                            // Handle any errors (Java requirement)
        e.printStackTrace();
      }
    }

    pMousePressed = mousePressed;
  }
}
