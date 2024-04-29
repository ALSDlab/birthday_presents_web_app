class ShoppingProductForCart {
  String orderId;
  String orderProductName;
  String price;
  int count;

//<editor-fold desc="Data Methods">
  ShoppingProductForCart({
    required this.orderId,
    required this.orderProductName,
    required this.price,
    required this.count,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ShoppingProductForCart &&
          runtimeType == other.runtimeType &&
          orderId == other.orderId &&
          orderProductName == other.orderProductName &&
          price == other.price &&
          count == other.count);

  @override
  int get hashCode =>
      orderId.hashCode ^
      orderProductName.hashCode ^
      price.hashCode ^
      count.hashCode;

  @override
  String toString() {
    return 'ShoppingProductForCart{ orderId: $orderId, orderProductName: $orderProductName, price: $price, count: $count,}';
  }

  ShoppingProductForCart copyWith({
    String? orderId,
    String? orderProductName,
    String? price,
    int? count,
  }) {
    return ShoppingProductForCart(
      orderId: orderId ?? this.orderId,
      orderProductName: orderProductName ?? this.orderProductName,
      price: price ?? this.price,
      count: count ?? this.count,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'orderProductName': orderProductName,
      'price': price,
      'count': count,
    };
  }

  factory ShoppingProductForCart.fromJson(Map<String, dynamic> map) {
    return ShoppingProductForCart(
      orderId: map['orderId'] as String,
      orderProductName: map['orderProductName'] as String,
      price: map['price'] as String,
      count: map['count'] as int,
    );
  }

//</editor-fold>
}
