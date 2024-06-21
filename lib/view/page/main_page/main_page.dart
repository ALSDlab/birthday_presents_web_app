import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

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
  final _formKey = GlobalKey<FormState>();

  var nameController = TextEditingController();
  var birthYearController = TextEditingController();

  String? _errorNameText;
  String? _errorBirthYearText;

  @override
  void initState() {
    widget.hideNavBar(true);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    birthYearController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<NavigationPageViewModel>();

    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Stack(
                    children: [
                      Row(
                        children: [
                          const Text(
                            'NAME',
                            style: TextStyle(fontSize: 18),
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: nameController,
                              decoration: InputDecoration(
                                hintText: 'NAME',
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    width: 0.1,
                                    color: Colors.white,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: (_errorNameText == null)
                                        ? Colors.grey
                                        : const Color(0xFFba1a1a),
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: (_errorNameText == null)
                                        ? const Color(0xFF2F362F)
                                        : const Color(0xFFba1a1a),
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  _errorNameText =
                                      (value.isEmpty ? '필수항목입니다.' : null);
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      if (_errorNameText != null)
                        Positioned(
                          top: 19,
                          right: 15,
                          child: Container(
                            color: Colors.transparent,
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Text(
                              _errorNameText!,
                              style: const TextStyle(
                                  color: Color(0xFFba1a1a), fontSize: 12),
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Stack(
                    children: [
                      Row(
                        children: [
                          const Text(
                            'GEBURTSYAHR',
                            style: TextStyle(fontSize: 18),
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: birthYearController,
                              decoration: InputDecoration(
                                hintText: 'GEBURTSYAHR',
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    width: 0.1,
                                    color: Colors.white,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: (_errorBirthYearText == null)
                                        ? Colors.grey
                                        : const Color(0xFFba1a1a),
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: (_errorBirthYearText == null)
                                        ? const Color(0xFF2F362F)
                                        : const Color(0xFFba1a1a),
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  _errorBirthYearText =
                                      (value.isEmpty ? '필수항목입니다.' : null);
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      if (_errorBirthYearText != null)
                        Positioned(
                          top: 19,
                          right: 15,
                          child: Container(
                            color: Colors.transparent,
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Text(
                              _errorBirthYearText!,
                              style: const TextStyle(
                                  color: Color(0xFFba1a1a), fontSize: 12),
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            TextButton(
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(
                  Size(double.infinity, 52.h),
                ),
                shape: const MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
                backgroundColor:
                    const MaterialStatePropertyAll(Color(0xFF008080)),
              ),
              onPressed: () async {
                setState(() {
                  _errorNameText =
                      (nameController.text.isEmpty ? '필수항목입니다.' : null);
                  _errorBirthYearText =
                      (birthYearController.text.isEmpty ? '필수항목입니다.' : null);
                });
                if (_formKey.currentState!.validate()) {
                  viewModel.setNameAndBirthYear(
                      nameController.text, int.parse(birthYearController.text));
                  viewModel.generateDocId();
                  GoRouter.of(context).go('/search_page', extra: {
                    'navSetState': widget.resetNavigation,
                    'hideNavBar': widget.hideNavBar,
                    'docId': viewModel.docId,
                    'name': nameController.text,
                    'birthYear': int.parse(birthYearController.text)
                  });
                }
              },
              child: const Text(
                'START',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
