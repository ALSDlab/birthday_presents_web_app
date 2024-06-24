import 'package:Birthday_Presents_List/view/page/search_page/search_page_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/gif_progress_bar.dart';
import '../../widgets/rounded_image_button.dart';

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
  final bool hideNavBar;
  final String docId;
  final String name;
  final int birthYear;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late bool _showListBadge;
  final Map<String, Uri> _urls = {
    'amazon': Uri.parse('https://www.amazon.de'),
    'smyths': Uri.parse(
        'https://www.smythstoys.com/de/de-de/aus-toys-r-us-wird-smyths-toys'),
    'teddytoys': Uri.parse('https://www.teddytoys.de/'),
    'germantoys': Uri.parse('https://www.german-toys.com/')
  };

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SearchPageViewModel>();
    final state = viewModel.state;
    _showListBadge = state.forBadgeList.isNotEmpty;
    final yearCount = DateTime.now().year - widget.birthYear;
    String countEnding = '';
    if (yearCount % 10 == 1 && yearCount != 11) {
      countEnding = 'st';
    } else if (yearCount % 10 == 2 && yearCount != 12) {
      countEnding = 'nd';
    } else if (yearCount % 10 == 3 && yearCount != 13) {
      countEnding = 'rd';
    } else {
      countEnding = 'th';
    }
    return Scaffold(
      backgroundColor: const Color(0xFFAEC6CF),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            GoRouter.of(context).go('/main_page', extra: {
              'resetNavigation': widget.resetNavigation,
              'hideNavBar': widget.hideNavBar,
            });
          },
          icon: const Icon(Icons.arrow_back, shadows: [
            Shadow(
              offset: Offset(2.0, 2.0),
              blurRadius: 3.0,
              color: Colors.black,
            ),
          ]),
          color: const Color(0xFF98FF98),
        ),
        backgroundColor: const Color(0xFFAEC6CF),
        title: Text(
          "${widget.name}'s $yearCount$countEnding BIRTHDAY!!",
          style: const TextStyle(
              fontFamily: 'Jalnan', fontSize: 27, color: Color(0xFF3A405A)),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Spacer(),
                          Center(
                            child: SizedBox(
                              width: 120.w,
                              height: 120.w,
                              child: GridView.count(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 16.0,
                                  mainAxisSpacing: 16.0,
                                  children: List.generate(4, (index) {
                                    return RoundedImageButton(
                                      width: 100,
                                      height: 100,
                                      imagePath:
                                          'images/${_urls.keys.toList()[index]}.png',
                                      onTap: () async {
                                        if (!await launchUrl(
                                            _urls.values.toList()[index])) {
                                          throw Exception(
                                              'Could not launch ${_urls.values.toList()[index]}');
                                        }
                                      },
                                    );
                                  })),
                            ),
                          ),
                          const Spacer(),
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
                                        side: const BorderSide(color: Colors.transparent ,width: 0),
                                        backgroundColor: const Color(0xFF98FF98),
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                      ),
                                      onPressed: () async {
                                        Map<String, dynamic> item = {};
                                        //TODO: 쇼핑몰 링크 및 정보를 item에 담기.

                                        await viewModel.addToPresentsList(
                                            item, context);
                                        final newBadgeCount =
                                            await viewModel.getBadgeCount();
                                        widget.resetNavigation(newBadgeCount);
                                      },
                                      child: const Text(
                                        'ADD LIST',
                                        style: TextStyle(
                                          color: Color(0xFF3A405A),
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
