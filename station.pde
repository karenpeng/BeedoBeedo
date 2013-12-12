class Station {
  float x, y, d, lastX, lastY;
  boolean on, hover, transitBegin, transitEnd, left;
  //status: 0:dow; 1:left; 2:right;
  boolean changeDir;
  //float status; 
  float angle;
  String pitch;
  boolean last;

  Station(float _x, float _y, String _p) {
    x=_x;
    y=_y;
    d=14;
    lastX=_x;
    lastY=_y+20;
    on=false;
    hover=false;
    transitBegin=false;
    transitEnd=false;
    angle=PI;
    left=false;
    pitch=_p;
    last=false;
    changeDir=false;
  }

  void onOff() {
    float dis = dist(mouseX, mouseY, x, y);
    if (dis<=d*.6) {  
      hover = true;
      // if (mousePressed) {
      on = !on;
      // }
    }
  }

  void hover() {
    float dis = dist(mouseX, mouseY, x, y);
    if (dis<=d) {  
      hover = true;
    }
    if (hover && dis>d) {
      hover = false;
      cursor(ARROW);
    }
    if (hover) {
      cursor(HAND);
    }
  }
  void direct() {
    if (transitBegin) {
      float transitDis = dist(x, y, mouseX, mouseY);
      if (transitDis<=20) {
        //lastX=x+20*(mouseX-x)/ transitDis;
        //lastY=y+20*(mouseY-y)/ transitDis;
        /*
        if (!left) {
         lastX=constrain(lastX, x-15*sqrt(3), x);
         lastY=constrain(lastY, y-15, y);
         }
         else {
         lastX=constrain(lastX, x, x+15*sqrt(3));
         lastY=constrain(lastY, y-15, y);
         }
         */
        changeDir=true;
      }
      /*
      if (lastX<x-8) {
        status=1;
      }
      else if (lastX>x+8) {
        status=2;
      }
      else {
        status=0;
      }
      */
    }
  } 

  void show() {
    if (!last) {
      if (on) {
        fill(255, 255, 0);
      }
      else {
        noFill();
      }
      stroke(255);
      strokeWeight(2);
      ellipse(x, y, d, d);

      if (transitBegin) {
        /*
        if (lastX-x>=0) {
          float dd = asin((lastY-y)/dist(lastX, lastY, x, y));
          angle=map(dd, -PI/2, PI/2, 0, PI);
        }
        else {
          float dd = asin((lastY-y)/dist(lastX, lastY, x, y));
          angle=map(dd, PI/2, -PI/2, PI, PI*2);
        }
        */
        pushMatrix();
        fill(0, 30, 185);
        translate(lastX, lastY);
        rotate(angle);
        stroke(0, 30, 185);
        strokeWeight(2);
        beginShape();    
        vertex(3, 3);
        vertex(0, -3);
        vertex(-3, 3);
        endShape(CLOSE);
        popMatrix();
        line(x, y, lastX, lastY);
      }
    }
    else {
      if (on) {
        fill(0, 30, 185);
      }
      else {
        noFill();
      }
      stroke(255);
      strokeWeight(2);
      ellipse(x, y, d*1.4, d*1.4);
      noFill();
      arc(x, y, d*.7, d*.7, 0, PI);
    }
  }
}

