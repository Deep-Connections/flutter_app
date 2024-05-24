// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i4;
import 'package:cloud_functions/cloud_functions.dart' as _i5;
import 'package:deep_connections/config/injectable/firebase_module.dart'
    as _i14;
import 'package:deep_connections/services/auth/auth_service.dart' as _i8;
import 'package:deep_connections/services/auth/firebase_auth_service.dart'
    as _i9;
import 'package:deep_connections/services/chat/chat_service.dart' as _i10;
import 'package:deep_connections/services/profile/firebase_profile_service.dart'
    as _i12;
import 'package:deep_connections/services/profile/profile_service.dart' as _i11;
import 'package:deep_connections/services/user/user_service.dart' as _i7;
import 'package:deep_connections/services/user/user_status_service.dart'
    as _i13;
import 'package:firebase_auth/firebase_auth.dart' as _i3;
import 'package:firebase_storage/firebase_storage.dart' as _i6;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

const String _prod = 'prod';
const String _dev = 'dev';

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
    final firebaseModuleProd = _$FirebaseModuleProd();
    final firebaseModuleDev = _$FirebaseModuleDev();
    gh.singleton<_i3.FirebaseAuth>(
      () => firebaseModuleProd.auth,
      registerFor: {_prod},
    );
    gh.singleton<_i3.FirebaseAuth>(
      () => firebaseModuleDev.auth,
      registerFor: {_dev},
    );
    gh.singleton<_i4.FirebaseFirestore>(
      () => firebaseModuleProd.firestore,
      registerFor: {_prod},
    );
    gh.singleton<_i4.FirebaseFirestore>(
      () => firebaseModuleDev.firestore,
      registerFor: {_dev},
    );
    gh.singleton<_i5.FirebaseFunctions>(
      () => firebaseModuleProd.functions,
      registerFor: {_prod},
    );
    gh.singleton<_i5.FirebaseFunctions>(
      () => firebaseModuleDev.functions,
      registerFor: {_dev},
    );
    gh.singleton<_i6.FirebaseStorage>(
      () => firebaseModuleProd.storage,
      registerFor: {_prod},
    );
    gh.singleton<_i6.FirebaseStorage>(
      () => firebaseModuleDev.storage,
      registerFor: {_dev},
    );
    gh.singleton<_i7.UserService>(
        () => _i7.UserService(gh<_i3.FirebaseAuth>()));
    gh.factory<_i8.AuthService>(() => _i9.FirebaseAuthService(
          gh<_i3.FirebaseAuth>(),
          gh<_i5.FirebaseFunctions>(),
        ));
    gh.lazySingleton<_i10.ChatService>(() => _i10.ChatService(
          gh<_i7.UserService>(),
          gh<_i4.FirebaseFirestore>(),
          gh<_i5.FirebaseFunctions>(),
        ));
    gh.singleton<_i11.ProfileService>(() => _i12.FirebaseProfileService(
          gh<_i7.UserService>(),
          gh<_i4.FirebaseFirestore>(),
          gh<_i6.FirebaseStorage>(),
        ));
    gh.singleton<_i13.UserStatusService>(
        () => _i13.UserStatusService(gh<_i11.ProfileService>()));
    return this;
  }
}

class _$FirebaseModuleProd extends _i14.FirebaseModuleProd {}

class _$FirebaseModuleDev extends _i14.FirebaseModuleDev {}
