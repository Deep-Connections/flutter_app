class Route {
  final String _path;
  final Route? parent;

  const Route(this._path, this.parent);

  get path {
    if (parent == null) {
      return '/$_path';
    } else {
      return _path;
    }
  }

  String get fullPath => parent != null ? '${parent!.fullPath}/$_path' : path;
}

class HomeRoutes {
  static const Route home = Route('home', null);
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
