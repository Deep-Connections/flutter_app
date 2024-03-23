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
  static const Route login = Route('login', null);
  static const Route register = Route('register', login);
  static const Route forgotPassword = Route('forgot_password', login);
}

class ProfileRoutes {
  static const Route main = Route('profile', null);
  static const Route name = Route('name', main);
  static const Route birthday = Route('birthday', main);
  static const Route gender = Route('gender', main);
  static const Route height = Route('height', main);
}
