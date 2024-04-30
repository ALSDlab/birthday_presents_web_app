import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myk_market_app/view/page/main_page/store_view_model.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    Future.microtask(() {
      final StoreViewModel viewModel = context.read<StoreViewModel>();
      viewModel.loadingHome();
    });

    super.initState();
    //   Future.delayed(Duration.zero,() {
    //     _loadData();
    //   });
  }

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
      ),
      body: ListView(
        children: [
          viewModel.isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Expanded(
                  child: Image.network(
                    viewModel.storeList![0].titleImage,

                  ),

                ),


          Container(
            child: Text(
              'BRAND STORY',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            child: Column(
              children: [
                Text(viewModel.storeList[0].introText),
              ],
            ),
          ),
          Container(
            child: Text(viewModel.storeList[0].introTextOne),
          ),
          Container(
            child: Expanded(
              child: Image.network(viewModel.storeList[0].images[1]),
            ),
          ),
          Container(child: Image.network(viewModel.storeList[0].images[3])),
        ],
      ),
    );
  }
}
