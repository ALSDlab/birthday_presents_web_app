import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:myk_market_app/view/page/search_page/search_page_view_model.dart';
import 'package:provider/provider.dart';

import '../../../utils/gif_progress_bar.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({
    super.key,
    required this.resetNavigation,
    required this.hideNavBar,
    required this.docId,
    required this.name,
    required this.birthYear,
  });

  final bool Function(int) resetNavigation;
  final bool Function(bool) hideNavBar;
  final String docId;
  final String name;
  final int birthYear;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late bool _showListBadge;


  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SearchPageViewModel>();
    final state = viewModel.state;
    _showListBadge = state.forBadgeList.isNotEmpty;
    return Scaffold(

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
              child: (state.isLoading)
                  ? Center(
                      child: GifProgressBar(),
                    )
                  : Padding(
                      padding: EdgeInsets.only(
                          top: 5.0,
                          left: 5.0,
                          right: 5.0,
                          bottom: state.showSnackbarPadding
                              ? MediaQuery.of(context).padding.bottom + 48.0
                              : 0), // Snackbar 높이만큼 padding 추가
                      child: Column(
                        children: [
                          //TODO: 쇼핑몰 사이트 나타내기



                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(flex: 2, child: Container()),
                                Expanded(
                                  flex: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                      ),
                                      onPressed:
                                          () async {
                                        Map<String, dynamic> item = {};
                                        //TODO: 쇼핑몰 링크 및 정보를 item에 담기.

                                        await viewModel
                                            .addToPresentsList(
                                            item,
                                            context);
                                        final newBadgeCount =
                                        await viewModel
                                            .getBadgeCount();
                                        widget.resetNavigation(
                                            newBadgeCount);
                                      },
                                      child: const Text(
                                        'ADD LIST',
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(flex: 2, child: Container()),
                              ],
                            ),
                          ),
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
