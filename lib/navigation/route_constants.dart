class Route {
  final String _path;
  final Route? parent;
  final String? pathParameter;

  const Route(this._path, this.parent, {this.pathParameter});

  get path {
    if (_path == "/") return "/";
    final path = parent == null ? '/$_path' : _path;
    return pathParameter != null ? '$path/:$pathParameter' : path;
  }

  String get fullPath {
    var basePath = parent != null ? '${parent!.fullPath}/$_path' : _path;
    if (parent?.path == "/") basePath = "/$_path";
    return basePath;
  }
}

const homeRoute = MainRoutes.main;

class MainRoutes {
  static const main = Route("/", null);
  static const messages = Route('messages', main, pathParameter: 'chatId');
}

class BottomNavigation {
  static const main = profile;
  static const Route profile = Route('profile', MainRoutes.main);
  static const Route chat = Route('chat', MainRoutes.main);
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
