class Ball {
  float x, y, d;
  boolean touch, attach, blink;
  int counter;
  color c;

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

  Line pickLine() {
    if (touch && !attach) {
      for (int i=0;i<10;i++) {
        if (i==0||i==3||i==6||i==9) {
          float dis = dist(lines.get(i).stations.get(0).x, lines.get(i).stations.get(0).y, x, y);
          if (dis<d) {
            attach=true;
            return lines.get(i);
          }
        }
      }
    }
    return null;
  }

  void follow(Line _l) {
    if (attach && _l.trains.size()!=0) {
      Train t= _l.trains.get(_l.trains.size()-1);
      x=t.pos.x;
      y=t.pos.y;
    }
  }

  void transfer() {
  }

  void unfollow() {
  }

  void trigger(Line _l) {
    if (attach) {
      for (Station _s: _l.stations) {
        float dis=dist(_s.x, _s.y, x, y);
        if (dis<1 && _s.on) {
          blink=true;
        }
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

