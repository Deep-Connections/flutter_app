import '../../models/profile/profile/profile.dart';
import '../utils/response.dart';

abstract class ProfileService {
  Future<Profile> get profile;

  Future<Response<void>> updateProfile(Profile Function(Profile) callback);
}
