class Palette {
  color background, stroke, primary, highlight, select;

  Palette(color... colors) {  
    background = colors[0];
    stroke = colors[1];
    primary = colors[2];
    highlight = colors[3];
    select = colors[4];
  }
}
