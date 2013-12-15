class Ball {
  float x, y, d;
  float orX, orY;
  boolean touch, attach, blink, sing;
  int counter;
  color c;
  int lineIndex;
  Line l;
  Train t;
  float theta;
  float slow;
  boolean enter;
  int firstLine;
  int blinkCounter, singCounter;
  boolean mouseOver;
  float effectDiameter;

  Ball(float _x, float _y) {
    x=_x;
    y=_y;
    orX=_x;
    orY=_y;
    d=20;
    touch=false;
    attach=false;
    counter=0;
    c=color(random(0, 250), random(200, 250), random(200, 250));
    theta=0;
    slow=2;
    enter=false;
    blinkCounter=0;
    singCounter=0;
    mouseOver=false;
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

  void mouseOver() {
    float dis = dist(mouseX, mouseY, x, y);
    if (dis<=d/2 && !enter) {
      mouseOver=true;
    }
    if (mouseOver && dis>d/2) {
      mouseOver = false;
      cursor(ARROW);
    }
    if (mouseOver) {
      cursor(HAND);
    }
  }

  void dragged() {
    if (touch) {
      x=mouseX;
      y=mouseY;
    }
  }

  void pickTrain() {
    if (!mousePressed) {
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
                  firstLine=i;
                  l=lines.get(i);
                  t=_t;
                  enter=true;
                }
              }
            }
          }
        }
      }
      if (enter) {
        //for (Station _s: lines.get(lineIndex).stations) {
        // float stationDis = dist(_s.x, _s.y, x, y);
        for (Train _t: lines.get(lineIndex).trains) {
          float trainDis = dist(_t.pos.x, _t.pos.y, x, y);
          if (/*stationDis<_s.d/2 && */trainDis<6) {
            attach=true;
            t=_t;
            l=lines.get(lineIndex);
            //println(lineIndex);
            //println(t);
          }
        }
      }
      // }
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

  Station trigger() {
    if (attach) {
      for (Station _s: t.stations) {
        float dis=dist(_s.x, _s.y, x, y);
        if (dis<1) {
          if (_s.on && !_s.last) {
            blink=true;
            sing=true;
          }
          if (sing) {
            out.playNote(_s.pitch);
          }
          return _s;
        }
      }
    }
    return null;
  }

  void button() {
    if (sing) {
      //out.playNote(song.tone);
      //println("dfhs");
      singCounter++;
    }
    if (singCounter>0) {
      sing=false;
      singCounter=0;
    }
    if (blink) {
      blinkCounter++;
    }
    if (blinkCounter>10) {
      blink=false;
      blinkCounter=0;
    }
  }

  void transfer(Station _s) {
    if (_s!=null) {
      if (_s.transitBegin && _s.status!=0) {
        unfollow();
        //l=null;
        //t=null;
        lineIndex=_s.blockLine;
        //print("?");
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
    if (t!=null && t.nextIndex==8 && t.arrived) {
      if (!l.loop) {

        unfollow();       
        //l=null;
        //t=null;
        y+=slow;
        slow-=.03;
        if (slow<0) {
          slow=0;
        }
        enter=false;
        println("out");
      }    

      else if (enter) {
        x=lines.get(firstLine).stations.get(0).x;
        y=lines.get(firstLine).stations.get(0).y;
        lineIndex=firstLine;
        println("loop");
        slow=2;
      }
    }
  }

  void view() {   
    noStroke();
    if (blink) {
      fill(c, 100); 
      ellipse(x, y, d+20, d+20);
      fill(c, 150); 
      ellipse(x, y, d+6, d+6);
    }
    fill(c); 
    ellipse(x, y, d, d);
  }
}

