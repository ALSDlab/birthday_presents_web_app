import 'package:Birthday_Presents_List/domain/model/presents_list_model.dart';
import 'package:Birthday_Presents_List/view/page/presents_list_page/presents_list_page_widget.dart';
import 'package:Birthday_Presents_List/view/page/presents_list_page/presents_list_view_model.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/gif_progress_bar.dart';
import '../../widgets/two_answer_dialog.dart';
import '../navigation_page/globals.dart';

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
            GoRouter.of(context).go('/', extra: {
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
      body: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(32), topRight: Radius.circular(32)),
        child: Stack(
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text('EMPTY LIST'),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        OutlinedButton(
                                          style: OutlinedButton.styleFrom(
                                              shape:
                                                  const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10)))),
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
                                          physics:
                                              const BouncingScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            return Column(
                                              children: [
                                                PresentListPageWidget(
                                                  presentsListItem:
                                                      state.linksList[index],
                                                  resetNavigation:
                                                      widget.resetNavigation,
                                                  title:
                                                      state.thumbnailList[index]
                                                              ['title'] ??
                                                          state.linksList[index]
                                                              ['mallLink'],
                                                  imageUrl:
                                                      state.thumbnailList[index]
                                                              ['imageUrl'] ??
                                                          '',
                                                ),
                                                const Divider(),
                                              ],
                                            );
                                          },
                                          itemCount: state.linksList.length,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 3.0, top: 5.0, right: 3.0, bottom: 5.0),
                                        child: (state.isCompleted)
                                            ? Row(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  Expanded(child: Container()),
                                                  SelectableText(
                                                    Globals.rootUrl +
                                                        ((state.loadedDocId ==
                                                                '')
                                                            ? widget.docId
                                                            : state
                                                                .loadedDocId),
                                                    style: TextStyle(
                                                        fontSize: (MediaQuery.of(context)
                                                            .size
                                                            .width >
                                                            850) ? 20 : 16),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: () async {
                                                      await launchUrl(Uri.parse(Globals
                                                              .rootUrl +
                                                          ((state.loadedDocId ==
                                                                  '')
                                                              ? widget.docId
                                                              : state
                                                                  .loadedDocId)));
                                                    },
                                                    style: ElevatedButton.styleFrom(
                                                        backgroundColor:
                                                            const Color(
                                                                0xFF98FF98),
                                                        shape: const RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius.circular(
                                                                        10)))),
                                                    child: (MediaQuery.of(context)
                                                        .size
                                                        .width >
                                                        850) ? const Text(
                                                      'LINK',
                                                      style: TextStyle(
                                                          color: Color(
                                                              0xFF3A405A)),
                                                    ) : const Icon(size: 20,
                                                      BootstrapIcons.link,
                                                      color: Color(0xFF3A405A),
                                                    ),
                                                    // style: ButtonStyle(
                                                    //   backgroundColor: MaterialStateProperty.all(
                                                    //     const Color(0xFF2F362F),
                                                    //   ),
                                                    // ),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      showDialog(
                                                          context: context,
                                                          builder: (context) =>
                                                              TwoAnswerDialog(
                                                                title:
                                                                    'Edit your list',
                                                                firstButton:
                                                                    'YES',
                                                                secondButton:
                                                                    'NO',
                                                                imagePath:
                                                                    'assets/gifs/two_answer_dialog.gif',
                                                                onFirstTap: () {
                                                                  viewModel.editCompletedList(
                                                                      (state.loadedDocId ==
                                                                              '')
                                                                          ? widget
                                                                              .docId
                                                                          : state
                                                                              .loadedDocId,
                                                                      false);
                                                                  if (context
                                                                      .mounted) {
                                                                    Navigator.pop(
                                                                        context);
                                                                  }
                                                                },
                                                                onSecondTap:
                                                                    () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                              ));
                                                    },
                                                    style: ElevatedButton.styleFrom(
                                                        backgroundColor:
                                                            Colors.white,
                                                        shape: const RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius.circular(
                                                                        10)))),
                                                    child: (MediaQuery.of(context)
                                                        .size
                                                        .width >
                                                        850) ? const Text(
                                                      'EDIT',
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                    ) : const Icon(size: 20,
                                                      BootstrapIcons.eraser,
                                                      color: Color(0xFF3A405A),
                                                    ),
                                                    // style: ButtonStyle(
                                                    //   backgroundColor: MaterialStateProperty.all(
                                                    //     const Color(0xFF2F362F),
                                                    //   ),
                                                    // ),
                                                  ),
                                                  Expanded(child: Container()),
                                                ],
                                              )
                                            : Row(
                                                children: [
                                                  Expanded(child: Container()),
                                                  Expanded(
                                                    child: ElevatedButton(
                                                      onPressed: () async {
                                                        showDialog(
                                                            context: context,
                                                            builder: (context) =>
                                                                TwoAnswerDialog(
                                                                  title:
                                                                      'Complete my list',
                                                                  subtitle:
                                                                      'Create the link for list',
                                                                  firstButton:
                                                                      'YES',
                                                                  secondButton:
                                                                      'NO',
                                                                  imagePath:
                                                                      'assets/gifs/two_answer_dialog.gif',
                                                                  onFirstTap:
                                                                      () async {
                                                                    Navigator.pop(
                                                                        context);
                                                                    // await viewModel
                                                                    //     .getSavedPresentsList();
                                                                    final PresentsListModel completedList = PresentsListModel(
                                                                        name: widget
                                                                            .name,
                                                                        birthYear:
                                                                            widget
                                                                                .birthYear,
                                                                        createdDate:
                                                                            DateFormat('yyyy.MM.dd_HH:mm:ss').format(DateTime
                                                                                .now()),
                                                                        completed:
                                                                            true,
                                                                        links: state
                                                                            .linksList);
                                                                    if (context
                                                                        .mounted) {
                                                                      await viewModel.postAndMakeListLink(
                                                                          (widget.docId != '')
                                                                              ? widget.docId
                                                                              : state.loadedDocId,
                                                                          completedList,
                                                                          context);
                                                                      Clipboard.setData(ClipboardData(
                                                                          text: Globals.rootUrl +
                                                                              ((state.loadedDocId == '') ? widget.docId : state.loadedDocId)));
                                                                    }
                                                                    // // Globals.docId 초기화
                                                                    // Globals.docId =
                                                                    //     '';
                                                                  },
                                                                  onSecondTap:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                ));
                                                      },
                                                      style: ElevatedButton.styleFrom(
                                                        minimumSize: Size(double.infinity, 60.h),
                                                          backgroundColor:
                                                              const Color(
                                                                  0xFF98FF98),
                                                          shape: const RoundedRectangleBorder(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          10)))),
                                                      child: (state.isPosting)
                                                          ? Center(
                                                              child:
                                                                  GifProgressBar(
                                                                radius: 15,
                                                              ),
                                                            )
                                                          : const Text(
                                                              'SAVE',
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0xFF3A405A)),
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
      ),
    );
  }
}
