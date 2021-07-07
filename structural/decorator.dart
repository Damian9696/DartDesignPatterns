void main() {
  BaseDecorator baseDecorator = EmailNotifierDecorator(SMSNotifierDecorator(BaseDecorator(Emergency())));
  baseDecorator.sendMessage("Test2");
}


abstract class Notifier{
  void sendMessage(String data);
}

class Emergency implements Notifier{
  
  @override
  void sendMessage(String data) {
    print("Sending emergency message... Message: ${data}");
  }
  
}

class BaseDecorator implements Notifier {
  
  Notifier notifier;
  
  BaseDecorator(this.notifier);
  
  @override
  void sendMessage(String data) {
    notifier.sendMessage(data);
  }
  
}

class SMSNotifierDecorator extends BaseDecorator{
  
  SMSNotifierDecorator(Notifier notifier) : super(notifier);
  
  @override
  void sendMessage(String data) {
    super.sendMessage(data);
    _sendSmsMessage(data);
  }
  
  void _sendSmsMessage(String data){
    print("Sending sms message... Message ${data}");
  }
  
}

class EmailNotifierDecorator extends BaseDecorator{
  
  EmailNotifierDecorator(Notifier notifier) : super(notifier);
  
  @override
  void sendMessage(String data) {
    super.sendMessage(data);
    sendEmailMessage(data);
  }
  
  void sendEmailMessage(String data){
    print("Sending email message... Message ${data}");
  }
  
}
