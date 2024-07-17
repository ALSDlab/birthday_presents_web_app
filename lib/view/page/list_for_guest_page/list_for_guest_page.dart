import 'package:Birthday_Presents_List/view/page/list_for_guest_page/list_for_guest_page_view_model.dart';
import 'package:Birthday_Presents_List/view/page/list_for_guest_page/list_for_guest_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/gif_progress_bar.dart';
import '../../widgets/one_answer_dialog.dart';
import '../../widgets/two_answer_dialog.dart';

class ListForGuestPage extends StatefulWidget {
  final String docId;

  const ListForGuestPage({
    super.key,
    required this.docId,
  });

  @override
  State<ListForGuestPage> createState() => _ListForGuestPageState();
}

class _ListForGuestPageState extends State<ListForGuestPage> {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ListForGuestPageViewModel>();
    final state = viewModel.state;
    var yearCount = DateTime.now().year - state.getBirthYear;
    if (DateTime.now().year == state.getBirthYear) {
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
        backgroundColor: const Color(0xFFAEC6CF),
        title: Text(
          "${state.getName}'s $yearCount$countEnding BIRTHDAY!!",
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
                            ? const Expanded(
                                child: Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Center(
                                    child: Text('EMPTY LIST'),
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
                                                ListForGuestPageWidget(
                                                  presentsListItem:
                                                      state.linksList[index],
                                                  updateListItem: state
                                                      .updatedLinksList[index],
                                                  index: index,
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
                                          itemCount:
                                              state.updatedLinksList.length,
                                        ),
                                      ),

                                      //TODO: 다른 링크 추가 기능 넣기(다음버전)
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Row(
                                          children: [
                                            Expanded(child: Container()),
                                            Expanded(
                                              child: ElevatedButton(
                                                onPressed: () async {
                                                  if (state.linksList
                                                          .where((element) =>
                                                              element[
                                                                  'isSelected'] ==
                                                              true)
                                                          .length ==
                                                      state.updatedLinksList
                                                          .where((element) =>
                                                              element[
                                                                  'isSelected'] ==
                                                              true)
                                                          .length) {
                                                    showDialog(
                                                        context: context,
                                                        builder: (context) =>
                                                            OneAnswerDialog(
                                                                onTap: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                title:
                                                                    'No selected present',
                                                                // subtitle: '신호없음',
                                                                firstButton:
                                                                    'OK',
                                                                imagePath:
                                                                    'assets/gifs/alert.gif'));
                                                  } else {
                                                    showDialog(
                                                        context: context,
                                                        builder: (context) =>
                                                            TwoAnswerDialog(
                                                              title:
                                                                  'Did you select the present?',
                                                              firstButton:
                                                                  'YES',
                                                              secondButton:
                                                                  'NO',
                                                              imagePath:
                                                                  'assets/gifs/two_answer_dialog.gif',
                                                              onFirstTap:
                                                                  () async {
                                                                await viewModel
                                                                    .postSelectionToFirebase(
                                                                        state
                                                                            .getDocId,
                                                                        state
                                                                            .updatedLinksList,
                                                                        context);
                                                                await viewModel
                                                                    .getBadgeCount();
                                                                if (context
                                                                    .mounted) {
                                                                  Navigator.pop(
                                                                      context);
                                                                }
                                                              },
                                                              onSecondTap: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                            ));
                                                  }
                                                },
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        const Color(0xFF98FF98),
                                                    shape: const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10)))),
                                                child: const Text(
                                                  'SELECT',
                                                  style: TextStyle(
                                                      color: Color(0xFF3A405A)),
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
