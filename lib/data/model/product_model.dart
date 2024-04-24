class Product {
  String representativeImage;
  String price;
  String title;
  String delivery;
  String ingredients;

//<editor-fold desc="Data Methods">
  Product({
    required this.representativeImage,
    required this.price,
    required this.title,
    required this.delivery,
    required this.ingredients,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Product &&
          runtimeType == other.runtimeType &&
          representativeImage == other.representativeImage &&
          price == other.price &&
          title == other.title &&
          delivery == other.delivery &&
          ingredients == other.ingredients);

  @override
  int get hashCode =>
      representativeImage.hashCode ^
      price.hashCode ^
      title.hashCode ^
      delivery.hashCode ^
      ingredients.hashCode;

  @override
  String toString() {
    return 'Product{ representativeImage: $representativeImage, price: $price, title: $title, delivery: $delivery, ingredients: $ingredients,}';
  }

  Product copyWith({
    String? representativeImage,
    String? price,
    String? title,
    String? delivery,
    String? ingredients,
  }) {
    return Product(
      representativeImage: representativeImage ?? this.representativeImage,
      price: price ?? this.price,
      title: title ?? this.title,
      delivery: delivery ?? this.delivery,
      ingredients: ingredients ?? this.ingredients,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'representativeImage': representativeImage,
      'price': price,
      'title': title,
      'delivery': delivery,
      'ingredients': ingredients,
    };
  }

  factory Product.fromJson(Map<String, dynamic> map) {
    return Product(
      representativeImage: map['representativeImage'] as String,
      price: map['price'] as String,
      title: map['title'] as String,
      delivery: map['delivery'] as String,
      ingredients: map['ingredients'] as String,
    );
  }

//</editor-fold>
}
