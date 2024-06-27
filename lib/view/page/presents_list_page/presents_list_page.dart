import 'package:Birthday_Presents_List/view/page/presents_list_page/presents_list_page_widget.dart';
import 'package:Birthday_Presents_List/view/page/presents_list_page/presents_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../utils/gif_progress_bar.dart';
import '../../widgets/one_answer_dialog.dart';

class PresentsListPage extends StatefulWidget {
  const PresentsListPage({
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
  State<PresentsListPage> createState() => _PresentsListPageState();
}

class _PresentsListPageState extends State<PresentsListPage> {
  @override
  void initState() {
    Future.microtask(() async {
      final PresentsListViewModel viewModel =
          context.read<PresentsListViewModel>();
      widget.resetNavigation(await viewModel.getBadgeCount());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<PresentsListViewModel>();
    final state = viewModel.state;
    var yearCount = DateTime.now().year - widget.birthYear;
    if (DateTime.now().year == widget.birthYear) {
      yearCount = 1;
    }
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
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  'assets/images/background.jpg',
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xFFFFF9C4).withOpacity(0.9),
                  const Color(0xFFFFF9C4).withOpacity(0.9),
                ],
              ),
            ),
          ),
          (state.isLoading)
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
                      state.linksList.isEmpty
                          ? Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text('EMPTY LIST'),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)))),
                                        onPressed: () {
                                          GoRouter.of(context)
                                              .go('/search_page', extra: {
                                            'resetNavigation':
                                                widget.resetNavigation,
                                            'hideNavBar': widget.hideNavBar,
                                            'docId': widget.docId,
                                            'name': widget.name,
                                            'birthYear': widget.birthYear
                                          });
                                        },
                                        child: const Text(
                                          'Go to search page',
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: ListView.builder(
                                        physics: const BouncingScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          return PresentListPageWidget(
                                            presentsListItem:
                                                state.linksList[index],
                                            resetNavigation:
                                                widget.resetNavigation,
                                          );
                                        },
                                        itemCount: state.linksList.length,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Row(
                                        children: [
                                          Expanded(child: Container()),
                                          Expanded(
                                            child: ElevatedButton(
                                              onPressed: () async {
                                                showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return OneAnswerDialog(
                                                          onTap: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          title:
                                                              '선택된 상품이 없습니다.',
                                                          subtitle:
                                                              '상품을 선택해 주세요',
                                                          firstButton: '확인',
                                                          imagePath:
                                                              'assets/gifs/alert.gif');
                                                    });
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      const Color(0xFF2F362F),
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          10)))),
                                              child: const Text(
                                                'COMPLETE',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              // style: ButtonStyle(
                                              //   backgroundColor: MaterialStateProperty.all(
                                              //     const Color(0xFF2F362F),
                                              //   ),
                                              // ),
                                            ),
                                          ),
                                          Expanded(child: Container()),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
