class Store {
  String introText = '';
  String introTextOne = '';
  String introTextTwo = '';
  String introTextThree = '';
  String introTextFour = '';
  String introTextFive = '';
  String introTextSix = '';
  String introTextSeven = '';

  String titleImage = '';

  List<String> images = [];

  Store({
    required this.introText,
    required this.titleImage,
    required this.images,
    required this.introTextOne,
    required this.introTextTwo,
    required this.introTextThree,
    required this.introTextFour,
    required this.introTextFive,
    required this.introTextSix,
    required this.introTextSeven,
  });

  Store.fromJson(Map<String, dynamic> json) {
    introText = json['introText'];
    introTextOne = json['introTextOne'];
    introTextTwo = json['introTextTwo'];
    introTextThree = json['introTextThree'];
    introTextFour = json['introTextFour'];
    introTextFive = json['introTextFive'];
    introTextSix = json['introTextSix'];
    introTextSeven = json['introTextSeven'];
    titleImage = json['titleImage'];
    images = json['images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['introText'] = this.introText;
    data['introTextOne'] = this.introTextOne;
    data['introTextTwo'] = this.introTextTwo;
    data['introTextThree'] = this.introTextThree;
    data['introTextFour'] = this.introTextFour;
    data['introTextFive'] = this.introTextFive;
    data['introTextSix'] = this.introTextSix;
    data['introTextSeven'] = this.introTextSeven;
    data['titleImage'] = this.titleImage;
    data['images'] = this.images;
    return data;
  }
}
