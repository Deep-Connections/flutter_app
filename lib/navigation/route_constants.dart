class Route {
  final String _path;
  final Route? parent;
  final String? pathParameter;

  const Route(this._path, this.parent, {this.pathParameter});

  get path {
    return pathParameter != null ? '$_path/:$pathParameter' : _path;
  }

  String get fullPath {
    var basePath = parent != null ? '${parent!.fullPath}/$_path' : "/$_path";
    return basePath;
  }
}

const homeRoute = "/";

class MainRoutes {
  static const messages = Route('messages', null, pathParameter: 'chatId');
}

class BottomNavigation {
  static const main = profile;
  static const Route profile = Route('profile', null);
  static const Route chat = Route('chat', null);
}

class AuthRoutes {
  static const Route main = Route('auth', null);
  static const Route login = Route('login', main);
  static const Route register = Route('register', main);
  static const Route forgotPassword = Route('forgot_password', main);
}

class CompleteProfileRoutes {
  static const Route main = Route('complete_profile', null);
}
