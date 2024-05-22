import 'package:daum_postcode_search/data_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myk_market_app/styles/app_text_colors.dart';
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

  var idController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordConfController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var addressController = TextEditingController();

  @override
  void dispose() {
    idController.dispose();
    passwordConfController.dispose();
    passwordController.dispose();
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
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
      phoneController
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
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '기본정보',
                          style:
                              TextStyle(fontFamily: 'Jalnan', fontSize: 20),
                        ),
                        Text('* 표시된 항목은 필수 입력해야 합니다.'),
                      ],
                    ),
                    const Divider(),
                    Expanded(
                      child: Form(
                        key: _formKey,
                        child: ListView.builder(
                          itemCount: 6,
                          padding: const EdgeInsets.all(16.0),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    '*',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  Expanded(
                                    child: Text(SignupViewModel()
                                        .gridLeftArray[index]),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: index == 5
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Text(viewModel
                                                          .daumPostcodeSearchDataModel
                                                          ?.address ??
                                                      viewModel.address),
                                                  Text(viewModel
                                                          .daumPostcodeSearchDataModel
                                                          ?.zonecode ??
                                                      viewModel.zoneCode),
                                                ],
                                              ),
                                              TextFormField(
                                                controller: addressController,
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                ),
                                                decoration:
                                                    const InputDecoration(
                                                        border:
                                                            OutlineInputBorder(),
                                                        hintText: '상세 주소'),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: ElevatedButton.icon(
                                                  onPressed: () async {
                                                    try {
                                                      DataModel? model =
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
                                                    } catch (error) {
                                                      logger.info(error);
                                                    }
                                                  },
                                                  icon: const Icon(
                                                      Icons.search),
                                                  label: const Text("주소 검색"),
                                                ),
                                              ),
                                            ],
                                          )
                                        : TextFormField(
                                            obscureText:
                                                (index == 1 || index == 2)
                                                    ? true
                                                    : false,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return '필수항목입니다.';
                                              }
                                              if (index == 0) {
                                                if (viewModel.userArray
                                                    .contains(
                                                        idController.text)) {
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
                                            style:
                                                const TextStyle(fontSize: 12),
                                            decoration: const InputDecoration(
                                              border: OutlineInputBorder(),
                                            ),
                                            controller: controllers[index],
                                          ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('취소'),
                          ),
                          TextButton(
                            style: const ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(
                                  AppColors.mainButton),
                            ),
                            onPressed: () {
                              if (passwordController.text !=
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
                              } else if (viewModel.daumPostcodeSearchDataModel
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
                                    addressController.text,
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
                            child: const Text('회원가입'),
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
