import 'package:flutter/material.dart';
import 'package:webview_all/webview_all.dart';

class PostSearchingPageWeb extends StatelessWidget {
  const PostSearchingPageWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return const Webview(url: 'https://oh8112191.cafe24.com/android/zipcode/daum_zipcode_flutter.html');
  }
}