class Ball {
  float x, y, d;
  boolean touch, attach, blink;
  int counter;
  color c;
  Train t;
  //Line l;
  float slow;

  Ball(float _x, float _y) {
    x=_x;
    y=_y;
    d=20;
    touch=false;
    attach=false;
    counter=0;
    c=color(random(0, 255), random(0, 255), random(0, 230));
    slow=1.0;
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
      if (/*i==0||i==3||i==6||i==9*/lines.get(i).trains.size()!=0) {
        Station _s=lines.get(i).stations.get(0);
        Train _t =lines.get(i).trains.get(lines.get(i).trains.size()-1);
        float stationDis = dist(_s.x, _s.y, x, y);
        float waitTrainDis = dist(_t.pos.x, _t.pos.y, x, y);
        if (stationDis<d/2 && waitTrainDis<d/2) {
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
    y+=slow;
    slow-=.1;
    if (slow<0) {
      slow=0;
    }
  }

  Station trigger() {
    if (attach) {
      for (Station _s: t.stations) {
        float dis=dist(_s.x, _s.y, x, y);
        if (dis<1) {
          if (_s.on) {
            blink=true;
          }
          return _s;
        }
      }
    }
    return null;
  }

  void transfer(Station _s) {
    if (_s!=null) {
      if (_s.transitBegin && _s.status!=0) {
        unfollow();
      }
      if (_s.transitEnd) {
        //unfollow();
      }
    }
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

