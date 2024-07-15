import 'package:Birthday_Presents_List/view/page/search_page/search_page_view_model.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/gif_progress_bar.dart';
import '../../widgets/rounded_image_button.dart';
import 'mall_link_list.dart';

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
  var linkController = TextEditingController();

  String? _errorLinkText;



  @override
  void dispose() {
    super.dispose();
    linkController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SearchPageViewModel>();
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
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: ClipRRect(
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(),
                      Center(
                        child: SizedBox(
                          width: 200 + 50.w,
                          height: 200 + 50.w,
                          child: GridView.count(
                              crossAxisCount: 2,
                              crossAxisSpacing: 16.0,
                              mainAxisSpacing: 16.0,
                              children: List.generate(4, (index) {
                                return RoundedImageButton(
                                  width: 100,
                                  height: 100,
                                  imagePath:
                                  'assets/images/${urls.keys.toList()[index]}.png',
                                  onTap: () async {
                                    await launchUrl(
                                        Uri.parse(urls.values.toList()[index]));
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
                            Expanded(flex: 1, child: Container()),
                            Expanded(
                              flex: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 8,
                                      child: Stack(
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: TextFormField(
                                                  controller:
                                                  linkController,
                                                  decoration:
                                                  InputDecoration(
                                                    hintStyle: const TextStyle(color: Colors.grey),
                                                    hintText:
                                                    'Fügen Sie den Link hier ein',
                                                    border:
                                                    OutlineInputBorder(
                                                      borderSide:
                                                      const BorderSide(
                                                        width: 0.1,
                                                        color: Colors.white,
                                                      ),
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(10),
                                                    ),
                                                    enabledBorder:
                                                    OutlineInputBorder(
                                                      borderSide:
                                                      BorderSide(
                                                        width: 2,
                                                        color: (_errorLinkText ==
                                                            null)
                                                            ? Colors.grey
                                                            : const Color(
                                                            0xFFba1a1a),
                                                      ),
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(10),
                                                    ),
                                                    focusedBorder:
                                                    OutlineInputBorder(
                                                      borderSide:
                                                      BorderSide(
                                                        width: 2,
                                                        color: (_errorLinkText ==
                                                            null)
                                                            ? const Color(
                                                            0xFF2F362F)
                                                            : const Color(
                                                            0xFFba1a1a),
                                                      ),
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(10),
                                                    ),
                                                  ),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _errorLinkText = (value
                                                          .isEmpty
                                                          ? 'Erforderlich'
                                                          : null);
                                                    });
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                          if (_errorLinkText != null)
                                            Positioned(
                                              top: 15,
                                              right: 5,
                                              child: Container(
                                                color: Colors.transparent,
                                                padding: const EdgeInsets
                                                    .symmetric(
                                                    horizontal: 4),
                                                child: Text(
                                                  _errorLinkText!,
                                                  style: const TextStyle(
                                                      color:
                                                      Color(0xFFba1a1a),
                                                      fontSize: 12),
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 5,),
                                    Expanded(
                                      flex: 2,
                                      child: OutlinedButton(
                                          style: OutlinedButton.styleFrom(
                                            shadowColor: Colors.black,
                                            elevation: 4,
                                            minimumSize: const Size(10, 55),
                                            side: const BorderSide(
                                                color: Colors.transparent,
                                                width: 0),
                                            backgroundColor:
                                            const Color(0xFF98FF98),
                                            shape:
                                            const RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.all(
                                                    Radius.circular(
                                                        10))),
                                          ),
                                          onPressed: () async {
                                            Map<String, dynamic> item = {
                                              'linkId': state.forBadgeList.length + 1,
                                              'isSelected': false,
                                              'mallLink':
                                              linkController.text
                                            };
                                            setState(() {
                                              _errorLinkText =
                                              (linkController
                                                  .text.isEmpty
                                                  ? 'Erforderlich'
                                                  : null);
                                              linkController.clear();
                                            });
                                            await viewModel
                                                .addToPresentsList(widget.docId,
                                                item, context);
                                            final newBadgeCount =
                                            await viewModel
                                                .getBadgeCount();
                                            widget.resetNavigation(
                                                newBadgeCount);
                                          },
                                          child: Center(
                                            child: (MediaQuery.of(context)
                                                .size
                                                .width >
                                                900)
                                                ? const Text(
                                              'ADD LIST',
                                              style: TextStyle(
                                                color:
                                                Color(0xFF3A405A),
                                              ),
                                            )
                                                : const Icon(size: 18,
                                              BootstrapIcons.plus_lg,
                                              color: Color(0xFF3A405A),
                                            ),
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(flex: 1, child: Container()),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
