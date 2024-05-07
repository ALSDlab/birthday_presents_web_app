class UserModel {
  String name;
  String id;
  String postcode;
  String phone;
  String address;
  String addressDetail;
  bool checked;
  int created;

//<editor-fold desc="Data Methods">
  UserModel({
    required this.name,
    required this.id,
    required this.postcode,
    required this.phone,
    required this.address,
    required this.addressDetail,
    required this.checked,
    required this.created,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserModel &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          id == other.id &&
          postcode == other.postcode &&
          phone == other.phone &&
          address == other.address &&
          addressDetail == other.addressDetail &&
          checked == other.checked &&
          created == other.created);

  @override
  int get hashCode =>
      name.hashCode ^
      id.hashCode ^
      postcode.hashCode ^
      phone.hashCode ^
      address.hashCode ^
      addressDetail.hashCode ^
      checked.hashCode ^
      created.hashCode;

  @override
  String toString() {
    return 'User{ name: $name, id: $id, postcode: $postcode, phone: $phone, address: $address, addressDetail: $addressDetail, checked: $checked, created: $created,}';
  }

  UserModel copyWith({
    String? name,
    String? id,
    String? postcode,
    String? phone,
    String? address,
    String? addressDetail,
    bool? checked,
    int? created,
  }) {
    return UserModel(
      name: name ?? this.name,
      id: id ?? this.id,
      postcode: postcode ?? this.postcode,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      addressDetail: addressDetail ?? this.addressDetail,
      checked: checked ?? this.checked,
      created: created ?? this.created,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
      'postcode': postcode,
      'phone': phone,
      'address': address,
      'addressDetail': addressDetail,
      'checked': checked,
      'created': created,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] as String,
      id: map['id'] as String,
      postcode: map['postcode'] as String,
      phone: map['phone'] as String,
      address: map['address'] as String,
      addressDetail: map['addressDetail'] as String,
      checked: map['checked'] as bool,
      created: map['created'] as int,
    );
  }

//</editor-fold>
}