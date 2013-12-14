class Ball {
  float x, y, d;
  boolean touch, attach, blink, sing;
  int counter;
  color c;
  int lineIndex;
  Line l;
  Train t;
  float theta;
  float slow;
  boolean enter;

  Ball(float _x, float _y) {
    x=_x;
    y=_y;
    d=20;
    touch=false;
    attach=false;
    counter=0;
    c=color(random(0, 250), random(200, 250), random(200, 250));
    theta=0;
    slow=2;
    enter=false;
  }

  void jigger() {
    d=sin(theta)*4+22;
    theta+=.1;
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
    if (!enter) {
      for (int i=0;i<10;i++) {
        /*
      if (lines.get(i).trains.size()!=0) {
         Station _s=lines.get(i).stations.get(0);
         Train _t =lines.get(i).trains.get(lines.get(i).trains.size()-1);
         float stationDis = dist(_s.x, _s.y, x, y);
         float waitTrainDis = dist(_t.pos.x, _t.pos.y, x, y);
         if (stationDis<d/2 && waitTrainDis<d/2) {
         attach=true;
         lineIndex=i;
         t=_t;
         }
         }
         }
         */

        if (lines.get(i).trains.size()!=0) {
          for (Station _s:lines.get(i).stations) {
            for (Train _t :lines.get(i).trains) {
              float stationDis = dist(_s.x, _s.y, x, y);
              float waitTrainDis = dist(_t.pos.x, _t.pos.y, x, y);
              if (stationDis<_s.d && waitTrainDis<_s.d) {
                attach=true;
                lineIndex=i;
                l=lines.get(i);
                t=_t;
                enter=true;
              }
            }
          }
        }
      }
    }
    else {
      //for (Station _s: lines.get(lineIndex).stations) {
      // float stationDis = dist(_s.x, _s.y, x, y);
      for (Train _t: lines.get(lineIndex).trains) {
        float trainDis = dist(_t.pos.x, _t.pos.y, x, y);
        if (/*stationDis<_s.d/2 && */trainDis<14) {
          attach=true;
          t=_t;
          l=lines.get(lineIndex);
          println(lineIndex);
          //println(t);
        }
      }
    }
    // }
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

  Station trigger() {
    if (attach) {
      for (Station _s: t.stations) {
        float dis=dist(_s.x, _s.y, x, y);
        if (dis<1) {
          if (_s.on) {
            blink=true;
            sing=true;
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
        //l=null;
        //t=null;
        lineIndex=_s.blockLine;
        print("?");
        //t=null;
      }
      if (_s.transitEnd) {
        unfollow();
        //l=null;
        //t=null;
        lineIndex=_s.toWhere;
        //t=null;
      }
    }
  }

  void loopLine() {
    if (t!=null && t.nextIndex==12 && t.arrived) {
      if (!l.loop) {
        unfollow();
        enter=false;
        y+=slow;
        slow-=.05;
        if (slow<0) {
          slow=0;
        }
      }    
      else if(enter){
        x=l.stations.get(0).x;
        y=l.stations.get(0).y;
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

