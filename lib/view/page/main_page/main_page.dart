import 'package:flutter/material.dart';
import 'package:myk_market_app/view/page/main_page/store_view_model.dart';
import 'package:myk_market_app/view/page/pay_page/send_sms_widget.dart';
import 'package:provider/provider.dart';

import 'image_load_widget.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<StoreViewModel>();
    final state = viewModel.state;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '민영기 염소탕 회사소개',
          style: TextStyle(fontFamily: 'Jalnan', fontSize: 20),
        ),

        // 테스트용으로 만든 버튼입니다. 아직 지우지 마세요.(이성대)
        // actions: [
        //   TextButton(onPressed: (){
        //     sendSMS('0410000000', '01032084619', 'SMS테스트입니다.');
        //   }, child: Text('SMS테스트'))
        // ],
      ),
      body: viewModel.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              children: [
                ImageLoadWidget(
                  width: MediaQuery.of(context).size.width,
                  widthHeightRatio: 0.6,
                  imageUrl: viewModel.storeList[0].titleImage,
                ),
                const Text(
                  'BRAND STORY',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    Text(viewModel.storeList[0].introText),
                  ],
                ),
                Text(viewModel.storeList[0].introTextOne),
                ImageLoadWidget(
                  width: MediaQuery.of(context).size.width,
                  widthHeightRatio: 1.5,
                  imageUrl: viewModel.storeList[0].images[1],
                ),
                ImageLoadWidget(
                  width: MediaQuery.of(context).size.width,
                  widthHeightRatio: 1.5,
                  imageUrl: viewModel.storeList[0].images[3],
                ),
                // Image.network(viewModel.storeList[0].images[1]),
                // Image.network(viewModel.storeList[0].images[3]),
              ],
            ),
    );
  }
}
