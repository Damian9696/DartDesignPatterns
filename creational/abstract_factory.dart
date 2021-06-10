void main(){
  String systemVersion = "MacOS";
  
  Application app;
  GUIFactory guiFactory;
  
  if(systemVersion.contains("Windows")){
    guiFactory = new WindowsFactory();
    app = new Application(guiFactory);
  }else{
    guiFactory = new MacOSFactory();
    app = new Application(guiFactory);
  }
  
  app.paint();
  
}

abstract class Button{
  void paint();
}

class MacOSButton implements Button{
  @override
  void paint() {
    print("You have created MacOSButton");
  }
  
}

class WindowsButton implements Button{
  @override
  void paint() {
    print("You have created WindowsButton");
  }
  
}


abstract class CheckBox{
  void paint();
}


class MacOSCheckbox implements CheckBox{
  @override
  void paint() {
    print("You have created MacOSCheckbox");
  }
  
}

class WindowsCheckbox implements CheckBox{
  @override
  void paint() {
    print("You have created WindowsCheckbox");
  }
  
}

abstract class GUIFactory{
  Button createButton();
  CheckBox createCheckBox();
}

class MacOSFactory implements GUIFactory{
  @override
  CheckBox createCheckBox() {
    return new MacOSCheckbox();
  }

  @override
  Button createButton() {
    return new MacOSButton();
  }
  
}

class WindowsFactory implements GUIFactory{
  @override
  CheckBox createCheckBox() {
    return new WindowsCheckbox();
  }

  @override
  Button createButton() {
    return new WindowsButton();
  }
  
}


class Application{
  
  Button button;
  CheckBox checkBox;
  
  Application(GUIFactory guiFactory){
    button = guiFactory.createButton();
    checkBox = guiFactory.createCheckBox();
  }
  
  void paint(){
    button.paint();
    checkBox.paint();
  }
}