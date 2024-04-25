import 'package:daum_postcode_search/data_model.dart';
import 'package:flutter/material.dart';
import 'package:myk_market_app/view/page/signup_page/platform_check/check_file.dart'
    as check;
import 'package:myk_market_app/styles/app_text_colors.dart';
import 'package:myk_market_app/view/page/signup_page/signup_page_view_model.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

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

  late int postCode;

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
  Widget build(BuildContext context) {
    final controllers = [
      idController,
      passwordController,
      passwordConfController,
      nameController,
      phoneController
    ];

    final viewModel = SignupViewModel();
    // final state = viewModel.state;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('기본정보'),
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
                              child:
                                  Text(SignupViewModel().gridLeftArray[index]),
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
                                              MainAxisAlignment.spaceAround,
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
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                          decoration: const InputDecoration(
                                              border: OutlineInputBorder(),
                                              hintText: '상세 주소'),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ElevatedButton.icon(
                                            onPressed: () async {
                                              try {
                                                DataModel? model =
                                                    await Navigator.of(context)
                                                        .push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
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
                                                print(error);
                                              }
                                            },
                                            icon: const Icon(Icons.search),
                                            label: const Text("주소 검색"),
                                          ),
                                        ),
                                      ],
                                    )
                                  : TextFormField(
                                      obscureText: (index == 1 || index == 2)
                                          ? true
                                          : false,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return '필수항목입니다.';
                                        }
                                        return null;
                                      },
                                      style: TextStyle(fontSize: 12),
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
                        backgroundColor:
                            MaterialStatePropertyAll(AppColors.mainButton),
                      ),
                      onPressed: () {
                        // TODO: postcode, address 수정
                        if (_formKey.currentState!.validate()) {
                          // _formKey.currentState?.save();
                          viewModel.saveUserInfo(
                            idController.text,
                            nameController.text,
                            passwordController.text,
                            phoneController.text,
                            viewModel.zoneCode,
                            viewModel.address,
                            addressController.text,
                            DateTime.now(),
                          );
                          AlertDialog(
                            content: Text('회원가입이 완료되었습니다. 로그인을 해주세요.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  // TODO: 로그인 페이지 or 홈페이지로 이동
                                },
                                child: const Text('확인'),
                              ),
                            ],
                          );
                        }
                        if (passwordController.text !=
                            passwordConfController.text) {
                          AlertDialog(
                            title: Text('알림'),
                            content: Text('비밀번호가 서로 다릅니다.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('확인'),
                              ),
                            ],
                          );
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
    );
  }
}
