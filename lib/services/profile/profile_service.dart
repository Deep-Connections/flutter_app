import '../../models/profile/profile/profile.dart';
import '../utils/response.dart';

abstract class ProfileService {
  Stream<Profile> get profile;

  Future<Response<void>> updateProfile(Profile Function(Profile) callback);
}
