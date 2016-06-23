//_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
// -- >HueLampPicker
//_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
class HueLampPicker
{
  // -> VARS
  PVector pos;
  PVector size;
  boolean beingDragged = false;
  String hueID;
  color col;

  // -> CONSTRUCTOR
  HueLampPicker(String _hid, PVector _pos, PVector _size)
  {
    pos = _pos.copy();
    size = _size.copy();
    hueID = _hid;
    
    // set to white to begin with
    col = color(360,255,255);
  }

  // -> METHODS
  void run()
  {
    update();
    display();
  }

  // display the id, circle and current color of lamp
  void display()
  {
    noFill();
    stroke(255);
    strokeWeight(2);
    ellipse(pos.x, pos.y, size.x, size.y);
    noStroke();
    fill(col);
    ellipse(pos.x,pos.y+size.y,30,30);
    fill(255);
    text(hueID,pos.x,pos.y-15);
  }

  void update()
  {
    // check if mouse is in the circle
    if (mousePressed == true && beingDragged == false) {
      float d = dist(mouseX, mouseY, pos.x, pos.y);
      if (d < size.x) {
        beingDragged = true;
        println("being dragged");
      }
    }

    // move circle
    if (beingDragged) {
      pos.x = mouseX;
      pos.y = mouseY;

      // get color
      //0 - 65535
      if (frameCount%15==1) {
        final color c = pixels[int(pos.y)*width + int(pos.x)];
        int sat = int( saturation(c));
        int bri = int( brightness(c));
        int pre_hue = int(hue(c));
        // 65280
        int post_hue = int(map(pre_hue, 0, 360, 0, 65000));
        
        println(pre_hue,post_hue);
        
        // set color of display
        col = color(hue(c),sat,bri);

        // set color of Hue
        setHue(hueID, post_hue, sat, bri);
      }
    }
  }

  void mouseReleased() {
    beingDragged = false;
  }
}