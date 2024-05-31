class ShoppingProductForCart {
  String orderId;
  String productId;
  String orderProductName;
  String price;
  String representativeImage;
  int count;
  int salesId;
  bool? isChecked;


//<editor-fold desc="Data Methods">
  ShoppingProductForCart({
    required this.orderId,
    required this.productId,
    required this.orderProductName,
    required this.price,
    required this.representativeImage,
    required this.count,
    required this.salesId,
    this.isChecked,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ShoppingProductForCart &&
          runtimeType == other.runtimeType &&
          orderId == other.orderId &&
          productId == other.productId &&
          orderProductName == other.orderProductName &&
          price == other.price &&
          representativeImage == other.representativeImage &&
          count == other.count &&
          salesId == other.salesId &&
          isChecked == other.isChecked);

  @override
  int get hashCode =>
      orderId.hashCode ^
      productId.hashCode ^
      orderProductName.hashCode ^
      price.hashCode ^
      representativeImage.hashCode ^
      count.hashCode ^
      salesId.hashCode ^
      isChecked.hashCode;

  @override
  String toString() {
    return 'ShoppingProductForCart{ orderId: $orderId, productId: $productId, orderProductName: $orderProductName, price: $price, representativeImage: $representativeImage, count: $count, salesId: $salesId, isChecked: $isChecked,}';
  }

  ShoppingProductForCart copyWith({
    String? orderId,
    String? productId,
    String? orderProductName,
    String? price,
    String? representativeImage,
    int? count,
    int? salesId,
    bool? isChecked,
  }) {
    return ShoppingProductForCart(
      orderId: orderId ?? this.orderId,
      productId: productId ?? this.productId,
      orderProductName: orderProductName ?? this.orderProductName,
      price: price ?? this.price,
      representativeImage: representativeImage ?? this.representativeImage,
      count: count ?? this.count,
      salesId: count ?? this.salesId,
      isChecked: isChecked ?? this.isChecked,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'productId': productId,
      'orderProductName': orderProductName,
      'price': price,
      'representativeImage': representativeImage,
      'count': count,
      'salesId': salesId,
      'isChecked': isChecked,
    };
  }

  factory ShoppingProductForCart.fromJson(Map<String, dynamic> map) {
    return ShoppingProductForCart(
      orderId: map['orderId'] as String,
      productId: map['productId'] as String,
      orderProductName: map['orderProductName'] as String,
      price: map['price'] as String,
      representativeImage: map['representativeImage'] as String,
      count: map['count'] as int,
      salesId: map['salesId'] as int,
      isChecked: map['isChecked'] ?? false,
    );
  }

//</editor-fold>
}
