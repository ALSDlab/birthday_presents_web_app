class Product {
  String productId;
  String representativeImage;
  String price;
  String title;
  String delivery;
  String ingredients;
  List<String> images;

//<editor-fold desc="Data Methods">
  Product({
    required this.productId,
    required this.representativeImage,
    required this.price,
    required this.title,
    required this.delivery,
    required this.ingredients,
    required this.images,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Product &&
          runtimeType == other.runtimeType &&
          productId == other.productId &&
          representativeImage == other.representativeImage &&
          price == other.price &&
          title == other.title &&
          delivery == other.delivery &&
          ingredients == other.ingredients &&
          images == other.images);

  @override
  int get hashCode =>
      productId.hashCode ^
      representativeImage.hashCode ^
      price.hashCode ^
      title.hashCode ^
      delivery.hashCode ^
      ingredients.hashCode ^
      images.hashCode;

  @override
  String toString() {
    return 'Product{productId: $productId, representativeImage: $representativeImage, price: $price, title: $title, delivery: $delivery, ingredients: $ingredients, images: $images,}';
  }

  Product copyWith({
    String? productId,
    String? representativeImage,
    String? price,
    String? title,
    String? delivery,
    String? ingredients,
    List<String>? images,
  }) {
    return Product(
      productId: productId ?? this.productId,
      representativeImage: representativeImage ?? this.representativeImage,
      price: price ?? this.price,
      title: title ?? this.title,
      delivery: delivery ?? this.delivery,
      ingredients: ingredients ?? this.ingredients,
      images: images ?? this.images,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'representativeImage': representativeImage,
      'price': price,
      'title': title,
      'delivery': delivery,
      'ingredients': ingredients,
      'images': images,
    };
  }

  factory Product.fromJson(Map<String, dynamic> map) {
    return Product(
      productId: map['productId'] as String,
      representativeImage: map['representativeImage'] as String,
      price: map['price'] as String,
      title: map['title'] as String,
      delivery: map['delivery'] as String,
      ingredients: map['ingredients'] as String,
      images: (map['images'] as List<dynamic>).map((image) => image.toString()).toList(),
    );
  }

//</editor-fold>
}
