class Ball {
  float x, y, d;
  boolean touch, attach, blink;
  int counter;
  color c;
  Train t;

  Ball(float _x, float _y) {
    x=_x;
    y=_y;
    d=20;
    touch=false;
    attach=false;
    counter=0;
    c=color(random(20, 255), random(20, 255), random(20, 230));
  }

  void picked() {  
    float dis = dist(mouseX, mouseY, x, y);
    if (dis<d) {
      touch=true;
    }
    else {
      touch=false;
    }
  }

  void dragged() {
    if (touch) {
      x=mouseX;
      y=mouseY;
    }
  }

  void pickTrain() {

    for (int i=0;i<10;i++) {
      if (i==0||i==3||i==6||i==9) {
        Train _t =lines.get(i).trains.get(lines.get(i).trains.size()-1);
        float waitTrainDis = dist(_t.pos.x, _t.pos.y, x, y);
        if (waitTrainDis<d/2) {
          attach=true;
          t=_t;
        }
      }
    }
  }

  void follow() {
    if (attach && t!=null) {
      x=t.pos.x;
      y=t.pos.y;
    }
  }

  void unfollow() {
    attach=false;
  }

  void transfer(Station _s) {
    if (_s.transitBegin && _s.status!=0) {
      unfollow();
    }
    if (_s.transitEnd) {
      unfollow();
    }
  }

  Station trigger(Line _l) {
    if (attach) {
      for (Station _s: _l.stations) {
        float dis=dist(_s.x, _s.y, x, y);
        if (dis<1 && _s.on) {
          blink=true;
          return _s;
        }
      }
    }
    return null;
  }

  void view() {
    fill(c); 
    noStroke();
    if (blink) {
      ellipse(x, y, d+8, d+8);
    }
    else {
      ellipse(x, y, d, d);
    }
  }
}

