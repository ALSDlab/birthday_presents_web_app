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
  // @override
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

  // Future<void> _loadData() async {
  //   final viewModel = context.read<StoreViewModel>();
  //   await viewModel.loadingHome();
  // }

  //void initData() async {
  //   ? Center(
  //       child: CircularProgressIndicator(),
  //     )
  //   : Expanded(
  // child: viewModel.storeList,
  // child: Card(
  //
  //   shape: BeveledRectangleBorder(
  //       borderRadius: BorderRadius.circular(16.0),
  //       side: BorderSide(width: 5.0)),
  //   elevation: 4.0,
  //   color: Colors.red,
  // ),

  //}

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<StoreViewModel>();
    final state = viewModel.state;

    return Scaffold(
      appBar: AppBar(
        title: Text('민영기 염소탕 회사소개'),
      ),
      body: ListView(
        children: [
          viewModel.isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Expanded(
                  child: Image.network(
                    viewModel.storeList[0].titleImage,
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
