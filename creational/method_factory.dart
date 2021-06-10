void main() {
  String systemName = "html";
  Dialog dialog; 
  
  if(systemName.contains("Windows")){
    dialog= new WindowsDialog();
  }else{
    dialog = new HtmlDialog();
  }
  
  var button = dialog.createButton();
  button.render();
  button.onClick();
}

abstract class Button{
  void render();
  void onClick();
}

class HtmlButton implements Button{
  
  @override
  void onClick() {
    print("HtmlButton onClick");
  }

  @override
  void render() {
    print("HtmlButton render");
  }
  
}

class WindowsButton implements Button{
  @override
  void onClick() {
    print("WindowsButton onClick");
  }

  @override
  void render() {
    print("WindowsButton render");
  }
  
}

abstract class Dialog{
  void renderWindow(){
    Button okButton = createButton();
    okButton.render();
  }
  
  Button createButton();
}


class HtmlDialog extends Dialog{
  @override
  Button createButton() {
    return new HtmlButton();
  }
  
}

class WindowsDialog extends Dialog{
  @override
  Button createButton() {
    return new WindowsButton();
   }
}