import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myk_market_app/data/model/coupons_model.dart';
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

  @override
  Future<CouponsModel?> getCoupon(int couponId) async {
    try {
      // Firebase Firestore에서 데이터 읽어오기
      var querySnapshot = await _firestore
          .collection('coupons')
          .where('couponId', isEqualTo: couponId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // 첫 번째 문서를 가져와서 CouponsModel로 변환
        var doc = querySnapshot.docs.first;
        return CouponsModel.fromJson(doc.data());
      } else {
        // 쿠폰이 없을 경우 null 반환
        return null;
      }
    } catch (e) {
      // 오류가 발생하면 null 반환하거나, 적절한 오류 처리를 합니다.
      logger.info('Error getting coupon: $e');
      return null;
    }
  }

  @override
  Future<void> deleteUsedCoupon(String userId, int? usedCouponId) async {
    final CollectionReference collectionRef = _firestore.collection('user');
    try {
      QuerySnapshot querySnapshot =
          await collectionRef.where('id', isEqualTo: userId).get();

      // 해당 userId를 가진 문서가 존재하는지 확인
      if (querySnapshot.docs.isEmpty) {
        throw Exception('No document found for the given userId!');
      }

      // 문서 참조 가져오기 (여기서는 첫 번째 문서만 사용)
      DocumentReference userDocRef = querySnapshot.docs.first.reference;

      // 트랜잭션 사용
      await _firestore.runTransaction((transaction) async {
        // 사용자 문서 가져오기
        DocumentSnapshot snapshot = await transaction.get(userDocRef);

        if (!snapshot.exists) {
          throw Exception("User document does not exist!");
        }

        // 현재 couponId 리스트 가져오기
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        List<dynamic> couponIds = data['coupons'] ?? [];

        // couponId 리스트에서 특정 쿠폰 ID 삭제
        if (usedCouponId != null) {
          couponIds.remove(usedCouponId);
        }

        // 업데이트된 리스트로 문서 업데이트
        transaction.update(userDocRef, {'coupons': couponIds});
      });

      logger.info("Coupon ID removed successfully.");
    } catch (e) {
      logger.info("Failed to remove coupon ID: $e");
    }
  }

  @override
  Future<void> renewCouponCount(String userId) async {
    final CollectionReference collectionRef = _firestore.collection('user');
    try {
      QuerySnapshot querySnapshot =
          await collectionRef.where('id', isEqualTo: userId).get();

      // 해당 userId를 가진 문서가 존재하는지 확인
      if (querySnapshot.docs.isEmpty) {
        throw Exception('No document found for the given userId!');
      }

      // 문서 참조 가져오기 (여기서는 첫 번째 문서만 사용)
      DocumentReference userDocRef = querySnapshot.docs.first.reference;

      // 트랜잭션 사용
      await _firestore.runTransaction((transaction) async {
        // 사용자 문서 가져오기
        DocumentSnapshot snapshot = await transaction.get(userDocRef);

        if (!snapshot.exists) {
          throw Exception("User document does not exist!");
        }

        // 현재 couponId 리스트 가져오기
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        List<dynamic> couponIds = data['coupons'] ?? [];
        int lastCouponCount = data['lastCouponCount'] ?? 0;

        // couponId 리스트에서 특정 쿠폰 ID 삭제
        if (lastCouponCount != couponIds.length) {
          lastCouponCount = couponIds.length;
        }

        // 업데이트된 리스트로 문서 업데이트
        transaction.update(userDocRef, {'lastCouponCount': lastCouponCount});
      });

      logger.info("Coupon ID removed successfully.");
    } catch (e) {
      logger.info("Failed to remove coupon ID: $e");
    }
  }
}
