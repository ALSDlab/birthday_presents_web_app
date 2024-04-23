import 'package:flutter/material.dart';
import 'package:kpostal_web/widget/kakao_address_widget.dart';
import 'package:myk_market_app/view/page/signup_page/signup_page_view_model.dart';

class PostSearchingPageWeb extends StatefulWidget {
  const PostSearchingPageWeb({super.key});

  @override
  State<PostSearchingPageWeb> createState() => _PostSearchingPageWebState();
}

class _PostSearchingPageWebState extends State<PostSearchingPageWeb> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('주소용 페이지'),
      ),
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: KakaoAddressWidget(
              onComplete: (kakaoAddress) {
                print('onComplete KakaoAddress: $kakaoAddress');
                print('주소: ${kakaoAddress.address}');
                print('우편번호: ${kakaoAddress.postCode}');
                SignupViewModel viewModel = SignupViewModel();
                viewModel.setAddress(kakaoAddress.address, kakaoAddress.postCode);
                print(viewModel.address);
              },
              onClose: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }
}