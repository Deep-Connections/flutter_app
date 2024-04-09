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

const homeRoute = BottomNavigation.main;

class BottomNavigation {
  static const Route main = profile;
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
