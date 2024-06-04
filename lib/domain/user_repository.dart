import '../data/model/coupons_model.dart';
import '../data/model/user_model.dart';

abstract interface class UserRepository {
  Future<List<UserModel>> getFirebaseUserData(String userId);

  Future<void> deleteFirebaseUserData(String userId);

  Future<List<String>> getUsedEmails();

  Future<void> addEmailToFirestore(String email);

  Future<CouponsModel?> getCoupon(Map<String, dynamic> couponItem);

  Future<void> deleteUsedCoupon(String userId, int? usedCouponId);

  Future<void> renewCouponCount(String userId);
}