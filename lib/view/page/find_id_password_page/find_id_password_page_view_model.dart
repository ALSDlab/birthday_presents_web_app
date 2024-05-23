import 'package:cloud_firestore/cloud_firestore.dart';

class FindIdPasswordViewModel {
  Future<String> findDocumentId(String name, String phoneNumber) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      CollectionReference collectionRef = firestore.collection('user');
      QuerySnapshot querySnapshot = await collectionRef
          .where('name', isEqualTo: name)
          .where('phone', isEqualTo: phoneNumber)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot document = await firestore.doc('user/${querySnapshot.docs.first.id}').get();
        return document.get('id');
      }
      return '';
    } catch (error) {
      print('오류 발생: $error');
      return '';
    }
  }
}
