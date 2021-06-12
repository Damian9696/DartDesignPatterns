import 'dart:collection';

void main() {
  var firetruck = Firetruck(12, 6, true, false, 'red');
  var firetruck1 = firetruck.clone();
  var firetruck2 = Firetruck(12, 6, true, false, 'red');

  print('Is firetruck1 copy of firetruck: ${firetruck == firetruck1}');
  print('Is firetruck2 copy of firetruck: ${firetruck == firetruck2}');

  var cache = BundledCarCache();
  var normalFireTruck = cache.getCar('normal');
  var premiumFireTruck = cache.getCar('premium');
  var premiumFireTruck1 = cache.getCar('premium');

  print(
      'Is normalFireTruck equal premiumFireTruck: ${normalFireTruck == premiumFireTruck}');
  print(
      'Is premiumFireTruck equal premiumFireTruck1: ${premiumFireTruck == premiumFireTruck1}');
}

abstract class Car {
  int wheels = 4;
  int doors = 4;

  Car clone();
}

class Firetruck implements Car {
  bool firehose = false;
  bool ladder = false;
  String color = 'red';
  int _hasCode = -1;

  Firetruck(this.doors, this.wheels, this.ladder, this.firehose, this.color);

  @override
  int doors = 10;

  @override
  int wheels = 6;

  @override
  Car clone() {
    return Firetruck.fromSource(this);
  }

  Firetruck.fromSource(Firetruck source) {
    doors = source.doors;
    wheels = source.wheels;
    ladder = source.ladder;
    firehose = source.firehose;
    _hasCode = source.hashCode;
  }

  @override
  int get hashCode {
    if (_hasCode != -1) return _hasCode;
    _hasCode = DateTime.now().millisecondsSinceEpoch;
    return _hasCode;
  }

  @override
  bool operator ==(Object other) {
    if (other is! Firetruck) return false;
    Firetruck comparedFiretruck = other;
    return comparedFiretruck.wheels == wheels &&
        comparedFiretruck.doors == doors &&
        comparedFiretruck.firehose == firehose &&
        comparedFiretruck.ladder == ladder &&
        comparedFiretruck.color == color &&
        comparedFiretruck._hasCode == _hasCode;
  }
}

class BundledCarCache {
  var cache = HashMap<String, Car>();

  BundledCarCache() {
    var normalFiretruck = Firetruck(12, 6, true, false, 'red');
    var premiumFiretruck = Firetruck(18, 10, true, true, 'blue');

    cache.putIfAbsent('normal', () => normalFiretruck);
    cache.putIfAbsent('premium', () => premiumFiretruck);
  }

  void addCar(String key, Car car) {
    cache.putIfAbsent(key, () => car);
  }

  Car getCar(String key) {
    return cache.entries
        .firstWhere((element) => element.key == key)
        .value
        .clone();
  }
}
