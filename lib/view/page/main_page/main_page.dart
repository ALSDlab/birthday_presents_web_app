import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myk_market_app/data/repository/connectivity_observer.dart';
import 'package:myk_market_app/data/repository/network_connectivity_observer.dart';
import 'package:myk_market_app/view/page/main_page/store_view_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/gif_progress_bar.dart';
import '../../../utils/image_load_widget.dart';
import '../pay_page/send_sms_widget.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  //네트워크 통신 확인 코드
  final ConnectivityObserver _connectivityObserver =
      NetworkConnectivityObserver();

  //기본 접속 상태 설정
  var _status = Status.unavailable;

  StreamSubscription<Status>? _subscription;

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      final StoreViewModel viewModel = context.read<StoreViewModel>();
      viewModel.loadingHome();
    });

    _subscription = _connectivityObserver.observe().listen((status) {

      setState(() {
        _status = status;
        //print('Status changed : $_status');
        if(_status == Status.available) {

        }
      });
    });

    //super.initState();
    //   Future.delayed(Duration.zero,() {
    //     _loadData();
    //   });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final viewModel = context.watch<StoreViewModel>();
    final state = viewModel.state;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2F362F),
        leading: Text('네트워크 상태 : ${_status.name}'),
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              border: Border.all(width: 1, color: Colors.white,),
            ),
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                      image: DecorationImage(
                          image: AssetImage('assets/images/myk_market_logo.png'),
                          fit: BoxFit.cover)),
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            const Text(
              '민영기 염소탕',
              style: TextStyle(
                  fontFamily: 'Jalnan', fontSize: 27, color: Colors.white),
            ),
          ],
        ),

        // 테스트용으로 만든 버튼입니다. 아직 지우지 마세요.(이성대)
        actions: [
          TextButton(
              onPressed: () {
                sendSMS('01058377427', '01032084619', 'SMS테스트입니다.');
              },
              child: const Text('SMS테스트'))
        ],
      ),
      body: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(32), topRight: Radius.circular(32)),
        child: Container(
          color: const Color(0xFFFFF8E7),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: viewModel.isLoading
                ? const Center(
                    child: GifProgressBar(),
                  )
                : ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: ImageLoadWidget(
                            width: MediaQuery.of(context).size.width,
                            widthHeightRatio: 0.6,
                            imageUrl: viewModel.storeList[0].titleImage,
                          ),
                        ),
                      ),
                       SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        style: TextStyle(
                          fontSize: 13.w,
                        ),
                        textAlign: TextAlign.center,
                        'BRAND STORY',
                      ),
                       SizedBox(
                        height: 20.h,
                      ),
                      Column(
                        children: [
                          Text(
                            viewModel.storeList[0].introText,
                            style: TextStyle(fontSize: 16.w),
                          ),
                          Text(
                            viewModel.storeList[0].introTextOne,
                            style: TextStyle(fontSize: 11.w),
                          ),
                          Text(
                            viewModel.storeList[0].introTextTwo,
                            style: TextStyle(fontSize: 11.w),
                          ),
                          Text(
                            viewModel.storeList[0].introTextThree,
                            style: TextStyle(fontSize: 11.w),
                          ),
                          Text(
                            viewModel.storeList[0].introTextFour,
                            style: TextStyle(fontSize: 11.w),
                          ),
                          Text(
                            viewModel.storeList[0].introTextFive,
                            style: TextStyle(fontSize: 11.w),
                          ),
                          Text(
                            viewModel.storeList[0].introTextSix,
                            style: TextStyle(fontSize: 11.w),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: ImageLoadWidget(
                            width: MediaQuery.of(context).size.width,
                            widthHeightRatio: 1.5,
                            imageUrl: viewModel.storeList[0].images[15],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: ImageLoadWidget(
                          width: MediaQuery.of(context).size.width,
                          widthHeightRatio: 1.5,
                          imageUrl: viewModel.storeList[0].images[17],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: ImageLoadWidget(
                          width: MediaQuery.of(context).size.width,
                          widthHeightRatio: 1.5,
                          imageUrl: viewModel.storeList[0].images[14],
                        ),
                      ),
                      // Image.network(viewModel.storeList[0].images[1]),
                      // Image.network(viewModel.storeList[0].images[3]),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

// SingleChildScrollView(
// child: Column(
// children: [
// if (viewModel.isLoading)
// Center(
// child: GifProgressBar(),
// )
// else if (viewModel.storeList.isNotEmpty)
// Expanded(
// child: Image.network(
// viewModel.storeList![0].titleImage,
// ),
// ),
// Container(
// child: Text(
// textAlign: TextAlign.center,
// 'BRAND STORY',
// style: TextStyle(
// fontSize: 16.0,
// fontWeight: FontWeight.w800,
// ),
// ),
// ),
// SizedBox(
// height: 20,
// ),
// Container(
// child: viewModel.storeList.isNotEmpty
// ? Text(viewModel.storeList[0].introText)
//     : Text('No data availabe'),
// ),
// Container(
// alignment: Alignment.bottomCenter,
// child: Text(viewModel.storeList[0].introTextOne),
// ),
// Container(
// alignment: Alignment.bottomCenter,
// child: Text(viewModel.storeList[0].introTextTwo),
// ),
// Container(
// alignment: Alignment.bottomCenter,
// child: Text(viewModel.storeList[0].introTextThree),
// ),
// Container(
// alignment: Alignment.bottomCenter,
// child: Text(viewModel.storeList[0].introTextFour),
// ),
// Container(
// alignment: Alignment.bottomCenter,
// child: Text(viewModel.storeList[0].introTextFive),
// ),
// Container(
// alignment: Alignment.bottomCenter,
// child: Text(viewModel.storeList[0].introTextSix),
// ),
// Container(
// alignment: Alignment.bottomCenter,
// child: Text(viewModel.storeList[0].introTextSeven),
// ),
// Container(
// child: Expanded(
// child: Image.network(viewModel.storeList[0].images[5]),
// ),
// ),
// Container(
// child: Expanded(
// child: Image.network(viewModel.storeList[0].images[7]),
// ),
// ),
// Container(
// child: Image.network(viewModel.storeList[0].images[12]),
// ),
// Container(
// child: Expanded(
// child: Image.network(viewModel.storeList[0].images[14]),
// ),
// ),
// ],
// ),
// ),
