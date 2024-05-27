import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:myk_market_app/utils/gif_progress_bar.dart';
import 'package:myk_market_app/view/page/find_id_password_page/find_id_password_page_view_model.dart';
import 'package:myk_market_app/view/page/find_id_password_page/reset_password_dialog.dart';
import 'package:myk_market_app/view/widgets/one_answer_dialog.dart';
import 'package:provider/provider.dart';

import '../../../utils/simple_logger.dart';
import '../cellphone_valid_page/cellphone_valid_dialog.dart';

class FindIdPasswordPage extends StatefulWidget {
  const FindIdPasswordPage({super.key, required this.hideNavBar});

  final bool Function(bool) hideNavBar;

  @override
  State<FindIdPasswordPage> createState() => _FindIdPasswordPageState();
}

class _FindIdPasswordPageState extends State<FindIdPasswordPage> {
  final _phoneForIdController = TextEditingController();
  final _nameController = TextEditingController();
  final _idController = TextEditingController();
  final _phoneForPasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();

  bool isValidPhoneNo = false;
  String servicePhoneNo = '01058377427';
  String? _errorNameText;
  String? _errorPhoneForIdText;
  String? _errorIdText;
  String? _errorPhoneForPasswordText;

  @override
  void dispose() {
    _phoneForIdController.dispose();
    _nameController.dispose();
    _idController.dispose();
    _phoneForPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<FindIdPasswordViewModel>();
    final state = viewModel.state;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2F362F),
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
        ),
        title: const Text(
          '마이페이지',
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
              child: Padding(
                padding: EdgeInsets.only(
                    top: 5.0,
                    left: 5.0,
                    right: 5.0,
                    bottom: state.showSnackbarPadding
                        ? MediaQuery.of(context).padding.bottom + 48.0
                        : 0), // Snackbar 높이만큼 padding 추가
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 8, left: 8, right: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '아이디 / 비밀번호 찾기',
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                    Expanded(
                      child: ListView(
                        physics: const BouncingScrollPhysics(),
                        children: [
                          ListView(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            children: [
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
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                '아이디 찾기',
                                                style: TextStyle(fontSize: 18),
                                              ),
                                            ],
                                          ),
                                          const Divider(),
                                          Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Stack(
                                              children: [
                                                TextFormField(
                                                  controller: _nameController,
                                                  style: const TextStyle(
                                                      fontSize: 15),
                                                  decoration: InputDecoration(
                                                    hintText: '이름',
                                                    contentPadding:
                                                        const EdgeInsets
                                                            .fromLTRB(
                                                            10, 5, 0, 5),
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
                                                            (_errorNameText ==
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
                                                            (_errorNameText ==
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
                                                              ? '필수항목입니다.'
                                                              : null);
                                                    });
                                                  },
                                                  // validator: (value) {
                                                  //   if (value == null || value.isEmpty) {
                                                  //     return '필수항목입니다.';
                                                  //   }
                                                  //   return null;
                                                  // },
                                                ),
                                                if (_errorNameText != null)
                                                  Positioned(
                                                    top: 15,
                                                    right: 15,
                                                    child: Container(
                                                      color: Colors.white,
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 4),
                                                      child: Text(
                                                        _errorNameText!,
                                                        style: const TextStyle(
                                                            color: Color(
                                                                0xFFba1a1a),
                                                            fontSize: 12),
                                                      ),
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Stack(
                                              children: [
                                                TextFormField(
                                                  keyboardType:
                                                      TextInputType.number,
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .digitsOnly,
                                                    LengthLimitingTextInputFormatter(
                                                        12),
                                                  ],
                                                  controller:
                                                      _phoneForIdController,
                                                  style: const TextStyle(
                                                      fontSize: 15),
                                                  decoration: InputDecoration(
                                                    hintText:
                                                        '회원가입 시 등록한 휴대폰번호',
                                                    contentPadding:
                                                        const EdgeInsets
                                                            .fromLTRB(
                                                            10, 5, 0, 5),
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
                                                            (_errorPhoneForIdText ==
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
                                                            (_errorPhoneForIdText ==
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
                                                      _errorPhoneForIdText =
                                                          (value.isEmpty
                                                              ? '필수항목입니다.'
                                                              : null);
                                                    });
                                                  },
                                                  // validator: (value) {
                                                  //   if (value == null || value.isEmpty) {
                                                  //     return '필수항목입니다.';
                                                  //   }
                                                  //   return null;
                                                  // },
                                                ),
                                                if (_errorPhoneForIdText !=
                                                    null)
                                                  Positioned(
                                                    top: 15,
                                                    right: 15,
                                                    child: Container(
                                                      color: Colors.white,
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 4),
                                                      child: Text(
                                                        _errorPhoneForIdText!,
                                                        style: const TextStyle(
                                                            color: Color(
                                                                0xFFba1a1a),
                                                            fontSize: 12),
                                                      ),
                                                    ),
                                                  ),
                                              ],
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
                                                      setState(() {
                                                        _errorNameText =
                                                            (_nameController
                                                                    .text
                                                                    .isEmpty
                                                                ? '필수항목입니다.'
                                                                : null);
                                                        _errorPhoneForIdText =
                                                            (_phoneForIdController
                                                                    .text
                                                                    .isEmpty
                                                                ? '필수항목입니다.'
                                                                : null);
                                                      });
                                                      if (_errorNameText ==
                                                              null &&
                                                          _errorPhoneForIdText ==
                                                              null) {
                                                        String id = await viewModel
                                                            .findDocumentId(
                                                                _nameController
                                                                    .text,
                                                                _phoneForIdController
                                                                    .text);
                                                        setState(() {
                                                          _nameController
                                                              .clear();
                                                          _phoneForIdController
                                                              .clear();
                                                        });
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return OneAnswerDialog(
                                                              onTap: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              title: id != ''
                                                                  ? 'ID는 $id 입니다.'
                                                                  : '입력하신 정보로 아이디를 찾을 수 없습니다.',
                                                              subtitle: id != ''
                                                                  ? null
                                                                  : '다시 시도해 주시거나 회원가입을 해 주세요.',
                                                              firstButton: '확인',
                                                              imagePath: id !=
                                                                      ''
                                                                  ? 'assets/gifs/success.gif'
                                                                  : 'assets/gifs/fail.gif',
                                                            );
                                                          },
                                                        );
                                                      }
                                                    },

                                                    style: ElevatedButton.styleFrom(
                                                        backgroundColor:
                                                            const Color(
                                                                0xFF2F362F),
                                                        shape: const RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius.circular(
                                                                        10)))),
                                                    child: const Text(
                                                      '찾기',
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
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Divider(
                            indent: 50,
                            endIndent: 50,
                          ),
                          ListView(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            children: [
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
                                    key: _formKey2,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                '비밀번호 찾기',
                                                style: TextStyle(fontSize: 18),
                                              ),
                                            ],
                                          ),
                                          const Divider(),
                                          Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Stack(
                                              children: [
                                                TextFormField(
                                                  controller: _idController,
                                                  style: const TextStyle(
                                                      fontSize: 15),
                                                  decoration: InputDecoration(
                                                    hintText: '아이디',
                                                    contentPadding:
                                                        const EdgeInsets
                                                            .fromLTRB(
                                                            10, 5, 0, 5),
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
                                                        color: (_errorIdText ==
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
                                                        color: (_errorIdText ==
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
                                                      _errorIdText =
                                                          (value.isEmpty
                                                              ? '필수항목입니다.'
                                                              : null);
                                                    });
                                                  },
                                                  // validator: (value) {
                                                  //   if (value == null || value.isEmpty) {
                                                  //     return '필수항목입니다.';
                                                  //   }
                                                  //   return null;
                                                  // },
                                                ),
                                                if (_errorIdText != null)
                                                  Positioned(
                                                    top: 15,
                                                    right: 15,
                                                    child: Container(
                                                      color: Colors.white,
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 4),
                                                      child: Text(
                                                        _errorIdText!,
                                                        style: const TextStyle(
                                                            color: Color(
                                                                0xFFba1a1a),
                                                            fontSize: 12),
                                                      ),
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 16.0),
                                                      child: OutlinedButton(
                                                        style: OutlinedButton
                                                            .styleFrom(
                                                                // shape: const RoundedRectangleBorder(
                                                                //     borderRadius: BorderRadius.zero),
                                                                shape: const RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.all(Radius.circular(
                                                                            10))),
                                                                backgroundColor:
                                                                    const Color(
                                                                        0xFF2F362F)),
                                                        onPressed:
                                                            isValidPhoneNo
                                                                ? null
                                                                : () async {
                                                                    if (_phoneForPasswordController
                                                                        .text
                                                                        .isEmpty) {
                                                                      showDialog(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (context) {
                                                                          return OneAnswerDialog(
                                                                            onTap:
                                                                                () {
                                                                              Navigator.pop(context);
                                                                            },
                                                                            title:
                                                                                '휴대폰번호를 입력해 주세요.',
                                                                            firstButton:
                                                                                '확인',
                                                                            imagePath:
                                                                                'assets/gifs/fail.gif',
                                                                          );
                                                                        },
                                                                      );
                                                                    } else {
                                                                      try {
                                                                        // 아이디 확인
                                                                        final resultStatus =
                                                                            await viewModel.verifyInputData(_idController.text);
                                                                        switch (
                                                                            resultStatus) {
                                                                          case '': // 존재하지 않는 아이디
                                                                            if (context.mounted) {
                                                                              showDialog(
                                                                                  context: context,
                                                                                  builder: (context) {
                                                                                    return OneAnswerDialog(
                                                                                        onTap: () {
                                                                                          Navigator.pop(context);
                                                                                        },
                                                                                        title: '알림',
                                                                                        subtitle: '아이디가 존재하지 않습니다.',
                                                                                        firstButton: '확인',
                                                                                        imagePath: 'assets/gifs/alert.gif');
                                                                                  });
                                                                            }

                                                                          case 'error': // 에러 발생
                                                                            if (context.mounted) {
                                                                              showDialog(
                                                                                  context: context,
                                                                                  builder: (context) {
                                                                                    return OneAnswerDialog(
                                                                                        onTap: () {
                                                                                          Navigator.pop(context);
                                                                                        },
                                                                                        title: '에러 발생',
                                                                                        subtitle: '잠시 후 다시 시도해 주세요.',
                                                                                        firstButton: '확인',
                                                                                        imagePath: 'assets/gifs/alert.gif');
                                                                                  });
                                                                            }
                                                                          default: // 전화번호 데이터 확인
                                                                            if (_phoneForPasswordController.text ==
                                                                                resultStatus) {
                                                                              final result = await showDialog(
                                                                                  context: context,
                                                                                  builder: (context) {
                                                                                    return CellphoneValidPage(servicePhoneNo: servicePhoneNo, phoneNumber: _phoneForPasswordController.text);
                                                                                  });
                                                                              if (result == true) {
                                                                                setState(() {
                                                                                  isValidPhoneNo = !isValidPhoneNo;
                                                                                });
                                                                              }
                                                                              final Widget content = Text((result == true)
                                                                                  ? "인증이 완료되었습니다."
                                                                                  : (result == false)
                                                                                      ? "5회 이상 실패했습니다. 상담실로 문의해 주세요."
                                                                                      : '다시 인증해 주세요.');
                                                                              viewModel.showSnackbar(context, content);

                                                                              // FocusScope.of(context)
                                                                              //     .unfocus();
                                                                            } else {
                                                                              // 입력된 전화번호가 불일치하면 알림
                                                                              if (context.mounted) {
                                                                                showDialog(
                                                                                    context: context,
                                                                                    builder: (context) {
                                                                                      return OneAnswerDialog(
                                                                                          onTap: () {
                                                                                            Navigator.pop(context);
                                                                                          },
                                                                                          title: '알림',
                                                                                          subtitle: '전화번호가 일치하지 않습니다.',
                                                                                          firstButton: '확인',
                                                                                          imagePath: 'assets/gifs/alert.gif');
                                                                                    });
                                                                              }
                                                                            }
                                                                        }
                                                                      } catch (e) {
                                                                        logger.info(
                                                                            e);
                                                                      }
                                                                    }
                                                                  },
                                                        child: isValidPhoneNo
                                                            ? const Icon(
                                                                Icons.check,
                                                                color: Colors
                                                                    .white,
                                                              )
                                                            : const Text(
                                                                '인증하기',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                      )),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Stack(
                                                    children: [
                                                      TextFormField(
                                                        readOnly:
                                                            (isValidPhoneNo)
                                                                ? true
                                                                : false,
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        inputFormatters: [
                                                          FilteringTextInputFormatter
                                                              .digitsOnly,
                                                          LengthLimitingTextInputFormatter(
                                                              12),
                                                        ],
                                                        controller:
                                                            _phoneForPasswordController,
                                                        style: const TextStyle(
                                                            fontSize: 15),
                                                        decoration:
                                                            InputDecoration(
                                                          hintText:
                                                              '회원가입 시 등록한 휴대폰번호',
                                                          contentPadding:
                                                              const EdgeInsets
                                                                  .fromLTRB(
                                                                  10, 5, 0, 5),
                                                          border:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                const BorderSide(
                                                              width: 0.1,
                                                              color:
                                                                  Colors.white,
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
                                                              color: (_errorPhoneForPasswordText ==
                                                                      null)
                                                                  ? Colors.grey
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
                                                              color: (_errorPhoneForPasswordText ==
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
                                                            _errorPhoneForPasswordText =
                                                                (value.isEmpty
                                                                    ? '필수항목입니다.'
                                                                    : null);
                                                          });
                                                        },
                                                        // validator: (value) {
                                                        //   if (value == null ||
                                                        //       value.isEmpty) {
                                                        //     return '필수항목입니다.';
                                                        //   }
                                                        //   return null;
                                                        // },
                                                      ),
                                                      if (_errorPhoneForPasswordText !=
                                                          null)
                                                        Positioned(
                                                          top: 15,
                                                          right: 15,
                                                          child: Container(
                                                            color: Colors.white,
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        4),
                                                            child: Text(
                                                              _errorPhoneForPasswordText!,
                                                              style: const TextStyle(
                                                                  color: Color(
                                                                      0xFFba1a1a),
                                                                  fontSize: 12),
                                                            ),
                                                          ),
                                                        ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Row(
                                              children: [
                                                Expanded(child: Container()),
                                                Expanded(
                                                  child: ElevatedButton(
                                                    onPressed: (state
                                                        .isLoading)
                                                        ? (){} : () async {
                                                      setState(() {
                                                        _errorIdText =
                                                            (_idController.text
                                                                    .isEmpty
                                                                ? '필수항목입니다.'
                                                                : null);
                                                        _errorPhoneForPasswordText =
                                                            (_phoneForPasswordController
                                                                    .text
                                                                    .isEmpty
                                                                ? '필수항목입니다.'
                                                                : null);
                                                      });
                                                      if (_errorIdText ==
                                                              null &&
                                                          _errorPhoneForPasswordText ==
                                                              null) {
                                                        if (isValidPhoneNo) {
                                                          // 입력된 전화번호가 일치하다면 비밀번호 재설정
                                                          final newPassword =
                                                              await showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return const ResetPasswordPage();
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
                                                            // firebase에 바뀐 비밀번호로 재가입

                                                            await viewModel
                                                                .deleteAndResignup(
                                                                    _idController
                                                                        .text,
                                                                    newPassword);
                                                            if (context
                                                                .mounted) {
                                                              showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return OneAnswerDialog(
                                                                            onTap:
                                                                                () {
                                                                              Navigator.pop(context);
                                                                              GoRouter.of(context).go('/profile_page/login_page', extra: {
                                                                                'hideNavBar': widget.hideNavBar
                                                                              });
                                                                            },
                                                                            title:
                                                                                '비밀번호가 재설정 되었습니다.',
                                                                            subtitle:
                                                                                '로그인 페이지로 돌아갑니다.',
                                                                            firstButton:
                                                                                '확인',
                                                                            imagePath:
                                                                                'assets/gifs/success.gif');
                                                                  });
                                                            }
                                                          }
                                                        } else {
                                                          // 인증이 되지 않았을 때 스낵바로 알림
                                                          const Widget content =
                                                              Text(
                                                                  '휴대폰번호 인증을 완료해 주세요.');
                                                          viewModel
                                                              .showSnackbar(
                                                                  context,
                                                                  content);
                                                        }
                                                      }
                                                    },

                                                    style: ElevatedButton.styleFrom(
                                                        backgroundColor:(state
                                                            .isLoading)
                                                            ? Colors.grey
                                                            :
                                                        const Color(
                                                                0xFF2F362F),
                                                        shape: const RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius.circular(
                                                                        10)))),
                                                    child: (state
                                                        .isLoading)
                                                        ? Center(
                                                      child:
                                                      GifProgressBar(radius: 15,),
                                                    )
                                                        : const Text(
                                                      '재설정하기',
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
                                  ),
                                ),
                              ),
                            ],
                          ),
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
