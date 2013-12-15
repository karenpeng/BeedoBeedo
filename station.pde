class Station {
  float x, y, d, lastX, lastY;
  boolean on, hover, transitHover, transitBegin, transitEnd, left;
  //status: 0:dow; 1:left; 2:right;
  boolean changeDir;
  float status; 
  float angle;
  String pitch;
  boolean last;
  int passLine;
  int blockLine;
  int toWhere;

  Station(float _x, float _y, String _p) {
    x=_x;
    y=_y;
    d=14;
    lastX=_x;
    lastY=_y+20;
    on=false;
    hover=false;
    transitBegin=false;
    status=0;
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
      on = !on;
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

    /*
    if (transitBegin) {
     float transitDis = dist(mouseX, mouseY, x, y-20);
     if (transitDis<6) {
     transitHover=true;
     }
     if (hover && transitDis>=6) {
     transitHover = false;
     cursor(ARROW);
     }
     if (transitHover) {
     cursor(HAND);
     }
     }
     */
  }
  void direct() {
    if (transitBegin) {
      float transitDis;
      if (status==0) {
        transitDis = dist(x, y+20, mouseX, mouseY);
      }
      else if (status==1) {
        transitDis = dist(x-10*sqrt(3), y+10, mouseX, mouseY);
      }
      else {
        transitDis = dist(x+10*sqrt(3), y+10, mouseX, mouseY);
      }
      
      if (transitDis<6) {
        changeDir=!changeDir;
      }

      if (!changeDir) {
        status=0;
      }
      if (changeDir && left) {
        status = 1;
      }
      if (changeDir && !left) {
        status=2;
      }
    }
  } 

  void show() {
    if (!last) {
      if (on) {
        fill(200);
      }
      else {
        noFill();
      }
      stroke(10);
      strokeWeight(2);
      ellipse(x, y, d, d);
      if (transitBegin) {
        if (status==1) {
          angle=PI*2/3;
          lastX=x-10*sqrt(3);
          lastY=y+10;
        }
        if (status==2) {
          angle=PI*2/3;
          lastX=x+10*sqrt(3);
          lastY=y+10;
        }
        if (status==0) {
          angle=PI;
          lastX=x;
          lastY=y+20;
        }
        pushMatrix();
        fill(250, 255, 255);
        translate(lastX, lastY);
        rotate(angle);
        stroke(250, 255, 255);
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
        fill(200);
      }
      else {
        noFill();
      }
      stroke(10);
      strokeWeight(2);
      ellipse(x, y, d*1.4, d*1.4);
      noFill();
      arc(x, y, d*.7, d*.7, 0, PI);
      line(x+d*.7/2,y-2,x+d*.5/2,y+1);
      line(x+d*.7/2,y-2,x+d*.9/2,y+1);
    }
  }
}

