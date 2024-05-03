import '../data/model/user_model.dart';

abstract interface class UserRepository {
  Future<List<UserModel>> getFirebaseUserData(String userId);
}