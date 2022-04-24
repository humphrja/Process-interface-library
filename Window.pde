import java.util.Arrays;

class Window{
  Button[] btns = new Button[0];
  String[] test;
  
  Window(){
    // Pass in all the buttons
    // Pass in all the 
  }
  
  Button addButton(String methodName, Object[] methodArgs, String label, float x, float y, float w, float h, Palette cols, int fsize){
    Button btn = new Button(methodName, methodArgs, label, x, y, w, h, cols, fsize);
    
    btns = Arrays.copyOf(btns, btns.length + 1);
    btns[btns.length - 1] = btn;
    
    return btn;
  }
  
  Button[] getBtns(){
    return btns;
  }
  
  void display(){
    for (Button b : btns){
      b.display();
    }
  }
}
