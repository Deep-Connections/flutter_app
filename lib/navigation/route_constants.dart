import 'package:deep_connections/utils/loc_key.dart';
import 'package:flutter/material.dart';

class NavRoute {
  final String _path;
  final NavRoute? parent;
  final String? pathParameter;

  const NavRoute(this._path, this.parent, {this.pathParameter});

  String get path {
    return pathParameter != null ? '$_path/:$pathParameter' : _path;
  }

  String parameterPath(List<String> parameters) {
    final String subPath;
    final List<String> restParameters;
    if (pathParameter != null) {
      subPath = "$_path/${parameters.last}";
      restParameters = parameters.sublist(0, parameters.length - 1);
    } else {
      subPath = _path;
      restParameters = parameters;
    }
    return parent != null
        ? '${parent!.parameterPath(restParameters)}/$subPath'
        : "/$subPath";
  }

  String get fullPath {
    var basePath = parent != null ? '${parent!.fullPath}/$_path' : "/$_path";
    return basePath;
  }
}

class BottomNavRoute extends NavRoute {
  final LocKey title;
  final IconData? icon;

  BottomNavRoute(String path, NavRoute? parent, this.title, this.icon)
      : super(path, parent);
}

const homeRoute = "/";

class AuthRoutes {
  static const main = NavRoute('auth', null);
  static const login = NavRoute('login', main);
  static const register = NavRoute('register', main);
  static const forgotPassword = NavRoute('forgot_password', main);
}

class InitialProfileRoutes {
  static const main = NavRoute('initial_profile', null);
}

class BottomNavigation {
  static final profile = BottomNavRoute(
      'profile', null, LocKey((loc) => loc.profile_title), Icons.person);
  static final chat = BottomNavRoute('connections', null,
      LocKey((loc) => loc.chat_title), Icons.message_rounded);
  static final values = [chat, profile];
  static final main = values.first;
}

class ProfileRoutes {
  static final additional = NavRoute('additional', BottomNavigation.profile);
  static final photos = NavRoute('photos', BottomNavigation.profile);
  static final settings = NavRoute('settings', BottomNavigation.profile);
  static final section = NavRoute('section', BottomNavigation.profile,
      pathParameter: 'sectionPath');
  static final step = NavRoute('step', section, pathParameter: 'stepPath');
}

class MainRoutes {
  static const match = NavRoute('connection', null);
  static const messages = NavRoute('messages', match, pathParameter: 'chatId');
  static const matchProfile = NavRoute('profile', messages);
}
