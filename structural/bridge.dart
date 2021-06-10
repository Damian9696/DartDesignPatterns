void main() {

  testDevice(Tv());
  testDevice(Radio());
  
}

void testDevice(Device device){
  print("\nTest with basic remote");
  BasicRemote basicRemote = BasicRemote(device);
  basicRemote.power();
  basicRemote.channelUp();
  basicRemote.volumeUp();
  device.printStatus();
  
  print("\nTest with advaced remote");
  AdvancedRemote advancedRemote = AdvancedRemote(device);
  advancedRemote.power();
  advancedRemote.channelUp();
  advancedRemote.channelUp();
  advancedRemote.mute();
  device.printStatus();
}

abstract class Device{
  bool isEnabled();
  void enable();
  void disable();
  int getVolume();
  void setVolume(int volume);
  int getChannel();
  void setChannel(int channel);
  void printStatus();
}

class Radio implements Device{
  
  bool on = false;
  int volume = 0;
  int channel = 0;
  
  @override
  void disable() {
    on = false;
  }

  @override
  void enable() {
    on = true;
  }

  @override
  int getChannel() {
    return channel;
  }

  @override
  int getVolume() {
    return volume;
  }

  @override
  bool isEnabled() {
    return on;
  }

  @override
  void printStatus() {
    print("\n~~~~~~~~~~~~~~~~~~~~~~~");
    print("| I am a radio");
    print("| I am ${on ? "enabled" : "disabled"}");
    print("| Current volume is ${volume}");
    print("| Current channel is ${channel}");
    print("~~~~~~~~~~~~~~~~~~~~~~~\n");
  }

  @override
  void setChannel(int channel) {
    this.channel = channel;
  }

  @override
  void setVolume(int volume) {
    if(volume > 100){
      this.volume = 100;
    }else if(volume < 0){
      this.volume = 0;
    }else{
      this.volume = volume;
    }
  }
  
}

class Tv implements Device{
  
  bool on = false;
  int volume = 0;
  int channel = 0;
  
  @override
  void disable() {
    on = false;
  }

  @override
  void enable() {
    on = true;
  }

  @override
  int getChannel() {
    return channel;
  }

  @override
  int getVolume() {
    return volume;
  }

  @override
  bool isEnabled() {
    return on;
  }

  @override
  void printStatus() {
    print("\n~~~~~~~~~~~~~~~~~~~~~~~");
    print("| I am a Tv");
    print("| I am ${on ? "enabled" : "disabled"}");
    print("| Current volume is ${volume}");
    print("| Current channel is ${channel}");
    print("~~~~~~~~~~~~~~~~~~~~~~~\n");
  }

  @override
  void setChannel(int channel) {
    this.channel = channel;
  }

  @override
  void setVolume(int volume) {
    if(volume > 100){
      this.volume = 100;
    }else if(volume < 0){
      this.volume = 0;
    }else{
      this.volume = volume;
    }
  }
  
}

abstract class Remote{
  void power();
  void volumeDown();
  void volumeUp();
  void channelUp();
  void channelDown();
}

class BasicRemote implements Remote{
  
  final Device device;
  
  BasicRemote(this.device);
  
  @override
  void channelDown() {
    print("Remote: channel down");
    device.setChannel(device.getChannel() - 1);
  }

  @override
  void channelUp() {
    print("Remote: channel up");
    device.setChannel(device.getChannel() + 1);
  }

  @override
  void power() {
    print("Remote: power toggle");
    if(device.isEnabled()){
      device.disable();
    }else{
      device.enable();
    }
  }

  @override
  void volumeDown() {
    print("Remote: volume down");
    device.setVolume(device.getVolume() - 10);
  }

  @override
  void volumeUp() {
    print("Remote: volume up");
    device.setVolume(device.getVolume() + 10);
  }
  
}

class AdvancedRemote extends BasicRemote{
  
  AdvancedRemote(Device device) : super(device);
  
  void mute(){
    print("Remote: mute");
    device.setVolume(0);
  }
}
