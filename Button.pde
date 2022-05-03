import java.lang.Class;
import java.lang.reflect.*;

class Button {

  Method onPress;                  // The button's on-press method
  Object[] onPressMethodArgs;      // The arguments passed into the on-press method
  Events tempObj;                  // A temporary instance of the Events class used for invoking the method

  String label;
  float minX, minY, btnWidth, btnHeight;
  Palette colours;
  int textSize, strokeWeight;

  boolean disabled, selected, pMousePressed;


  // When passing in args, use the following format:
  // new Object[] {arg1, arg2, arg3}

  Button(String mName, Object[] args, Object classInstance,  String t, float x, float y, float w, float h, Palette cols) {
   
    Class c = classInstance.getClass();  
    Method[] methods = c.getDeclaredMethods();    // Returns all methods within the c class into an array

    for (Method m : methods) {                               // Searches through the array by method name and assigns onPress to the corresponding method
      if (m.getName() == mName) {
        onPress = m;
      }
    }

    tempObj = new Events();
    onPressMethodArgs = args;

    label = t;
    minX = x;
    minY = y;
    btnWidth = w;
    btnHeight = h;

    colours = cols;
    textSize = 20;
    strokeWeight = 4;

    textSize =  int(w*h/500);            // Default values
    strokeWeight = int(2*(w+h)/150);

    pMousePressed = false;
  }

  boolean mouseOver() {
    return mouseX >= minX && mouseY >= minY && mouseX <= minX + btnWidth && mouseY <= minY + btnHeight;
  }

  void display(PGraphics c) {
    if (mouseOver() && !disabled) {
      c.fill(colours.highlight);
    } else if (selected) {
      c.fill(colours.select);
    } else {
      c.fill(colours.primary);
    }

    c.strokeWeight(strokeWeight);
    c.stroke(colours.stroke);
    c.rectMode(CORNER);
    c.rect(minX, minY, btnWidth, btnHeight);

    c.noFill();
    c.fill(colours.stroke);
    c.textAlign(CENTER, CENTER);
    c.textSize(textSize);
    c.text(label, minX, minY, btnWidth, btnHeight);

    if (mouseOver() && (pMousePressed && !mousePressed) && !disabled) {       // mouseReleased = pMousePressed && !mousePressed
      try {
        onPress.invoke(tempObj, onPressMethodArgs);
      } 
      catch (Exception e) {
        e.printStackTrace();
      }
    }

    pMousePressed = mousePressed;
  }
}
