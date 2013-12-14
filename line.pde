class Line {
  ArrayList<Station> stations;
  ArrayList<Train> trains;
  boolean change;
  boolean loop;
  int maxspeed=2;
  Line(ArrayList<Station> _s) {
    stations=_s;
    trains=new ArrayList<Train>();
    change=false;
    loop=false;
  }

  void drawLine() {
    Station n = stations.get(stations.size()-1);
    Station m = stations.get(0);
    stroke(10);
    strokeWeight(2);
    line(n.x, n.y, m.x, m.y);
  }

  void addTrain() {
    if (trains.size()==0 || trains.get(trains.size()-1).nextIndex==4) {
      Station start = stations.get(0);
      Train t = new Train(new PVector(start.x, start.y));
      t.setLine(stations);
      t.maxspeed = maxspeed;
      trains.add(t);
    }
  }

  void addTrainNoLimit() {
    Station start = stations.get(0);
    Train t = new Train(new PVector(start.x, start.y));
    t.setLine(stations);
    t.maxspeed = maxspeed;
    trains.add(t);    
  }

  void moveTrain() {
    Train train;
    for (int i = 0; i < trains.size(); i++) {
      train = trains.get(i);
      train.check();    
      train.seek();
      train.move();
      train.show();
      if (train.arrived) {
        trains.remove(i);
      }
    }
  }

  void showStation() {
    for (Station _s:stations) {
      _s.hover();
      _s.show();
    }
  }

  void clickStation() {
    for (Station _s:stations) {
      _s.onOff();
    }
  }

  void checkLoop() {
    if (stations.get(stations.size()-1).on) {
      loop=true;
    }
    else {
      loop=false;
    }
  }
}

