// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) {
  return _OrderModel.fromJson(json);
}

/// @nodoc
mixin _$OrderModel {
  @JsonKey(name: 'orderId')
  String get orderId => throw _privateConstructorUsedError;
  @JsonKey(name: 'orderProductName')
  String get orderProductName => throw _privateConstructorUsedError;
  @JsonKey(name: 'representativeImage')
  String get representativeImage => throw _privateConstructorUsedError;
  @JsonKey(name: 'price')
  String get price => throw _privateConstructorUsedError;
  @JsonKey(name: 'count')
  int get count => throw _privateConstructorUsedError;
  @JsonKey(name: 'orderedDate')
  String? get orderedDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'personalInfoForDeliverChecked')
  bool? get personalInfoForDeliverChecked => throw _privateConstructorUsedError;
  @JsonKey(name: 'ordererId')
  String? get ordererId => throw _privateConstructorUsedError;
  @JsonKey(name: 'ordererName')
  String? get ordererName => throw _privateConstructorUsedError;
  @JsonKey(name: 'ordererPhoneNo')
  String? get ordererPhoneNo => throw _privateConstructorUsedError;
  @JsonKey(name: 'ordererAddress')
  String? get ordererAddress => throw _privateConstructorUsedError;
  @JsonKey(name: 'ordererAddressDetail')
  String? get ordererAddressDetail => throw _privateConstructorUsedError;
  @JsonKey(name: 'ordererPostcode')
  String? get ordererPostcode => throw _privateConstructorUsedError;
  @JsonKey(name: 'payAndStatus')
  int? get payAndStatus =>
      throw _privateConstructorUsedError; // -1: 결제실패, 0: 결제전, 1: 결제완료, 2: 결제취소, 3: 배송중, 4: 배송완료
  @JsonKey(name: 'payAmount')
  int? get payAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'paymentDate')
  String? get paymentDate => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OrderModelCopyWith<OrderModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderModelCopyWith<$Res> {
  factory $OrderModelCopyWith(
          OrderModel value, $Res Function(OrderModel) then) =
      _$OrderModelCopyWithImpl<$Res, OrderModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'orderId') String orderId,
      @JsonKey(name: 'orderProductName') String orderProductName,
      @JsonKey(name: 'representativeImage') String representativeImage,
      @JsonKey(name: 'price') String price,
      @JsonKey(name: 'count') int count,
      @JsonKey(name: 'orderedDate') String? orderedDate,
      @JsonKey(name: 'personalInfoForDeliverChecked')
      bool? personalInfoForDeliverChecked,
      @JsonKey(name: 'ordererId') String? ordererId,
      @JsonKey(name: 'ordererName') String? ordererName,
      @JsonKey(name: 'ordererPhoneNo') String? ordererPhoneNo,
      @JsonKey(name: 'ordererAddress') String? ordererAddress,
      @JsonKey(name: 'ordererAddressDetail') String? ordererAddressDetail,
      @JsonKey(name: 'ordererPostcode') String? ordererPostcode,
      @JsonKey(name: 'payAndStatus') int? payAndStatus,
      @JsonKey(name: 'payAmount') int? payAmount,
      @JsonKey(name: 'paymentDate') String? paymentDate});
}

/// @nodoc
class _$OrderModelCopyWithImpl<$Res, $Val extends OrderModel>
    implements $OrderModelCopyWith<$Res> {
  _$OrderModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderId = null,
    Object? orderProductName = null,
    Object? representativeImage = null,
    Object? price = null,
    Object? count = null,
    Object? orderedDate = freezed,
    Object? personalInfoForDeliverChecked = freezed,
    Object? ordererId = freezed,
    Object? ordererName = freezed,
    Object? ordererPhoneNo = freezed,
    Object? ordererAddress = freezed,
    Object? ordererAddressDetail = freezed,
    Object? ordererPostcode = freezed,
    Object? payAndStatus = freezed,
    Object? payAmount = freezed,
    Object? paymentDate = freezed,
  }) {
    return _then(_value.copyWith(
      orderId: null == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as String,
      orderProductName: null == orderProductName
          ? _value.orderProductName
          : orderProductName // ignore: cast_nullable_to_non_nullable
              as String,
      representativeImage: null == representativeImage
          ? _value.representativeImage
          : representativeImage // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as String,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      orderedDate: freezed == orderedDate
          ? _value.orderedDate
          : orderedDate // ignore: cast_nullable_to_non_nullable
              as String?,
      personalInfoForDeliverChecked: freezed == personalInfoForDeliverChecked
          ? _value.personalInfoForDeliverChecked
          : personalInfoForDeliverChecked // ignore: cast_nullable_to_non_nullable
              as bool?,
      ordererId: freezed == ordererId
          ? _value.ordererId
          : ordererId // ignore: cast_nullable_to_non_nullable
              as String?,
      ordererName: freezed == ordererName
          ? _value.ordererName
          : ordererName // ignore: cast_nullable_to_non_nullable
              as String?,
      ordererPhoneNo: freezed == ordererPhoneNo
          ? _value.ordererPhoneNo
          : ordererPhoneNo // ignore: cast_nullable_to_non_nullable
              as String?,
      ordererAddress: freezed == ordererAddress
          ? _value.ordererAddress
          : ordererAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      ordererAddressDetail: freezed == ordererAddressDetail
          ? _value.ordererAddressDetail
          : ordererAddressDetail // ignore: cast_nullable_to_non_nullable
              as String?,
      ordererPostcode: freezed == ordererPostcode
          ? _value.ordererPostcode
          : ordererPostcode // ignore: cast_nullable_to_non_nullable
              as String?,
      payAndStatus: freezed == payAndStatus
          ? _value.payAndStatus
          : payAndStatus // ignore: cast_nullable_to_non_nullable
              as int?,
      payAmount: freezed == payAmount
          ? _value.payAmount
          : payAmount // ignore: cast_nullable_to_non_nullable
              as int?,
      paymentDate: freezed == paymentDate
          ? _value.paymentDate
          : paymentDate // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OrderModelImplCopyWith<$Res>
    implements $OrderModelCopyWith<$Res> {
  factory _$$OrderModelImplCopyWith(
          _$OrderModelImpl value, $Res Function(_$OrderModelImpl) then) =
      __$$OrderModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'orderId') String orderId,
      @JsonKey(name: 'orderProductName') String orderProductName,
      @JsonKey(name: 'representativeImage') String representativeImage,
      @JsonKey(name: 'price') String price,
      @JsonKey(name: 'count') int count,
      @JsonKey(name: 'orderedDate') String? orderedDate,
      @JsonKey(name: 'personalInfoForDeliverChecked')
      bool? personalInfoForDeliverChecked,
      @JsonKey(name: 'ordererId') String? ordererId,
      @JsonKey(name: 'ordererName') String? ordererName,
      @JsonKey(name: 'ordererPhoneNo') String? ordererPhoneNo,
      @JsonKey(name: 'ordererAddress') String? ordererAddress,
      @JsonKey(name: 'ordererAddressDetail') String? ordererAddressDetail,
      @JsonKey(name: 'ordererPostcode') String? ordererPostcode,
      @JsonKey(name: 'payAndStatus') int? payAndStatus,
      @JsonKey(name: 'payAmount') int? payAmount,
      @JsonKey(name: 'paymentDate') String? paymentDate});
}

/// @nodoc
class __$$OrderModelImplCopyWithImpl<$Res>
    extends _$OrderModelCopyWithImpl<$Res, _$OrderModelImpl>
    implements _$$OrderModelImplCopyWith<$Res> {
  __$$OrderModelImplCopyWithImpl(
      _$OrderModelImpl _value, $Res Function(_$OrderModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderId = null,
    Object? orderProductName = null,
    Object? representativeImage = null,
    Object? price = null,
    Object? count = null,
    Object? orderedDate = freezed,
    Object? personalInfoForDeliverChecked = freezed,
    Object? ordererId = freezed,
    Object? ordererName = freezed,
    Object? ordererPhoneNo = freezed,
    Object? ordererAddress = freezed,
    Object? ordererAddressDetail = freezed,
    Object? ordererPostcode = freezed,
    Object? payAndStatus = freezed,
    Object? payAmount = freezed,
    Object? paymentDate = freezed,
  }) {
    return _then(_$OrderModelImpl(
      orderId: null == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as String,
      orderProductName: null == orderProductName
          ? _value.orderProductName
          : orderProductName // ignore: cast_nullable_to_non_nullable
              as String,
      representativeImage: null == representativeImage
          ? _value.representativeImage
          : representativeImage // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as String,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      orderedDate: freezed == orderedDate
          ? _value.orderedDate
          : orderedDate // ignore: cast_nullable_to_non_nullable
              as String?,
      personalInfoForDeliverChecked: freezed == personalInfoForDeliverChecked
          ? _value.personalInfoForDeliverChecked
          : personalInfoForDeliverChecked // ignore: cast_nullable_to_non_nullable
              as bool?,
      ordererId: freezed == ordererId
          ? _value.ordererId
          : ordererId // ignore: cast_nullable_to_non_nullable
              as String?,
      ordererName: freezed == ordererName
          ? _value.ordererName
          : ordererName // ignore: cast_nullable_to_non_nullable
              as String?,
      ordererPhoneNo: freezed == ordererPhoneNo
          ? _value.ordererPhoneNo
          : ordererPhoneNo // ignore: cast_nullable_to_non_nullable
              as String?,
      ordererAddress: freezed == ordererAddress
          ? _value.ordererAddress
          : ordererAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      ordererAddressDetail: freezed == ordererAddressDetail
          ? _value.ordererAddressDetail
          : ordererAddressDetail // ignore: cast_nullable_to_non_nullable
              as String?,
      ordererPostcode: freezed == ordererPostcode
          ? _value.ordererPostcode
          : ordererPostcode // ignore: cast_nullable_to_non_nullable
              as String?,
      payAndStatus: freezed == payAndStatus
          ? _value.payAndStatus
          : payAndStatus // ignore: cast_nullable_to_non_nullable
              as int?,
      payAmount: freezed == payAmount
          ? _value.payAmount
          : payAmount // ignore: cast_nullable_to_non_nullable
              as int?,
      paymentDate: freezed == paymentDate
          ? _value.paymentDate
          : paymentDate // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderModelImpl implements _OrderModel {
  const _$OrderModelImpl(
      {@JsonKey(name: 'orderId') required this.orderId,
      @JsonKey(name: 'orderProductName') required this.orderProductName,
      @JsonKey(name: 'representativeImage') required this.representativeImage,
      @JsonKey(name: 'price') required this.price,
      @JsonKey(name: 'count') required this.count,
      @JsonKey(name: 'orderedDate') this.orderedDate,
      @JsonKey(name: 'personalInfoForDeliverChecked')
      this.personalInfoForDeliverChecked,
      @JsonKey(name: 'ordererId') this.ordererId,
      @JsonKey(name: 'ordererName') this.ordererName,
      @JsonKey(name: 'ordererPhoneNo') this.ordererPhoneNo,
      @JsonKey(name: 'ordererAddress') this.ordererAddress,
      @JsonKey(name: 'ordererAddressDetail') this.ordererAddressDetail,
      @JsonKey(name: 'ordererPostcode') this.ordererPostcode,
      @JsonKey(name: 'payAndStatus') this.payAndStatus,
      @JsonKey(name: 'payAmount') this.payAmount,
      @JsonKey(name: 'paymentDate') this.paymentDate});

  factory _$OrderModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderModelImplFromJson(json);

  @override
  @JsonKey(name: 'orderId')
  final String orderId;
  @override
  @JsonKey(name: 'orderProductName')
  final String orderProductName;
  @override
  @JsonKey(name: 'representativeImage')
  final String representativeImage;
  @override
  @JsonKey(name: 'price')
  final String price;
  @override
  @JsonKey(name: 'count')
  final int count;
  @override
  @JsonKey(name: 'orderedDate')
  final String? orderedDate;
  @override
  @JsonKey(name: 'personalInfoForDeliverChecked')
  final bool? personalInfoForDeliverChecked;
  @override
  @JsonKey(name: 'ordererId')
  final String? ordererId;
  @override
  @JsonKey(name: 'ordererName')
  final String? ordererName;
  @override
  @JsonKey(name: 'ordererPhoneNo')
  final String? ordererPhoneNo;
  @override
  @JsonKey(name: 'ordererAddress')
  final String? ordererAddress;
  @override
  @JsonKey(name: 'ordererAddressDetail')
  final String? ordererAddressDetail;
  @override
  @JsonKey(name: 'ordererPostcode')
  final String? ordererPostcode;
  @override
  @JsonKey(name: 'payAndStatus')
  final int? payAndStatus;
// -1: 결제실패, 0: 결제전, 1: 결제완료, 2: 결제취소, 3: 배송중, 4: 배송완료
  @override
  @JsonKey(name: 'payAmount')
  final int? payAmount;
  @override
  @JsonKey(name: 'paymentDate')
  final String? paymentDate;

  @override
  String toString() {
    return 'OrderModel(orderId: $orderId, orderProductName: $orderProductName, representativeImage: $representativeImage, price: $price, count: $count, orderedDate: $orderedDate, personalInfoForDeliverChecked: $personalInfoForDeliverChecked, ordererId: $ordererId, ordererName: $ordererName, ordererPhoneNo: $ordererPhoneNo, ordererAddress: $ordererAddress, ordererAddressDetail: $ordererAddressDetail, ordererPostcode: $ordererPostcode, payAndStatus: $payAndStatus, payAmount: $payAmount, paymentDate: $paymentDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderModelImpl &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            (identical(other.orderProductName, orderProductName) ||
                other.orderProductName == orderProductName) &&
            (identical(other.representativeImage, representativeImage) ||
                other.representativeImage == representativeImage) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.count, count) || other.count == count) &&
            (identical(other.orderedDate, orderedDate) ||
                other.orderedDate == orderedDate) &&
            (identical(other.personalInfoForDeliverChecked,
                    personalInfoForDeliverChecked) ||
                other.personalInfoForDeliverChecked ==
                    personalInfoForDeliverChecked) &&
            (identical(other.ordererId, ordererId) ||
                other.ordererId == ordererId) &&
            (identical(other.ordererName, ordererName) ||
                other.ordererName == ordererName) &&
            (identical(other.ordererPhoneNo, ordererPhoneNo) ||
                other.ordererPhoneNo == ordererPhoneNo) &&
            (identical(other.ordererAddress, ordererAddress) ||
                other.ordererAddress == ordererAddress) &&
            (identical(other.ordererAddressDetail, ordererAddressDetail) ||
                other.ordererAddressDetail == ordererAddressDetail) &&
            (identical(other.ordererPostcode, ordererPostcode) ||
                other.ordererPostcode == ordererPostcode) &&
            (identical(other.payAndStatus, payAndStatus) ||
                other.payAndStatus == payAndStatus) &&
            (identical(other.payAmount, payAmount) ||
                other.payAmount == payAmount) &&
            (identical(other.paymentDate, paymentDate) ||
                other.paymentDate == paymentDate));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      orderId,
      orderProductName,
      representativeImage,
      price,
      count,
      orderedDate,
      personalInfoForDeliverChecked,
      ordererId,
      ordererName,
      ordererPhoneNo,
      ordererAddress,
      ordererAddressDetail,
      ordererPostcode,
      payAndStatus,
      payAmount,
      paymentDate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderModelImplCopyWith<_$OrderModelImpl> get copyWith =>
      __$$OrderModelImplCopyWithImpl<_$OrderModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderModelImplToJson(
      this,
    );
  }
}

abstract class _OrderModel implements OrderModel {
  const factory _OrderModel(
      {@JsonKey(name: 'orderId') required final String orderId,
      @JsonKey(name: 'orderProductName') required final String orderProductName,
      @JsonKey(name: 'representativeImage')
      required final String representativeImage,
      @JsonKey(name: 'price') required final String price,
      @JsonKey(name: 'count') required final int count,
      @JsonKey(name: 'orderedDate') final String? orderedDate,
      @JsonKey(name: 'personalInfoForDeliverChecked')
      final bool? personalInfoForDeliverChecked,
      @JsonKey(name: 'ordererId') final String? ordererId,
      @JsonKey(name: 'ordererName') final String? ordererName,
      @JsonKey(name: 'ordererPhoneNo') final String? ordererPhoneNo,
      @JsonKey(name: 'ordererAddress') final String? ordererAddress,
      @JsonKey(name: 'ordererAddressDetail') final String? ordererAddressDetail,
      @JsonKey(name: 'ordererPostcode') final String? ordererPostcode,
      @JsonKey(name: 'payAndStatus') final int? payAndStatus,
      @JsonKey(name: 'payAmount') final int? payAmount,
      @JsonKey(name: 'paymentDate')
      final String? paymentDate}) = _$OrderModelImpl;

  factory _OrderModel.fromJson(Map<String, dynamic> json) =
      _$OrderModelImpl.fromJson;

  @override
  @JsonKey(name: 'orderId')
  String get orderId;
  @override
  @JsonKey(name: 'orderProductName')
  String get orderProductName;
  @override
  @JsonKey(name: 'representativeImage')
  String get representativeImage;
  @override
  @JsonKey(name: 'price')
  String get price;
  @override
  @JsonKey(name: 'count')
  int get count;
  @override
  @JsonKey(name: 'orderedDate')
  String? get orderedDate;
  @override
  @JsonKey(name: 'personalInfoForDeliverChecked')
  bool? get personalInfoForDeliverChecked;
  @override
  @JsonKey(name: 'ordererId')
  String? get ordererId;
  @override
  @JsonKey(name: 'ordererName')
  String? get ordererName;
  @override
  @JsonKey(name: 'ordererPhoneNo')
  String? get ordererPhoneNo;
  @override
  @JsonKey(name: 'ordererAddress')
  String? get ordererAddress;
  @override
  @JsonKey(name: 'ordererAddressDetail')
  String? get ordererAddressDetail;
  @override
  @JsonKey(name: 'ordererPostcode')
  String? get ordererPostcode;
  @override
  @JsonKey(name: 'payAndStatus')
  int? get payAndStatus;
  @override // -1: 결제실패, 0: 결제전, 1: 결제완료, 2: 결제취소, 3: 배송중, 4: 배송완료
  @JsonKey(name: 'payAmount')
  int? get payAmount;
  @override
  @JsonKey(name: 'paymentDate')
  String? get paymentDate;
  @override
  @JsonKey(ignore: true)
  _$$OrderModelImplCopyWith<_$OrderModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}