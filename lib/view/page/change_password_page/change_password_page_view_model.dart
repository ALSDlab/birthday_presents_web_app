import 'package:cloud_firestore/cloud_firestore.dart';

class ChangePasswordViewModel {
  Future<String> findDocumentId(String name, String phoneNumber) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      CollectionReference collectionRef =
      firestore.collection('user');
      QuerySnapshot querySnapshot = await collectionRef
          .where('name', isEqualTo: name)
          .where('phone', isEqualTo: phoneNumber)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first.id;
      }
      return 'id가 존재하지 않습니다.';
    } catch (error) {
      print('오류 발생: $error');
      return '';
    }
  }
}
