class Product {
  String representativeImage;
  num price;
  String title;

//<editor-fold desc="Data Methods">
  Product({
    required this.representativeImage,
    required this.price,
    required this.title,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Product &&
          runtimeType == other.runtimeType &&
          representativeImage == other.representativeImage &&
          price == other.price &&
          title == other.title);

  @override
  int get hashCode =>
      representativeImage.hashCode ^ price.hashCode ^ title.hashCode;

  @override
  String toString() {
    return 'Product{ representativeImage: $representativeImage, price: $price, title: $title,}';
  }

  Product copyWith({
    String? representativeImage,
    num? price,
    String? title,
  }) {
    return Product(
      representativeImage: representativeImage ?? this.representativeImage,
      price: price ?? this.price,
      title: title ?? this.title,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'representativeImage': this.representativeImage,
      'price': this.price,
      'title': this.title,
    };
  }

  factory Product.fromJson(Map<String, dynamic> map) {
    return Product(
      representativeImage: map['representativeImage'] as String,
      price: map['price'] as num,
      title: map['title'] as String,
    );
  }

//</editor-fold>
}
