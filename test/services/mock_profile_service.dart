import 'package:deep_connections/services/profile/firebase_profile_service.dart';
import 'package:deep_connections/services/user/user_service.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';

import 'fake_firebase_auth.dart';
import 'mock_firebase_storage.dart';

FirebaseProfileService getFakeProfileService() => FirebaseProfileService(
    UserService(getSignedInMockFirebaseAuth()),
    FakeFirebaseFirestore(),
    MockFirebaseStorage());
