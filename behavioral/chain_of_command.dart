void main() {
  final server = Server();

  init(server);

  server.logIn('admin1@example.com', 'admin1234');
  server.logIn('admin@example.com', 'admin12345');
  server.logIn('admin@example.com', 'admin1234');

  server.logIn('user@example.com', '123456');
}

void init(Server server) {
  server.register('admin@example.com', 'admin1234');
  server.register('user@example.com', '123456');

  var middleware = ThrottlingMiddleware(2);
  middleware
      .linkWith(UserExistsMiddleware(server))
      .linkWith(RoleCheckMiddleware());

  server.setMiddleware(middleware);
}

abstract class Middleware {
  Middleware? next;

  Middleware linkWith(Middleware next) {
    this.next = next;
    return next;
  }

  bool checkNext(String email, String password) {
    if (next == null) {
      return true;
    } else {
      return next!.check(email, password);
    }
  }

  bool check(String email, String password);
}

class ThrottlingMiddleware extends Middleware {
  int requestPerMinute;
  int request = 0;
  int currentTime = 0;

  ThrottlingMiddleware(this.requestPerMinute) {
    currentTime = DateTime.now().millisecondsSinceEpoch;
  }

  @override
  bool check(String email, String password) {
    if (DateTime.now().millisecondsSinceEpoch > currentTime + 60000) {
      request = 0;
      currentTime = DateTime.now().millisecondsSinceEpoch;
    }

    request++;

    if (request > requestPerMinute) {
      print('Request limit exceeded!');
    }

    return checkNext(email, password);
  }
}

class UserExistsMiddleware extends Middleware {
  final Server server;

  UserExistsMiddleware(this.server);

  @override
  bool check(String email, String password) {
    if (!server.hasEmail(email)) {
      print('This email is not register');
      return false;
    }

    if (!server.isValidPassword(email, password)) {
      print('Wrong password');
      return false;
    }

    return checkNext(email, password);
  }
}

class RoleCheckMiddleware extends Middleware {
  @override
  bool check(String email, String password) {
    if (email == 'admin@example.com') {
      print('Hello, admin!');
      return true;
    }
    print('Hello, user!');
    return checkNext(email, password);
  }
}

class Server {
  Map users = <String, String>{};
  late Middleware middleware;

  void setMiddleware(Middleware middleware) {
    this.middleware = middleware;
  }

  bool logIn(String email, String password) {
    if (middleware.check(email, password)) {
      print('Authorization have been successful');
      return true;
    } else {
      return false;
    }
  }

  void register(String email, String password) {
    users[email] = password;
  }

  bool hasEmail(String email) {
    return users.containsKey(email);
  }

  bool isValidPassword(String email, String password) {
    return users[email] == password;
  }
}
