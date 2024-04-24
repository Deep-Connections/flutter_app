// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i6;
import 'package:deep_connections/config/injectable/firebase_module.dart'
    as _i13;
import 'package:deep_connections/services/auth/auth_service.dart' as _i3;
import 'package:deep_connections/services/auth/firebase_auth_service.dart'
    as _i4;
import 'package:deep_connections/services/chat/chat_service.dart' as _i12;
import 'package:deep_connections/services/profile/firebase_profile_service.dart'
    as _i10;
import 'package:deep_connections/services/profile/profile_service.dart' as _i9;
import 'package:deep_connections/services/user/user_service.dart' as _i8;
import 'package:deep_connections/services/user/user_status_service.dart'
    as _i11;
import 'package:firebase_auth/firebase_auth.dart' as _i5;
import 'package:firebase_storage/firebase_storage.dart' as _i7;
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
    final firebaseModule = _$FirebaseModule();
    gh.factory<_i3.AuthService>(() => _i4.FirebaseAuthService());
    gh.singleton<_i5.FirebaseAuth>(firebaseModule.auth);
    gh.singleton<_i6.FirebaseFirestore>(firebaseModule.firestore);
    gh.singleton<_i7.FirebaseStorage>(firebaseModule.storage);
    gh.singleton<_i8.UserService>(_i8.UserService(gh<_i5.FirebaseAuth>()));
    gh.singleton<_i9.ProfileService>(_i10.FirebaseProfileService(
      gh<_i8.UserService>(),
      gh<_i6.FirebaseFirestore>(),
      gh<_i7.FirebaseStorage>(),
    ));
    gh.singleton<_i11.UserStatusService>(
        _i11.UserStatusService(gh<_i9.ProfileService>()));
    gh.lazySingleton<_i12.ChatService>(() => _i12.ChatService(
          gh<_i8.UserService>(),
          gh<_i9.ProfileService>(),
        ));
    return this;
  }
}

class _$FirebaseModule extends _i13.FirebaseModule {}
