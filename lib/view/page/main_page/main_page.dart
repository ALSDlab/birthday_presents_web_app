import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myk_market_app/view/page/main_page/store_view_model.dart';
import 'package:provider/provider.dart';

import '../../../utils/gif_progress_bar.dart';
import '../../../utils/image_load_widget.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  //네트워크 통신 확인 코드
  // final ConnectivityObserver _connectivityObserver =
  //     NetworkConnectivityObserver();
  //
  // //기본 접속 상태 설정
  // var _status = Status.unavailable;
  //
  // StreamSubscription<Status>? _subscription;

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      final StoreViewModel viewModel = context.read<StoreViewModel>();
      viewModel.loadingHome();
    });

    // _subscription = _connectivityObserver.observe().listen((status) {
    //   setState(() {
    //     _status = status;
    //     //print('Status changed : $_status');
    //     //인터넷 연결 확인 체크 코드
    //     if (_status == Status.unavailable) {
    //       showConnectionErrorDialog();
    //     }
    //   });
    // });
  }

  // //인터넷 연결 확인 체크 위젯
  // void showConnectionErrorDialog() {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return OneAnswerDialog(
  //           onTap: () {
  //             Navigator.pop(context);
  //           },
  //           title: '신호없음',
  //           subtitle: '인터넷 연결을 확인해주세요',
  //           firstButton: '확인',
  //           imagePath: 'assets/gifs/internetLost.gif');
  //     },
  //   );
  // }
  //
  // @override
  // void dispose() {
  //   _subscription?.cancel();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<StoreViewModel>();
    final state = viewModel.state;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2F362F),
        scrolledUnderElevation: 0,
        //leading: Text('네트워크 상태 : ${_status.name}'),
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                border: Border.all(
                  width: 1,
                  color: Colors.white,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                          image:
                              AssetImage('assets/images/myk_market_logo.png'),
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
      ),
      body: Center(
        child: SizedBox(
          width: (MediaQuery.of(context).size.width >= 1200)
              ? 1200
              : MediaQuery.of(context).size.width,
          child: ClipRRect(
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
                                width:
                                    (MediaQuery.of(context).size.width >= 1200)
                                        ? 1200
                                        : MediaQuery.of(context).size.width,
                                imageUrl: viewModel.storeList[0].titleImage,
                                fit: BoxFit.cover,
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
                                width:
                                    (MediaQuery.of(context).size.width >= 1200)
                                        ? 1200
                                        : MediaQuery.of(context).size.width,
                                imageUrl: viewModel.storeList[0].images[19],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: ImageLoadWidget(
                                width:
                                    (MediaQuery.of(context).size.width >= 1200)
                                        ? 1200
                                        : MediaQuery.of(context).size.width,
                                imageUrl: viewModel.storeList[0].images[43],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: ImageLoadWidget(
                                width:
                                    (MediaQuery.of(context).size.width >= 1200)
                                        ? 1200
                                        : MediaQuery.of(context).size.width,
                                imageUrl: viewModel.storeList[0].images[30],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: ImageLoadWidget(
                                width:
                                    (MediaQuery.of(context).size.width >= 1200)
                                        ? 1200
                                        : MediaQuery.of(context).size.width,
                                imageUrl: viewModel.storeList[0].images[14],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          // Image.network(viewModel.storeList[0].images[1]),
                          // Image.network(viewModel.storeList[0].images[3]),
                        ],
                      ),
              ),
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
//