class Train {
  PVector pos, vel, acc;  
  float maxforce, maxspeed;
  float d;  
  ArrayList<PVector> history;
  ArrayList<Station> stations; 
  //Ball b; 
  int nextIndex;
  //int lineInext; 
  boolean arrived, headArrived;
  //boolean trigger;

  Train(PVector _p) {
    pos=_p;
    vel=new PVector (0.0, 0.0);
    acc=new PVector (0.0, 0.0);
    maxspeed = 2;
    maxforce = 2;
    d=4;
    history = new ArrayList<PVector>();
    stations = new ArrayList<Station>(); 
    nextIndex = 0;
    //lineInext = _i;
    //stations = lines.get(i).stations; 
    //balls = new ArrayList<Ball>();    
    arrived = false;
    headArrived = false;
    //trigger = false;
  }

  void setLine(ArrayList _s) {
    stations = _s;
    nextIndex = 0;
  }
  void appF(PVector f) {
    acc.add(f);
  }

  void move() {
    pos.add(vel);
    vel.add(acc);
    acc.mult(0);
    history.add(pos.get());
    //make sure maxspeed change wont change the length of train too match
    if (history.size() * maxspeed > 20) {
      history.remove(0);
    }
  }

  void seek() {
    if (nextIndex == 0) {
      return;
    }
    Station next = stations.get(nextIndex);
    PVector tar = new PVector(next.x, next.y);
    PVector desired = PVector.sub(tar, pos);
    float d = desired.mag();
    if (d < 40) {
      float m = map(d, 0, 40, .6, maxspeed);
      desired.setMag(m);
    } 
    else {
      desired.setMag(maxspeed);
    }
    PVector steer = PVector.sub(desired, vel);
    steer.limit(maxforce); 
    appF(steer);
  }

  void check() {
    Station next = stations.get(nextIndex);
    float nextDis=dist(next.x, next.y, pos.x, pos.y);

    if (nextIndex < stations.size() - 1 && nextDis<1) {
      nextIndex++;
    }

    if (nextIndex == stations.size() - 1) {

      if (!headArrived && nextDis<1) {
        headArrived = true;
      }
      PVector lastHis = (PVector)history.get(0);
      float lastDis = dist(next.x, next.y, lastHis.x, lastHis.y);
      if (lastDis < 1) {
        arrived = true;
      }
    }
  }

  boolean atStation(Station s) {
    float distance = dist(s.x, s.y, pos.x, pos.y);
    return distance < 2;
  }

  void show() {
    noStroke();
    //fill(255);
    //for debug
    fill(0);
    ellipse(pos.x, pos.y, d, d);
    for (PVector v: history) {
      ellipse(v.x, v.y, d, d);
    }
  }
}

