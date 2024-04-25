import 'package:deep_connections/models/user/user.dart';
import 'package:deep_connections/services/user/user_service.dart';
import 'package:mockito/mockito.dart';

class MockUserService extends Mock implements UserService {
  var _user = DcUser(id: "123");

  @override
  DcUser? get user => _user;

  @override
  String get userId => _user.id;

  @override
  Stream<String?> get userIdStream => Stream.value(_user.id);
}
