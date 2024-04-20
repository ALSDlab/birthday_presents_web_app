class Store {
  String introText;
  String titleImage;

//<editor-fold desc="Data Methods">
  Store({
    required this.introText,
    required this.titleImage,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Store &&
          runtimeType == other.runtimeType &&
          introText == other.introText &&
          titleImage == other.titleImage);

  @override
  int get hashCode => introText.hashCode ^ titleImage.hashCode;

  @override
  String toString() {
    return 'Store{ introText: $introText, titleImage: $titleImage,}';
  }

  Store copyWith({
    String? introText,
    String? titleImage,
  }) {
    return Store(
      introText: introText ?? this.introText,
      titleImage: titleImage ?? this.titleImage,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'introText': introText,
      'titleImage': titleImage,
    };
  }

  factory Store.fromJson(Map<String, dynamic> map) {
    return Store(
      introText: map['introText'] as String,
      titleImage: map['titleImage'] as String,
    );
  }

//</editor-fold>
}