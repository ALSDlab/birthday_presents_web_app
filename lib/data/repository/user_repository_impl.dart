import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myk_market_app/data/model/user_model.dart';
import 'package:myk_market_app/domain/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Future<List<User>> getFirebaseUserData() async {
    // Firebase Firestore에서 데이터 읽어오기
    QuerySnapshot querySnapshot = await _firestore.collection('profile').get();

    // 데이터 파싱
    List<User> data = [];
    for (var document in querySnapshot.docs) {
      data.add(User.fromJson(document.data() as Map<String, dynamic>));
    }
    return data;
  }

}