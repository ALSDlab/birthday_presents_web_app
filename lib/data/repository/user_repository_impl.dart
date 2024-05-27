import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myk_market_app/data/model/user_model.dart';
import 'package:myk_market_app/domain/user_repository.dart';
import 'package:myk_market_app/utils/simple_logger.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<List<UserModel>> getFirebaseUserData(String userId) async {
    // Firebase Firestore에서 데이터 읽어오기
    var query = _firestore.collection('user').where('id', isEqualTo: userId);

    List<UserModel> result = [];
    await query.get().then((QuerySnapshot querySnapshot) {
      for (var document in querySnapshot.docs) {
        result.add(UserModel.fromJson(document.data() as Map<String, dynamic>));
      }
    });
    return result;
  }

  @override
  Future<void> deleteFirebaseUserData(String userId) async {
    final CollectionReference collectionRef = _firestore.collection('user');
    try {
      QuerySnapshot querySnapshot =
          await collectionRef.where('id', isEqualTo: userId).get();
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs) {
          await collectionRef.doc(doc.id).delete();
        }
      } else {
        logger.info('No document found with userId: $userId');
      }
    } catch (e) {
      logger.info('Error deleting document: $e');
    }
  }

  @override
  Future<List<String>> getUsedEmails() async {
    try {
      DocumentSnapshot docSnapshot =
          await _firestore.collection('user').doc('used_emails').get();
      List<String> emails = List<String>.from(docSnapshot['used_emails']);
      return emails;
    } catch (e) {
      logger.info('Error fetching emails: $e');
      return [];
    }
  }

  @override
  Future<void> addEmailToFirestore(String email) async {
    try {
      DocumentReference docRef =
          FirebaseFirestore.instance.collection('user').doc('used_emails');
      await docRef.update({
        'used_emails': FieldValue.arrayUnion([email])
      });
    } catch (e) {
      logger.info('Error adding email: $e');
    }
  }
}
