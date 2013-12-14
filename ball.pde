class Ball {
  float x, y, d;
  boolean touch, attach, blink, sing;
  int counter;
  color c;
  int lineIndex;
  Train t;
  float slow;
  float theta=0;
  boolean enter;

  Ball(float _x, float _y) {
    x=_x;
    y=_y;
    d=20;
    touch=false;
    attach=false;
    counter=0;
    c=color(random(0, 255), random(0, 255), random(0, 230));
    slow=1.0;
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
            /*
          if (_s.transitBegin && _s.status!=0 && _s.toWhere !=i) {
             continue;
             }
             */
            float stationDis = dist(_s.x, _s.y, x, y);
            for (Train _t :lines.get(i).trains) {

              float waitTrainDis = dist(_t.pos.x, _t.pos.y, x, y);
              if (stationDis<_s.d && waitTrainDis<_s.d) {
                attach=true;
                lineIndex=i;
                t=_t;
                enter=true;
              }
            }
          }
        }
      }
    }
    else {
      //if (lines.get(lineIndex).trains.size()>0) {
      for (Station _s: lines.get(lineIndex).stations) {
        float stationDis = dist(_s.x, _s.y, x, y);
        for (Train _t: lines.get(lineIndex).trains) {
          float trainDis = dist(_t.pos.x, _t.pos.y, x, y);
          if (stationDis<_s.d && trainDis<_s.d) {
            attach=true;
            t=_t;
            println(lineIndex);
            println(t);
          }
        }
      }
      //}
    }
  }
  void follow() {
    if (attach && t!=null ) {
      // for (Train _t: lines.get(lineIndex).trains) {
      //if (t==_t) {
      x=t.pos.x;
      y=t.pos.y;
      // }
      // }
    }
  }

  void unfollow() {
    attach=false;
    // y+=slow;
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
        //t=null;
        if (_s.status==1) {
          lineIndex--;
        }
        else {
          lineIndex++;
        }
      }
      if (_s.transitEnd) {
        unfollow();
        //t=null;
        if (_s.left) {
          lineIndex-=2;
        }
        else {
          lineIndex+=2;
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

