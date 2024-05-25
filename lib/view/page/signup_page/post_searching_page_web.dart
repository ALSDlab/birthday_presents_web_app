import 'package:flutter/material.dart';
import 'package:kpostal_web/widget/kakao_address_widget.dart';
import 'package:myk_market_app/view/page/signup_page/signup_page_view_model.dart';

class PostSearchingPageWeb extends StatefulWidget {
  const PostSearchingPageWeb({super.key});

  @override
  State<PostSearchingPageWeb> createState() => _PostSearchingPageWebState();
}

Map<String, String> addressSet = {};

void getAddress(String postcode, String address){
  addressSet['postcode'] = postcode;
  addressSet['address'] = address;
}

class _PostSearchingPageWebState extends State<PostSearchingPageWeb> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('주소 검색'),
      ),
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: KakaoAddressWidget(
              onComplete: (kakaoAddress) {
                getAddress(kakaoAddress.postCode, kakaoAddress.address);
              },
              onClose: () {
                Navigator.of(context).pop(addressSet);
              },
            ),
          ),
        ],
      ),
    );
  }
}