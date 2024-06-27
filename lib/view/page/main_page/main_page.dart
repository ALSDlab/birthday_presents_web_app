import 'package:Birthday_Presents_List/view/widgets/one_answer_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/two_answer_dialog.dart';
import '../navigation_page/navigation_page_view_model.dart';

class MainPage extends StatefulWidget {
  const MainPage(
      {super.key, required this.hideNavBar, required this.resetNavigation});

  final bool Function(int) resetNavigation;
  final bool Function(bool) hideNavBar;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var nameController = TextEditingController();
  var birthYearController = TextEditingController();

  String? _errorNameText;
  String? _errorBirthYearText;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Your code that may trigger notifyListeners()
      widget.hideNavBar(true);
    });
    load('name', nameController);
    load('birthYear', birthYearController);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    birthYearController.dispose();
  }

  Future save(String saveKey, TextEditingController controller) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(saveKey, controller.text);
  }

  Future load(String saveKey, TextEditingController controller) async {
    final prefs = await SharedPreferences.getInstance();
    final String? keyValue = prefs.getString(saveKey);

    if (keyValue != null) {
      controller.text = keyValue;
      // print('국문주소: $address');
      // print(Uri.encodeFull(address));
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<NavigationPageViewModel>();

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                      flex: (MediaQuery.of(context).size.width > 900)
                          ? 2
                          : (2450 -
                              (MediaQuery.of(context).size.width / 2).round()),
                      child: Container()),
                  Expanded(
                    flex: (MediaQuery.of(context).size.width > 900)
                        ? 4
                        : (3100 + MediaQuery.of(context).size.width.round()),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: (MediaQuery.of(context).size.width > 900)
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                        flex: 2,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            const Text(
                                              'NAME',
                                              style: TextStyle(fontSize: 18),
                                            ),
                                            SizedBox(
                                              height: 60.h,
                                            ),
                                            const Text(
                                              'GEBURTSYAHR',
                                              style: TextStyle(fontSize: 18),
                                            ),
                                          ],
                                        )),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      flex: 4,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Stack(
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: TextFormField(
                                                      controller:
                                                          nameController,
                                                      decoration:
                                                          InputDecoration(
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
                                                            color: (_errorNameText ==
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
                                                            color: (_errorNameText ==
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
                                                          _errorNameText = (value
                                                                  .isEmpty
                                                              ? 'Erforderlich'
                                                              : null);
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              if (_errorNameText != null)
                                                Positioned(
                                                  top: 15,
                                                  right: 5,
                                                  child: Container(
                                                    color: Colors.transparent,
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 4),
                                                    child: Text(
                                                      _errorNameText!,
                                                      style: const TextStyle(
                                                          color:
                                                              Color(0xFFba1a1a),
                                                          fontSize: 12),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 40.h,
                                          ),
                                          Stack(
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: TextFormField(
                                                      inputFormatters: [
                                                        FilteringTextInputFormatter
                                                            .digitsOnly,
                                                        LengthLimitingTextInputFormatter(
                                                            4),
                                                      ],
                                                      keyboardType:
                                                          TextInputType.number,
                                                      controller:
                                                          birthYearController,
                                                      decoration:
                                                          InputDecoration(
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
                                                            color: (_errorBirthYearText ==
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
                                                            color: (_errorBirthYearText ==
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
                                                          _errorBirthYearText =
                                                              (value.isEmpty
                                                                  ? 'Erforderlich'
                                                                  : null);
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              if (_errorBirthYearText != null)
                                                Positioned(
                                                  top: 15,
                                                  right: 5,
                                                  child: Container(
                                                    color: Colors.transparent,
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 4),
                                                    child: Text(
                                                      _errorBirthYearText!,
                                                      style: const TextStyle(
                                                          color:
                                                              Color(0xFFba1a1a),
                                                          fontSize: 12),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'NAME',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Stack(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: TextFormField(
                                                controller: nameController,
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                      width: 0.1,
                                                      color: Colors.white,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      width: 2,
                                                      color: (_errorNameText ==
                                                              null)
                                                          ? Colors.grey
                                                          : const Color(
                                                              0xFFba1a1a),
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      width: 2,
                                                      color: (_errorNameText ==
                                                              null)
                                                          ? const Color(
                                                              0xFF2F362F)
                                                          : const Color(
                                                              0xFFba1a1a),
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                ),
                                                onChanged: (value) {
                                                  setState(() {
                                                    _errorNameText =
                                                        (value.isEmpty
                                                            ? 'Erforderlich'
                                                            : null);
                                                  });
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        if (_errorNameText != null)
                                          Positioned(
                                            top: 15,
                                            right: 5,
                                            child: Container(
                                              color: Colors.transparent,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 4),
                                              child: Text(
                                                _errorNameText!,
                                                style: const TextStyle(
                                                    color: Color(0xFFba1a1a),
                                                    fontSize: 12),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 40.h,
                                    ),
                                    const Text(
                                      'GEBURTSYAHR',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Stack(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: TextFormField(
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .digitsOnly,
                                                  LengthLimitingTextInputFormatter(
                                                      4),
                                                ],
                                                keyboardType:
                                                    TextInputType.number,
                                                controller: birthYearController,
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                      width: 0.1,
                                                      color: Colors.white,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      width: 2,
                                                      color:
                                                          (_errorBirthYearText ==
                                                                  null)
                                                              ? Colors.grey
                                                              : const Color(
                                                                  0xFFba1a1a),
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      width: 2,
                                                      color:
                                                          (_errorBirthYearText ==
                                                                  null)
                                                              ? const Color(
                                                                  0xFF2F362F)
                                                              : const Color(
                                                                  0xFFba1a1a),
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                ),
                                                onChanged: (value) {
                                                  setState(() {
                                                    _errorBirthYearText =
                                                        (value.isEmpty
                                                            ? 'Erforderlich'
                                                            : null);
                                                  });
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        if (_errorBirthYearText != null)
                                          Positioned(
                                            top: 15,
                                            right: 5,
                                            child: Container(
                                              color: Colors.transparent,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 4),
                                              child: Text(
                                                _errorBirthYearText!,
                                                style: const TextStyle(
                                                    color: Color(0xFFba1a1a),
                                                    fontSize: 12),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                        ),
                        SizedBox(
                          height: 7.h,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextButton(
                                style: ButtonStyle(
                                  shadowColor:
                                      MaterialStateProperty.all(Colors.black),
                                  elevation: MaterialStateProperty.all(4),
                                  minimumSize: MaterialStateProperty.all(
                                    Size(double.infinity, 100.h),
                                  ),
                                  shape: const MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                  ),
                                  backgroundColor:
                                      const MaterialStatePropertyAll(
                                    Colors.white,
                                  ),
                                ),
                                onPressed: () async {
                                  setState(() {
                                    _errorNameText =
                                        (nameController.text.isEmpty
                                            ? 'Erforderlich'
                                            : null);
                                    _errorBirthYearText = (birthYearController
                                            .text.isEmpty
                                        ? 'Erforderlich'
                                        : (int.parse(birthYearController.text) <
                                                    1900 ||
                                                int.parse(birthYearController
                                                        .text) >
                                                    DateTime.now().year)
                                            ? 'Falsch'
                                            : null);
                                  });
                                  if (_errorNameText == null &&
                                      _errorBirthYearText == null) {
                                    save('name', nameController);
                                    save('birthYear', birthYearController);
                                    viewModel.setNameAndBirthYear(
                                        nameController.text,
                                        int.parse(birthYearController.text));
                                    viewModel.generateDocId();
                                    showDialog(
                                        context: context,
                                        builder: (context) => TwoAnswerDialog(
                                              title: 'Create New List?',
                                              subtitle: 'Deleted Saved Data',
                                              firstButton: 'NO',
                                              secondButton: 'YES',
                                              imagePath:
                                                  'assets/gifs/two_answer_dialog.gif',
                                              onFirstTap: () {
                                                Navigator.pop(context);
                                              },
                                              onSecondTap: () async {
                                                final prefs =
                                                    await SharedPreferences
                                                        .getInstance();
                                                await prefs
                                                    .remove('presentsList');
                                                widget
                                                    .resetNavigation(0);
                                                if (context.mounted) {
                                                  Navigator.pop(context);
                                                  GoRouter.of(context).go(
                                                      '/search_page',
                                                      extra: {
                                                        'resetNavigation': widget
                                                            .resetNavigation,
                                                        'hideNavBar': widget
                                                            .hideNavBar(false),
                                                        'docId':
                                                            NavigationPageViewModel
                                                                .docId,
                                                        'name':
                                                            nameController.text,
                                                        'birthYear': int.parse(
                                                            birthYearController
                                                                .text)
                                                      });
                                                }
                                              },
                                            ));
                                  }
                                },
                                child: const Text(
                                  'NEW LIST',
                                  style: TextStyle(
                                      color: Color(0xFF3A405A), fontSize: 16),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 7,
                            ),
                            Expanded(
                              child: TextButton(
                                style: ButtonStyle(
                                  shadowColor:
                                      MaterialStateProperty.all(Colors.black),
                                  elevation: MaterialStateProperty.all(4),
                                  minimumSize: MaterialStateProperty.all(
                                    Size(double.infinity, 100.h),
                                  ),
                                  shape: const MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                  ),
                                  backgroundColor:
                                      const MaterialStatePropertyAll(
                                    Color(0xFF98FF98),
                                  ),
                                ),
                                onPressed: () async {
                                  setState(() {
                                    _errorNameText =
                                        (nameController.text.isEmpty
                                            ? 'Erforderlich'
                                            : null);
                                    _errorBirthYearText = (birthYearController
                                            .text.isEmpty
                                        ? 'Erforderlich'
                                        : (int.parse(birthYearController.text) <
                                                    1900 ||
                                                int.parse(birthYearController
                                                        .text) >
                                                    DateTime.now().year)
                                            ? 'Falsch'
                                            : null);
                                  });
                                  if (_errorNameText == null &&
                                      _errorBirthYearText == null) {
                                    final prefs =
                                        await SharedPreferences.getInstance();

                                    if (prefs.getString('presentsList') ==
                                        null) {
                                      if (context.mounted) {
                                        showDialog(
                                            context: context,
                                            builder: (context) =>
                                                OneAnswerDialog(
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                    },
                                                    title: 'No saved data',
                                                    // subtitle: '신호없음',
                                                    firstButton: 'OK',
                                                    imagePath:
                                                        'assets/gifs/alert.gif'));
                                      }
                                    } else {
                                      save('name', nameController);
                                      save('birthYear', birthYearController);
                                      viewModel.setNameAndBirthYear(
                                          nameController.text,
                                          int.parse(birthYearController.text));
                                      if (context.mounted) {
                                        GoRouter.of(context)
                                            .go('/presents_list_page', extra: {
                                          'resetNavigation':
                                              widget.resetNavigation,
                                          'hideNavBar':
                                              widget.hideNavBar(false),
                                          'docId':
                                              NavigationPageViewModel.docId,
                                          'name': nameController.text,
                                          'birthYear': int.parse(
                                              birthYearController.text)
                                        });
                                      }
                                    }
                                  }
                                },
                                child: const Text(
                                  'LOAD LIST',
                                  style: TextStyle(
                                      color: Color(0xFF3A405A), fontSize: 16),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(),
                      ],
                    ),
                  ),
                  Expanded(
                      flex: (MediaQuery.of(context).size.width > 900)
                          ? 2
                          : (2450 -
                              (MediaQuery.of(context).size.width / 2).round()),
                      child: Container()),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    softWrap: true, //긴 텍스트 줄 바꿈
                    style: TextStyle(
                        letterSpacing: 1.1,
                        height: 1.4,
                        fontFamily: 'Kopub',
                        color: Colors.grey),
                    "Ver.| 0.0.1\nDeveloper| ALSDlab(RAON's dad)\nLocation| Kronberg",
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                      softWrap: true, //긴 텍스트 줄 바꿈
                      style: TextStyle(
                          fontSize: 10,
                          letterSpacing: 1.1,
                          height: 1.4,
                          fontFamily: 'Kopub',
                          color: Colors.grey),
                      'Copyright 2024. ALSDlab All rights reserved.'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
