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

  String get link => parent != null ? '${parent!.link}/$_path' : path;
}

class HomeRoutes {
  static const Route home = Route('home', null);
}

class AuthRoutes {
  static const Route login = Route('login', null);
  static const Route register = Route('register', login);
  static const Route forgotPassword = Route('forgot_password', login);
}
