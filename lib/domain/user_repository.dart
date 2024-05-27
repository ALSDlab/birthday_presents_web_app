import '../data/model/user_model.dart';

abstract interface class UserRepository {
  Future<List<UserModel>> getFirebaseUserData(String userId);

  Future<void> deleteFirebaseUserData(String userId);

  Future<List<String>> getUsedEmails();

  Future<void> addEmailToFirestore(String email);
}