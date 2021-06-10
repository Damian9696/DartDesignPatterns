void main() {
   Director director = new Director();
   CarBuilder carBuilder = new CarBuilder();
   director.constructSportCar(carBuilder);
  
   Car car = carBuilder.getResult();
  print("Car built type: ${car.carType}");
  
  car.engine.drive(15);
  car.engine.on();
  car.engine.drive(15);
  car.engine.off();
  
  ManualBuilder manualBuilder= new ManualBuilder();
  director.constructSportCar(manualBuilder);
  
  Manual manual = manualBuilder.getResult();
  print(manual.print());
}

abstract class Builder{
  void setCarType(CarType carType);
  void setSeats(int seats);
  void setEngine(Engine engine);
  void setTransmission(Transmission transmission);
  void setTripComputer(TripComputer tripComputer);
  void setGpsNavigator(GpsNavigator gpsNavigator);
}

enum CarType{
  CITY,SPORT, SUV
}

enum Transmission{
  SINGLE_SPEED,MANUAL,AUTOMATIC,SEMI_AUTOMATIC
}

class Engine{
  double volume;
  double mileage;
  bool started = false; 
  
  Engine(this.volume, this.mileage);
  
  void on() {
    started = true;
  print("Engine is turn on");
  } 
  
  void off(){
    started = false;
    print("Engine is turn off");
  } 
  
  void drive(double newMileage){
    if(started){
      mileage+=newMileage;
      print("You traveled ${mileage} km");
    }else{
      print("Cannot drive. You must start engine first");
    }
  }

}

class GpsNavigator{
  String route = "Default route";
}

class Car{
  CarType carType;
  int seats;
  Engine engine;
  Transmission transmission;
  TripComputer tripComputer;
  GpsNavigator gpsNavigator;
  double fuel = 0;
  
  Car(this.carType, this.seats, this.engine, this.transmission,this.tripComputer,this.gpsNavigator){
    if(this.tripComputer != null){
      this.tripComputer.car = this;
    }
  }
  
}

class CarBuilder implements Builder{
  Car result;
  CarType carType;
  int seats;
  Engine engine;
  Transmission transmission;
  TripComputer tripComputer;
  GpsNavigator gpsNavigator;
  
  @override
  void setCarType(CarType carType) {
    this.carType = carType;
  }

  @override
  void setEngine(Engine engine) {
    this.engine = engine;
  }

  @override
  void setGpsNavigator(GpsNavigator gpsNavigator) {
    this.gpsNavigator = gpsNavigator;
  }

  @override
  void setSeats(int seats) {
    this.seats = seats;
  }

  @override
  void setTransmission(Transmission transmission) {
    this.transmission = transmission;
  }

  @override
  void setTripComputer(TripComputer tripComputer) {
    this.tripComputer = tripComputer;
  }
  
  Car getResult(){
    result =  new Car(carType,seats,engine,transmission,tripComputer,gpsNavigator);
    return result;
  }
}

class Manual{
  CarType carType;
  int seats;
  Engine engine;
  Transmission transmission;
  TripComputer tripComputer;
  GpsNavigator gpsNavigator;
  
  Manual(this.carType, this.seats, this.engine, this.transmission,this.tripComputer,this.gpsNavigator);
  
  String print(){
    String info = "\n";
        info += "Type of car: ${carType}\n";
        info += "Count of seats:${seats}\n";
        info += "Engine: volume - ${engine.volume}\n";                          info+= "Mileage - ${engine.mileage} \n";
        info += "Transmission: ${transmission}\n";
        if (this.tripComputer != null) {
            info += "Trip Computer: Functional" + "\n";
        } else {
            info += "Trip Computer: N/A" + "\n";
        }
        if (this.gpsNavigator != null) {
            info += "GPS Navigator: Functional" + "\n";
        } else {
            info += "GPS Navigator: N/A" + "\n";
        }
        return info;
  }
}

class ManualBuilder implements Builder{
  
  CarType carType;
  int seats;
  Engine engine;
  Transmission transmission;
  TripComputer tripComputer;
  GpsNavigator gpsNavigator;
  
  @override
  void setCarType(CarType carType) {
    this.carType = carType;
  }

  @override
  void setEngine(Engine engine) {
    this.engine = engine;
  }

  @override
  void setGpsNavigator(GpsNavigator gpsNavigator) {
    this.gpsNavigator = gpsNavigator;
  }

  @override
  void setSeats(int seats) {
    this.seats = seats;
  }

  @override
  void setTransmission(Transmission transmission) {
    this.transmission = transmission;
  }

  @override
  void setTripComputer(TripComputer tripComputer) {
    this.tripComputer = tripComputer;
  }
  
  Manual getResult(){
    return new Manual(carType,seats,engine,transmission,tripComputer,gpsNavigator);
  }
  
}

class TripComputer{
  Car car;
  
  void showFuelLevel(){
    print("Fuel level: ${car.fuel}");
  }
  
  void showStatus(){
    if(car.engine.started){
      print("Car is started");
    }else{
      print("Car is not started");
    }
  }
}

class Director{
  void constructSportCar(Builder builder) {
        builder.setCarType(CarType.SPORT);
        builder.setSeats(2);
        builder.setEngine(new Engine(3.0, 0));
        builder.setTransmission(Transmission.SEMI_AUTOMATIC);
        builder.setTripComputer(new TripComputer());
        builder.setGpsNavigator(new GpsNavigator());
    }
  
  void constructCityCar(Builder builder) {
        builder.setCarType(CarType.CITY);
        builder.setSeats(2);
        builder.setEngine(new Engine(1.2, 0));
        builder.setTransmission(Transmission.AUTOMATIC);
        builder.setTripComputer(new TripComputer());
        builder.setGpsNavigator(new GpsNavigator());
    }
  
  void constructSUV(Builder builder) {
        builder.setCarType(CarType.SUV);
        builder.setSeats(4);
        builder.setEngine(new Engine(2.5, 0));
        builder.setTransmission(Transmission.MANUAL);
        builder.setGpsNavigator(new GpsNavigator());
    }
}
