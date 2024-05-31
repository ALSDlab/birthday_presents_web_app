import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';


part 'user_model.freezed.dart';

part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({

    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'id') required String id,
    @JsonKey(name: 'postcode') required String postcode,
    @JsonKey(name: 'phone') required String phone,
    @JsonKey(name: 'address') required String address,
    @JsonKey(name: 'addressDetail') required String addressDetail,
    @JsonKey(name: 'checked') required bool checked,
    @JsonKey(name: 'created') required int created,
    @JsonKey(name: 'recreatCount') required int recreatCount,
    @JsonKey(name: 'profileImage') required String profileImage,
    @JsonKey(name: 'coupons') required List<int> coupons,
    @JsonKey(name: 'verificationLimit') required int verificationLimit,

  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
}

