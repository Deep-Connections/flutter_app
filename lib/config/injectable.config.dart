// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:deep_connections/services/auth/auth_service.dart' as _i3;
import 'package:deep_connections/services/auth/firebase_auth_service.dart'
    as _i4;
import 'package:deep_connections/services/chat/chat_service.dart' as _i6;
import 'package:deep_connections/services/profile/firebase_profile_service.dart'
    as _i7;
import 'package:deep_connections/services/user/user_service.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i3.AuthService>(() => _i4.FirebaseAuthService());
    gh.singleton<_i5.UserService>(_i5.UserService());
    gh.lazySingleton<_i6.ChatService>(
        () => _i6.ChatService(gh<_i5.UserService>()));
    gh.factory<_i7.FirebaseProfileService>(
        () => _i7.FirebaseProfileService(gh<_i5.UserService>()));
    return this;
  }
}
