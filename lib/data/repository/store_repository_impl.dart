import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myk_market_app/data/model/store_model.dart';
import 'package:myk_market_app/domain/store_repository.dart';

class StoreRepositoryImpl implements StoreRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<List<Store>> getFirebaseStore() async {
    QuerySnapshot querySnapshot = await _firestore
        .collection('company')
        .orderBy('introText', descending: false)
        .get();

    List<Store> data = [];
    for (var document in querySnapshot.docs) {
      data.add(Store.fromJson(document.data() as Map<String, dynamic>));
    }
    return data;
  }
}
