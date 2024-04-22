class User {
  String name;
  String id;
  String password;
  int phone;
  String address;

//<editor-fold desc="Data Methods">
  User({
    required this.name,
    required this.id,
    required this.password,
    required this.phone,
    required this.address,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          id == other.id &&
          password == other.password &&
          phone == other.phone &&
          address == other.address);

  @override
  int get hashCode =>
      name.hashCode ^
      id.hashCode ^
      password.hashCode ^
      phone.hashCode ^
      address.hashCode;

  @override
  String toString() {
    return 'User{' +
        ' name: $name,' +
        ' id: $id,' +
        ' password: $password,' +
        ' phone: $phone,' +
        ' address: $address,' +
        '}';
  }

  User copyWith({
    String? name,
    String? id,
    String? password,
    int? phone,
    String? address,
  }) {
    return User(
      name: name ?? this.name,
      id: id ?? this.id,
      password: password ?? this.password,
      phone: phone ?? this.phone,
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'id': this.id,
      'password': this.password,
      'phone': this.phone,
      'address': this.address,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'] as String,
      id: map['id'] as String,
      password: map['password'] as String,
      phone: map['phone'] as int,
      address: map['address'] as String,
    );
  }

//</editor-fold>
}