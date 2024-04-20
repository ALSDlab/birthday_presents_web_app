class Store {
  String introText;

//<editor-fold desc="Data Methods">
  Store({
    required this.introText,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Store &&
          runtimeType == other.runtimeType &&
          introText == other.introText);

  @override
  int get hashCode => introText.hashCode;

  @override
  String toString() {
    return 'Store{introText: $introText}';
  }

  Store copyWith({
    String? introText,
  }) {
    return Store(
      introText: introText ?? this.introText,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'introText': this.introText,
    };
  }

  factory Store.fromJson(Map<String, dynamic> map) {
    return Store(
      introText: map['introText'] as String,
    );
  }

//</editor-fold>
}