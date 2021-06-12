void main() {
  var s1 = Singleton();
  var s2 = Singleton();
}

class Singleton {
  static final Singleton _singleton = Singleton._internal();

  factory Singleton() {
    return _singleton;
  }

  Singleton._internal(){
    print('Singleton initialized');
  }
}