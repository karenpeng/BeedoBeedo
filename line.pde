class Line {
  ArrayList<Station> stations;
  ArrayList<Train> trains;

  Line(ArrayList<Station> _s) {
    stations=_s;
    trains=new ArrayList<Train>();
  }

  void drawLine() {
    Station n = stations.get(stations.size()-1);
    Station m = stations.get(0);
    stroke(255);
    strokeWeight(2);
    line(n.x, n.y, m.x, m.y);
  }

  void addTrain() {
    if (trains.size()==0 || trains.get(trains.size()-1).nextIndex==3) {
      Station start = stations.get(0);
      Train t = new Train(new PVector(start.x, start.y));
      t.setLine(stations);
      trains.add(t);
    }
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
}

