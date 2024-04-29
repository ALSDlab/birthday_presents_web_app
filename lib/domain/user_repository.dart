import '../data/model/user_model.dart';

abstract interface class UserRepository {
  Future<List<User>> getFirebaseUserData();
}