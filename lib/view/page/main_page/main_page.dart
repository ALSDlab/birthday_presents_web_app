import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
      viewModel.getStoreList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<StoreViewModel>();
    final state = viewModel.state;
    return Scaffold(
      appBar: AppBar(
        title: Text('민영기 염소탕 회사소개'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(child: Image.network(state.storeList[0].titleImage)),
            ],
          ),
          Text('BRAND STORY'),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(state.storeList[0].introText),
          ),
        ],
      ),
    );
  }
}
