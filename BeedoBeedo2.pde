String [] melody= {
  "C2", "C#2", "D2", "D#2", "E2", "F2", "F#2", "G2", "G#2", "A2", "A#2", "B2", 
  "C3", "C#3", "D3", "D#3", "E3", "F3", "F#3", "G3", "G#3", "A3", "A#3", "B3", 
  "C4", "C#4", "D4", "D#4", "E4", "F4", "F#4", "G4", "G#4", "A4", "A#4", "B4", 
  "C5", "C#5", "D5", "D#5", "E5", "F5", "F#5", "G5", "G#5", "A5", "A#5", "B5", 
  "C6", "C#6", "D6", "D#6", "E6", "F6", "F#6", "G6", "G#6", "A6", "A#6", "B6"
};
String [] melody2= {
  "C2", "C#2", "D2", "D#2", "E2", "F2", "F#2", "G2", "G#2", "A2", "A#2", "B2", 
  "C3", "C#3", "D3", "D#3", "E3", "F3", "F#3", "G3", "G#3", "A3", "A#3", "B3", 
  "C4", "C#4", "D4", "D#4", "E4", "F4", "F#4", "G4", "G#4", "A4", "A#4", "B4", 
  "C5", "C#5", "D5", "D#5", "E5", "F5", "F#5", "G5", "G#5", "A5", "A#5", "B5", 
  "C6", "C#6", "D6", "D#6", "E6", "F6", "F#6", "G6", "G#6", "A6", "A#6", "B6"
};
Station [] s= new Station [10];
ArrayList<Station> s1;
ArrayList<Station> s2;
ArrayList<Station> s3;
ArrayList<Station> s4;
ArrayList<Station> s5;
ArrayList<Station> s6;
ArrayList<Station> s7;
ArrayList<Station> s8;
ArrayList<Station> s9;
ArrayList<Station> s10;
ArrayList<Line> lines;
ArrayList<Ball> balls;
int count=0;
float gap = 44;
float wBegin=70;
float hBegin=280;

void setup() {
  size(800, 800);
  //frameRate(40);
  colorMode(HSB);
  s1=new ArrayList<Station>();
  s2=new ArrayList<Station>();
  s3=new ArrayList<Station>();
  s4=new ArrayList<Station>();
  s5=new ArrayList<Station>();
  s6=new ArrayList<Station>();
  s7=new ArrayList<Station>();
  s8=new ArrayList<Station>();
  s9=new ArrayList<Station>();
  s10=new ArrayList<Station>();
  lines = new ArrayList<Line>();
  balls = new ArrayList<Ball>();

  for (float j=wBegin; j<wBegin+gap*13; j+=gap) {
    s1.add(new Station(hBegin, j, "C3"));
  }
  s1.get(12).last=true;

  for (float j=wBegin+gap; j<wBegin+gap*13+gap; j+=gap) {
    s4.add(new Station(hBegin+gap*sqrt(3), j, "C3"));
  }
  s4.get(12).last=true;

  for (float j=wBegin+gap*2; j<wBegin+gap*13+gap*2; j+=gap) {
    s7.add(new Station(hBegin+gap*sqrt(3)*2, j, "C3"));
  }
  s7.get(12).last=true;

  for (float j=wBegin+gap*3; j<wBegin+gap*13+gap*3; j+=gap) {
    s10.add(new Station(hBegin+gap*sqrt(3)*3, j, "C3"));
  }
  s10.get(12).last=true;

  s2.add(s1.get(3));
  s2.add(new Station(hBegin+gap*sqrt(3)/2, wBegin+gap*3.5, "C3"));
  s2.add(s4.get(3));
  s2.get(0).passLine=0;
  s2.get(0).blockLine=1;
  s2.get(2).toWhere=3;

  s3.add(s4.get(6));
  s3.add(new Station(hBegin+gap*sqrt(3)/2, wBegin+gap*7.5, "C3"));  
  s3.add(s1.get(8));
  s3.get(0).passLine=3;
  s3.get(0).blockLine=2;
  s3.get(2).toWhere=0;

  s5.add(s4.get(5));
  s5.add(new Station(hBegin+gap*sqrt(3)*3/2, wBegin+gap*6.5, "C3"));
  s5.add(s7.get(5));
  s5.get(0).passLine=3;
  s5.get(0).blockLine=4;
  s5.get(2).toWhere=6;

  s6.add(s7.get(6));
  s6.add(new Station(hBegin+gap*sqrt(3)*3/2, wBegin+gap*8.5, "C3"));
  s6.add(s4.get(8));
  s6.get(0).passLine=6;
  s6.get(0).blockLine=5;
  s6.get(2).toWhere=3;

  s8.add(s7.get(3));
  s8.add(new Station(hBegin+gap*sqrt(3)*5/2, wBegin+gap*5.5, "C3"));
  s8.add(s10.get(3));
  s8.get(0).passLine=6;
  s8.get(0).blockLine=7;
  s8.get(2).toWhere=9;

  s9.add(s10.get(6));
  s9.add(new Station(hBegin+gap*sqrt(3)*5/2, wBegin+gap*9.5, "C3"));
  s9.add(s7.get(8));
  s9.get(0).passLine=9;
  s9.get(0).blockLine=8;
  s9.get(2).toWhere=6;

  lines.add(new Line(s1));
  lines.add(new Line(s2));
  lines.add(new Line(s3));
  lines.add(new Line(s4));
  lines.add(new Line(s5));
  lines.add(new Line(s6));
  lines.add(new Line(s7));
  lines.add(new Line(s8));
  lines.add(new Line(s9));
  lines.add(new Line(s10));

  for (int i=0;i<10;i++) {
    if (i==1||i==2||i==4||i==5||i==7||i==8) {
      lines.get(i).stations.get(0).transitBegin=true;
      lines.get(i).stations.get(2).transitEnd=true;
      lines.get(i).change=true;
      lines.get(i).maxspeed=1;
    }
    if (i==2||i==5||i==8) {
      lines.get(i).stations.get(0).left=true;
      lines.get(i).maxspeed=2;
    }

    if (i==0||i==3||i==6||i==9) {
      lines.get(i).stations.get(12).on=true;
    }
  }

  for (int i=0;i<7;i++) {
    for (int j=0;j<2;j++) {
      balls.add(new Ball(hBegin+i*gap*.9, 22+j*gap*.6));
    }
  }
  

  
}

void draw() {
  background(255);
  /*
    for(Line l:lines){
    if(l.change){
      //println(l.trains.size());
      for(Train t: l.trains){
        //println("out");
        t.maxspeed=1.6;
        //t.maxforce=1;
      }
    }
  }
  */
  for (Line _l:lines) {
    //_l.drawLine();
    if (!_l.change) {
      _l.addTrain();
    }
    _l.moveTrain();
    _l.checkLoop();
    _l.showStation();

    /*
    if (lines.get(0).trains.get(lines.get(0).trains.size()-1).nextIndex==2 && _l.change) {
     _l.addTrain();
     }
     */
     
     
    if (_l.change) {
      for (Train t: lines.get(_l.stations.get(0).passLine).trains) {
        if (t.atStation(_l.stations.get(0))) {
          _l.addTrainNoLimit();
        }
      }
    }
    
  }

  for (Ball _b:balls) {
    _b.jigger();
    _b.view();
    _b.pickTrain();
    _b.follow();
    _b.transfer(_b.trigger());
    _b.button();
    _b.loopLine();
    for (Ball __b:balls) {
      if (_b!=__b) {
        if (!_b.enter && !__b.enter) {
          float ballDis=dist(_b.x, _b.y, __b.x, __b.y);
          if (ballDis<=_b.d/2+__b.d/2+1) {
            if (_b.x>=__b.x) {
              _b.x++;
              __b.x--;
            }
            else {
              __b.x++;
              _b.x--;
            }
          }
        }
        /*
        if (_b.enter && __b.enter) {
         float ballDis=dist(_b.x, _b.y, __b.x, __b.y);
         if (ballDis<=100) {
         stroke((_b.c+__b.c)/2);
         line(_b.x, _b.y, __b.x, __b.y);
         }
         }
         */
      }
    }
  }
}

void mousePressed() {
  for (int i=0;i<10;i++) {
    if (i==0||i==3||i==6||i==9) {
      lines.get(i).clickStation();
    }
    if (i==1||i==2||i==4||i==5||i==7||i==8) {
      lines.get(i).stations.get(1).onOff();
      lines.get(i).stations.get(0).direct();
    }
  }
  for (Ball _b:balls) {
    _b.picked();
  }
}

void mouseDragged() {
  for (int i=0;i<10;i++) {

    if (i==1||i==2||i==4||i==5||i==7||i==8) {
      lines.get(i).stations.get(0).direct();
    }
  }
  for (Ball _b:balls) {
    _b.dragged();
  }
}

