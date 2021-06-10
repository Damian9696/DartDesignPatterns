import 'dart:math';

void main() {

  RoundHole hole = RoundHole(5);
  RoundPeg roundPeg = RoundPeg(6);
  
  print("round peg with radius ${roundPeg.radius} fits into hole with radius ${hole.radius} -> ${hole.fits(roundPeg)}");
  
  SquarePeg squarePeg = SquarePeg(5);
  SquarePegAdapter adapter = SquarePegAdapter(squarePeg);
  var fits = hole.fits(adapter);
  
    print("\nSuarePegAdapter with width ${adapter.peg.width}  converted into radius ${adapter.radius} fits into hole with radius ${hole.radius} -> ${hole.fits(adapter)}");
}

class RoundHole{
  double radius = 0;
  
  RoundHole(this.radius);
  
  bool fits(RoundPeg peg){
    bool result;
    result = (this.radius >= peg.radius);
    return result;
  }
  
}

class RoundPeg{
  double radius =0;
  
  RoundPeg(this.radius);
  
}

class SquarePeg{
  double width = 0;
  SquarePeg(this.width);
  
  double getSquare(){
    double result;
    result = pow(this.width, 2).toDouble();
    return result;
  }
}

class SquarePegAdapter implements RoundPeg {
  
  SquarePeg peg;
  
  SquarePegAdapter(this.peg);
  
  @override
  double get radius {
    return sqrt(pow(peg.width/2,2))*2;
  }

  @override
  void set radius(double _radius){
    radius = _radius;
  }
  
}
