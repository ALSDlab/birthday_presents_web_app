import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myk_market_app/data/repository/connectivity_observer.dart';
import 'package:myk_market_app/data/repository/network_connectivity_observer.dart';
import 'package:myk_market_app/view/page/main_page/store_view_model.dart';
import 'package:provider/provider.dart';

import '../pay_page/send_sms_widget.dart';
import 'image_load_widget.dart';

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
      print('Status changed : $_status');
      setState(() {
        _status = status;
      });
    });

    super.initState();
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
        title: const Text(
          '민영기 염소탕 회사소개',
          style: TextStyle(
              fontFamily: 'Jalnan', fontSize: 20, color: Colors.white),
        ),

        // 테스트용으로 만든 버튼입니다. 아직 지우지 마세요.(이성대)
        actions: [
          TextButton(
              onPressed: () {
                sendSMS('01058377427', '01032084619', 'SMS테스트입니다.');
              },
              child: Text('SMS테스트'))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: viewModel.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
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
                  const SizedBox(
                    height: 20,
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
                      Text(viewModel.storeList[0].introTextOne),
                      Text(viewModel.storeList[0].introTextTwo),
                      Text(viewModel.storeList[0].introTextThree),
                      Text(viewModel.storeList[0].introTextFour),
                      Text(viewModel.storeList[0].introTextFive),
                      Text(viewModel.storeList[0].introTextSix),
                    ],
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
    );
  }
}

// SingleChildScrollView(
// child: Column(
// children: [
// if (viewModel.isLoading)
// Center(
// child: CircularProgressIndicator(),
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
