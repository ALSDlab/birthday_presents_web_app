import 'package:daum_postcode_search/data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:myk_market_app/view/page/edit_user_info_page/change_password_dialog.dart';
import 'package:myk_market_app/view/page/edit_user_info_page/edit_user_info_view_model.dart';
import 'package:myk_market_app/view/page/signup_page/platform_check/check_file.dart'
    as check;
import 'package:myk_market_app/view/widgets/two_answer_dialog.dart';
import 'package:provider/provider.dart';

import '../../../data/model/user_model.dart';
import '../../../utils/gif_progress_bar.dart';
import '../../../utils/simple_logger.dart';
import '../../widgets/one_answer_dialog.dart';

class EditUserInfoPage extends StatefulWidget {
  const EditUserInfoPage({super.key, required this.hideNavBar});

  final bool Function(bool) hideNavBar;

  @override
  State<EditUserInfoPage> createState() => _EditUserInfoPageState();
}

class _EditUserInfoPageState extends State<EditUserInfoPage> {
  final _formKey = GlobalKey<FormState>();

  bool isValidPhoneNo = false;
  String servicePhoneNo = '01058377427';

  bool isChangedPassword = false;

  Map<int, dynamic> errorControllers = {
    0: null,
    1: null,
  };

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<EditUserInfoViewModel>();
    final state = viewModel.state;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF2F362F),
        scrolledUnderElevation: 0,
        title: const Text(
          '회원정보 수정',
          style: TextStyle(
              fontFamily: 'Jalnan', fontSize: 27, color: Colors.white),
        ),
        centerTitle: true,
      ),
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
                          Expanded(
                            child: ListView(
                              physics: const BouncingScrollPhysics(),
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 8, left: 8),
                                  child: Column(
                                    children: [
                                      const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '회원 정보',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w900,
                                                fontSize: 18),
                                          ),
                                          Text('* 표시된 항목은 필수 입력돼야 합니다.'),
                                        ],
                                      ),
                                      const Divider(),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 5, left: 16.0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '아이디',
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 25,
                                                ),
                                                Text('비밀번호 ',
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                    )),
                                              ],
                                            ),
                                            Container(
                                              width: 70.w,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                    viewModel
                                                        .currentUser.first.id,
                                                    style: const TextStyle(
                                                      fontSize: 20,
                                                    )),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                OutlinedButton(
                                                  onPressed: (isChangedPassword)
                                                      ? () {}
                                                      : () async {
                                                          final newPassword =
                                                              await showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return const ChangePasswordPage();
                                                                  });
                                                          if (newPassword ==
                                                              null) {
                                                            // 비밀번호를 변경하지 않고 취소함
                                                            const Widget
                                                                content = Text(
                                                                    '비밀번호가 재설정되지 않았습니다.');
                                                            viewModel
                                                                .showSnackbar(
                                                                    context,
                                                                    content);
                                                          } else {
                                                            if (context
                                                                .mounted) {
                                                              setState(() {
                                                                isChangedPassword =
                                                                    !isChangedPassword;
                                                              });
                                                              showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return OneAnswerDialog(
                                                                        onTap:
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                        title:
                                                                            '비밀번호가 변경되었습니다.',
                                                                        firstButton:
                                                                            '확인',
                                                                        imagePath:
                                                                            'assets/gifs/success.gif');
                                                                  });
                                                            }
                                                          }
                                                        },
                                                  style: OutlinedButton.styleFrom(
                                                      backgroundColor:
                                                          (isChangedPassword)
                                                              ? Colors.grey
                                                              : const Color(
                                                                  0xFF2F362F),
                                                      shape: const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          10)))),
                                                  child: (isChangedPassword)
                                                      ? const Icon(
                                                          Icons.check,
                                                          color: Colors.white,
                                                        )
                                                      : const Text(
                                                          '변경하기',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                ),
                                              ],
                                            ),
                                            Container(),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 8, bottom: 8),
                                  child: Container(
                                    margin: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20.0),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.3),
                                          spreadRadius: 2,
                                          blurRadius: 3,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    padding: const EdgeInsets.all(3),
                                    child: Form(
                                      key: _formKey,
                                      child: ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: 5,
                                        padding: const EdgeInsets.all(8.0),
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: (index == 2)
                                                ? const EdgeInsets.fromLTRB(
                                                    4, 4, 4, 0)
                                                : const EdgeInsets.all(4.0),
                                            child: Column(
                                              children: [
                                                (index == 3)
                                                    ? const SizedBox(
                                                        height: 0.5,
                                                      )
                                                    : Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            (index != 4)
                                                                ? '* '
                                                                : '  ',
                                                            style:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .red),
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                              viewModel
                                                                      .gridLeftArray[
                                                                  index],
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize: 15),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                index == 2
                                                    ? Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Expanded(
                                                            flex: 1,
                                                            child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        right:
                                                                            16.0),
                                                                child:
                                                                    OutlinedButton(
                                                                  style: OutlinedButton.styleFrom(
                                                                      // shape: const RoundedRectangleBorder(
                                                                      //     borderRadius: BorderRadius.zero),
                                                                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                                                      backgroundColor: const Color(0xFF2F362F)),
                                                                  onPressed:
                                                                      () async {
                                                                    try {
                                                                      viewModel
                                                                          .addressChangeRequest();
                                                                      dynamic
                                                                          model =
                                                                          await Navigator.of(context)
                                                                              .push(
                                                                        MaterialPageRoute(
                                                                            builder: (context) =>
                                                                                check.pr),
                                                                      );
                                                                      if (model
                                                                          is DataModel) {
                                                                        viewModel.setAddress(
                                                                            model.zonecode,
                                                                            model.address);
                                                                      } else if (model is Map<
                                                                          String,
                                                                          String>) {
                                                                        viewModel.setAddress(
                                                                            model['postcode']!,
                                                                            model['address']!);
                                                                      }
                                                                      viewModel
                                                                          .fillTextField();
                                                                    } catch (error) {
                                                                      logger.info(
                                                                          error);
                                                                    }
                                                                  },
                                                                  child:
                                                                      const Text(
                                                                    '주소검색',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                )),
                                                          ),
                                                          Expanded(
                                                            flex: 2,
                                                            child:
                                                                TextFormField(
                                                              readOnly: true,
                                                              style:
                                                                  const TextStyle(
                                                                      fontSize:
                                                                          15),
                                                              decoration:
                                                                  InputDecoration(
                                                                contentPadding:
                                                                    const EdgeInsets
                                                                        .fromLTRB(
                                                                        10,
                                                                        5,
                                                                        0,
                                                                        5),
                                                                border:
                                                                    OutlineInputBorder(
                                                                  borderSide:
                                                                      const BorderSide(
                                                                    width: 0.1,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                ),
                                                                enabledBorder:
                                                                    OutlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                    width: 2,
                                                                    color: (errorControllers[index] ==
                                                                            null)
                                                                        ? Colors
                                                                            .grey
                                                                        : const Color(
                                                                            0xFFba1a1a),
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                ),
                                                                focusedBorder:
                                                                    OutlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                    width: 2,
                                                                    color: (errorControllers[index] ==
                                                                            null)
                                                                        ? const Color(
                                                                            0xFF2F362F)
                                                                        : const Color(
                                                                            0xFFba1a1a),
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                ),
                                                              ),
                                                              controller: viewModel
                                                                      .controllers[
                                                                  viewModel
                                                                          .textField[
                                                                      index]],
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    : Stack(
                                                        children: [
                                                          TextFormField(
                                                            readOnly:
                                                                (index == 3)
                                                                    ? true
                                                                    : false,
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        15),
                                                            decoration:
                                                                InputDecoration(
                                                              contentPadding:
                                                                  const EdgeInsets
                                                                      .fromLTRB(
                                                                      10,
                                                                      5,
                                                                      0,
                                                                      5),
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    const BorderSide(
                                                                  width: 0.1,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                              ),
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  width: 2,
                                                                  color: (errorControllers[
                                                                              index] ==
                                                                          null)
                                                                      ? Colors
                                                                          .grey
                                                                      : const Color(
                                                                          0xFFba1a1a),
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                              ),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  width: 2,
                                                                  color: (errorControllers[
                                                                              index] ==
                                                                          null)
                                                                      ? const Color(
                                                                          0xFF2F362F)
                                                                      : const Color(
                                                                          0xFFba1a1a),
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                              ),
                                                            ),
                                                            onChanged: (value) {
                                                              setState(() {
                                                                errorControllers[
                                                                        index] =
                                                                    (value == ''
                                                                        ? '필수항목입니다.'
                                                                        : null);
                                                              });
                                                            },
                                                            controller: viewModel
                                                                    .controllers[
                                                                viewModel
                                                                        .textField[
                                                                    index]],
                                                          ),
                                                          if (errorControllers[
                                                                  index] !=
                                                              null)
                                                            Positioned(
                                                              top: 15,
                                                              right: 15,
                                                              child: Container(
                                                                color: Colors
                                                                    .white,
                                                                padding: const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        4),
                                                                child: Text(
                                                                  errorControllers[
                                                                      index],
                                                                  style: const TextStyle(
                                                                      color: Color(
                                                                          0xFFba1a1a),
                                                                      fontSize:
                                                                          12),
                                                                ),
                                                              ),
                                                            ),
                                                        ],
                                                      ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(child: Container()),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                      ),
                                      onPressed: () {
                                        GoRouter.of(context).pop(true);
                                      },
                                      child: const Text(
                                        '이전',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                          // shape: const RoundedRectangleBorder(
                                          //     borderRadius: BorderRadius.zero),
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                          backgroundColor:
                                              const Color(0xFF2F362F)),
                                      onPressed: () async {
                                        setState(() {
                                          errorControllers[0] = (viewModel
                                                      .controllers['name']
                                                      ?.text ==
                                                  ''
                                              ? '필수항목입니다.'
                                              : null);
                                          errorControllers[1] = (viewModel
                                                      .controllers['phone']
                                                      ?.text ==
                                                  ''
                                              ? '필수항목입니다.'
                                              : null);
                                        });
                                        if (viewModel
                                                .controllers['name']?.text ==
                                            '') {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return OneAnswerDialog(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                  title: '알림',
                                                  subtitle: '이름을 입력해 주세요.',
                                                  firstButton: '확인',
                                                  imagePath:
                                                      'assets/gifs/fail.gif');
                                            },
                                          );
                                        } else if (viewModel
                                                .controllers['phone']?.text ==
                                            '') {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return OneAnswerDialog(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                  title: '알림',
                                                  subtitle: '휴대폰 번호를 입력해 주세요.',
                                                  firstButton: '확인',
                                                  imagePath:
                                                      'assets/gifs/fail.gif');
                                            },
                                          );
                                        } else if (viewModel
                                                .controllers['postcode']
                                                ?.text ==
                                            '') {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return OneAnswerDialog(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                title: '주소를 검색해 주세요.',
                                                firstButton: '확인',
                                                imagePath:
                                                    'assets/gifs/fail.gif',
                                              );
                                            },
                                          );
                                        } else {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            // _formKey.currentState?.save();
                                            // 정보변경여부 확인
                                            if (viewModel.checkUpdated()) {
                                              final UserModel updatedUserInfo = UserModel(
                                                  name: viewModel
                                                      .controllers['name']!
                                                      .text,
                                                  id: viewModel
                                                      .currentUser.first.id,
                                                  postcode: viewModel
                                                      .controllers['postcode']!
                                                      .text,
                                                  phone: viewModel
                                                      .controllers['phone']!
                                                      .text,
                                                  address: viewModel
                                                      .controllers['address']!
                                                      .text,
                                                  addressDetail: viewModel
                                                      .controllers[
                                                          'addressDetail']!
                                                      .text,
                                                  checked: viewModel.currentUser
                                                      .first.checked,
                                                  created: viewModel.currentUser
                                                      .first.created,
                                                  recreatCount: viewModel
                                                      .currentUser
                                                      .first
                                                      .recreatCount,
                                                  profileImage: viewModel
                                                      .currentUser
                                                      .first
                                                      .profileImage,
                                                  coupons: viewModel.currentUser
                                                      .first.coupons,
                                                  verificationLimit: viewModel
                                                      .currentUser
                                                      .first
                                                      .verificationLimit);
                                              await viewModel.updateUserInfo(
                                                  updatedUserInfo);
                                              if (context.mounted) {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return OneAnswerDialog(
                                                        onTap: () {
                                                          Navigator.pop(
                                                              context);
                                                          GoRouter.of(context).go(
                                                              '/profile_page',
                                                              extra: {
                                                                'hideNavBar':
                                                                    widget
                                                                        .hideNavBar
                                                              });
                                                        },
                                                        title: '정보가 변경되었습니다.',
                                                        subtitle:
                                                            '마이페이지로 돌아갑니다.',
                                                        firstButton: '확인',
                                                        imagePath:
                                                            'assets/gifs/success.gif');
                                                  },
                                                );
                                              }
                                            } else {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return TwoAnswerDialog(
                                                      title: '변경된 정보가 없습니다.',
                                                      subtitle:
                                                          '마이페이지로 돌아가시겠습니까?',
                                                      firstButton: '아니오',
                                                      secondButton: '예',
                                                      imagePath:
                                                          'assets/gifs/two_answer_dialog.gif',
                                                      onFirstTap: () {
                                                        Navigator.pop(context);
                                                      },
                                                      onSecondTap: () {
                                                        Navigator.pop(context);
                                                        GoRouter.of(context).go(
                                                            '/profile_page',
                                                            extra: {
                                                              'hideNavBar':
                                                                  widget
                                                                      .hideNavBar
                                                            });
                                                      },
                                                    );
                                                  });
                                            }
                                          }
                                        }
                                      },
                                      child: const Text(
                                        '변경',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(child: Container()),
                              ],
                            ),
                          )
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
