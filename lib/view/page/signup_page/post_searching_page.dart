import 'package:daum_postcode_search/daum_postcode_search.dart';
import 'package:flutter/material.dart';

class PostSearchingPage extends StatefulWidget {
  const PostSearchingPage({super.key});

  @override
  _PostSearchingPageState createState() => _PostSearchingPageState();
}

class _PostSearchingPageState extends State<PostSearchingPage> {
  bool _isError = false;
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    DaumPostcodeSearch daumPostcodeSearch = DaumPostcodeSearch(
      onConsoleMessage: (_, message) => print(message),
      onLoadError: (controller, uri, errorCode, message) => setState(
            () {
          _isError = true;
          errorMessage = message;
        },
      ),
      onLoadHttpError: (controller, uri, errorCode, message) => setState(
            () {
          _isError = true;
          errorMessage = message;
        },
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("주소 검색"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: daumPostcodeSearch,
          ),
          Visibility(
            visible: _isError,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(errorMessage ?? ""),
                ElevatedButton(
                  child: const Text("Refresh"),
                  onPressed: () {
                    daumPostcodeSearch.controller?.reload();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}