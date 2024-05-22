import 'package:daum_postcode_search/data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:myk_market_app/view/page/signup_page/platform_check/check_file.dart'
    as check;
import 'package:myk_market_app/view/page/signup_page/signup_page_view_model.dart';
import 'package:myk_market_app/view/widgets/one_answer_dialog.dart';

import '../../../utils/simple_logger.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key, required this.isPersonalInfoForDeliverChecked});

  final bool isPersonalInfoForDeliverChecked;

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController idController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController postcodeController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController extraAddressController = TextEditingController();

  bool isValidPhoneNo = false;

  @override
  void dispose() {
    idController.dispose();
    passwordConfController.dispose();
    passwordController.dispose();
    nameController.dispose();
    phoneController.dispose();
    postcodeController.dispose();
    addressController.dispose();
    extraAddressController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    SignupViewModel().getUserArray();
  }

  @override
  Widget build(BuildContext context) {
    final controllers = [
      idController,
      passwordController,
      passwordConfController,
      nameController,
      phoneController,
      postcodeController,
      addressController,
      extraAddressController
    ];

    final viewModel = SignupViewModel();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF2F362F),
        scrolledUnderElevation: 0,
        title: const Text(
          '회원가입',
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
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 8, left: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '기본정보',
                            style: TextStyle(fontSize: 18),
                          ),
                          Text('* 표시된 항목은 필수 입력해야 합니다.'),
                        ],
                      ),
                    ),
                    const Divider(),
                    Expanded(
                      child: ListView(
                        physics: const BouncingScrollPhysics(),
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8, bottom: 8),
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
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: 8,
                                  padding: const EdgeInsets.all(8.0),
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: (index == 5)
                                          ? const EdgeInsets.fromLTRB(
                                              4, 4, 4, 0)
                                          : const EdgeInsets.all(4.0),
                                      child: Column(
                                        children: [
                                          (index == 6)
                                              ? const SizedBox(
                                                  height: 0.5,
                                                )
                                              : Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      (index != 7)
                                                          ? '* '
                                                          : '  ',
                                                      style: const TextStyle(
                                                          color: Colors.red),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        viewModel.gridLeftArray[
                                                            index],
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 15),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                          index == 4
                                              ? Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
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
                                                                  : () {
                                                                      if (phoneController
                                                                          .text
                                                                          .isEmpty) {
                                                                        showDialog(
                                                                          context:
                                                                              context,
                                                                          builder:
                                                                              (context) {
                                                                            return OneAnswerDialog(
                                                                              onTap: () {
                                                                                Navigator.pop(context);
                                                                              },
                                                                              title: '휴대폰번호를 입력해 주세요.',
                                                                              firstButton: '확인',
                                                                              imagePath: 'assets/gifs/fail.gif',
                                                                            );
                                                                          },
                                                                        );
                                                                      }
                                                                      //TODO: 인증번호 생성후 문자발송, 다이얼로그 띄우고 인증절차
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
                                                    Expanded(
                                                      flex: 1,
                                                      child: TextFormField(
                                                        validator: (value) {
                                                          if (value == null ||
                                                              value.isEmpty) {
                                                            return '휴대폰번호를 입력해 주세요.';
                                                          }
                                                          return null;
                                                        },
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        inputFormatters: [
                                                          FilteringTextInputFormatter
                                                              .digitsOnly,
                                                          LengthLimitingTextInputFormatter(
                                                              12),
                                                        ],
                                                        style: const TextStyle(
                                                            fontSize: 15),
                                                        decoration:
                                                            InputDecoration(
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
                                                        ),
                                                        controller:
                                                            controllers[index],
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              : index == 5
                                                  ? Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    right:
                                                                        16.0),
                                                            child:
                                                                OutlinedButton(
                                                              style: OutlinedButton
                                                                  .styleFrom(
                                                                      // shape: const RoundedRectangleBorder(
                                                                      //     borderRadius: BorderRadius.zero),
                                                                      shape: const RoundedRectangleBorder(
                                                                          borderRadius: BorderRadius.all(Radius.circular(
                                                                              10))),
                                                                      backgroundColor:
                                                                          const Color(
                                                                              0xFF2F362F)),
                                                              onPressed:
                                                                  () async {
                                                                try {
                                                                  DataModel?
                                                                      model =
                                                                      await Navigator.of(
                                                                              context)
                                                                          .push(
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                check.pr),
                                                                  );
                                                                  setState(
                                                                    () {
                                                                      viewModel
                                                                              .daumPostcodeSearchDataModel =
                                                                          model;
                                                                    },
                                                                  );
                                                                  postcodeController
                                                                      .text = (viewModel
                                                                          .daumPostcodeSearchDataModel
                                                                          ?.zonecode) ??
                                                                      viewModel
                                                                          .zoneCode;
                                                                  addressController
                                                                      .text = (viewModel
                                                                          .daumPostcodeSearchDataModel
                                                                          ?.address) ??
                                                                      viewModel
                                                                          .address;
                                                                } catch (error) {
                                                                  logger.info(
                                                                      error);
                                                                }
                                                              },
                                                              child: const Text(
                                                                '주소검색',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                            )),
                                                        Expanded(
                                                          flex: 1,
                                                          child: TextFormField(
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
                                                            ),
                                                            controller:
                                                                controllers[
                                                                    index],
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  : TextFormField(
                                                      obscureText:
                                                          (index == 1 ||
                                                                  index == 2)
                                                              ? true
                                                              : false,
                                                      validator: (value) {
                                                        if (value == null ||
                                                            value.isEmpty) {
                                                          return '필수항목입니다.';
                                                        }
                                                        if (index == 0) {
                                                          if (viewModel
                                                              .userArray
                                                              .contains(
                                                                  idController
                                                                      .text)) {
                                                            return '사용중인 아이디입니다.';
                                                          }
                                                        }
                                                        if (index == 1) {
                                                          if (passwordController
                                                                  .text.length <
                                                              6) {
                                                            return '6자리 이상 입력해주세요.';
                                                          }
                                                        }
                                                        return null;
                                                      },
                                                      readOnly: (index == 6)
                                                          ? true
                                                          : false,
                                                      style: const TextStyle(
                                                          fontSize: 15),
                                                      decoration:
                                                          InputDecoration(
                                                        contentPadding:
                                                            const EdgeInsets
                                                                .fromLTRB(
                                                                10, 5, 0, 5),
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
                                                      ),
                                                      controller:
                                                          controllers[index],
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
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(flex: 1, child: Container()),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  '취소',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                    // shape: const RoundedRectangleBorder(
                                    //     borderRadius: BorderRadius.zero),
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    backgroundColor: const Color(0xFF2F362F)),
                                onPressed: () {
                                  if (idController.text.isEmpty || passwordController.text.isEmpty){
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return OneAnswerDialog(
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            title: '알림',
                                            subtitle: '아이디 또는 비밀번호가 입력되지 않았습니다.',
                                            firstButton: '확인',
                                            imagePath: 'assets/gifs/fail.gif');
                                      },
                                    );
                                  }
                                  else if (passwordController.text !=
                                      passwordConfController.text) {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return OneAnswerDialog(
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            title: '알림',
                                            subtitle: '비밀번호가 서로 다릅니다.',
                                            firstButton: '확인',
                                            imagePath: 'assets/gifs/fail.gif');
                                      },
                                    );
                                  }else if (nameController.text.isEmpty) {
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
                                            imagePath: 'assets/gifs/fail.gif');
                                      },
                                    );
                                  }
                                  else if (!isValidPhoneNo) {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return OneAnswerDialog(
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            title: '알림',
                                            subtitle: '휴대폰 번호를 인증해 주세요.',
                                            firstButton: '확인',
                                            imagePath: 'assets/gifs/fail.gif');
                                      },
                                    );
                                  } else if (viewModel
                                              .daumPostcodeSearchDataModel
                                              ?.address ==
                                          null &&
                                      viewModel.address == '') {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return OneAnswerDialog(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          title: '주소를 검색해 주세요.',
                                          firstButton: '확인',
                                          imagePath: 'assets/gifs/fail.gif',
                                        );
                                      },
                                    );
                                  } else {
                                    if (_formKey.currentState!.validate()) {
                                      // _formKey.currentState?.save();
                                      final message = viewModel.saveUserInfo(
                                        idController.text,
                                        nameController.text,
                                        passwordController.text,
                                        phoneController.text,
                                        viewModel.daumPostcodeSearchDataModel
                                                ?.zonecode ??
                                            viewModel.zoneCode,
                                        viewModel.daumPostcodeSearchDataModel
                                                ?.address ??
                                            viewModel.address,
                                        extraAddressController.text,
                                        DateTime.now().millisecondsSinceEpoch,
                                        widget.isPersonalInfoForDeliverChecked,
                                      );
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return OneAnswerDialog(
                                              onTap: () {
                                                Navigator.pop(context);
                                                context.go(
                                                    '/profile_page/login_page');
                                              },
                                              title: '회원가입이 완료되었습니다.',
                                              subtitle: '로그인을 해주세요.',
                                              firstButton: '확인',
                                              imagePath:
                                                  'assets/gifs/success.gif');
                                        },
                                      );
                                    }
                                  }
                                },
                                child: const Text(
                                  '회원가입',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          Expanded(flex: 1, child: Container()),
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
