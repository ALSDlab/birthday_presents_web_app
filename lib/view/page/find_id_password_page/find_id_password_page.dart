import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:myk_market_app/view/page/find_id_password_page/find_id_password_page_view_model.dart';
import 'package:myk_market_app/view/widgets/one_answer_dialog.dart';

class FindIdPasswordPage extends StatefulWidget {
  const FindIdPasswordPage({super.key});

  @override
  State<FindIdPasswordPage> createState() => _FindIdPasswordPageState();
}

class _FindIdPasswordPageState extends State<FindIdPasswordPage> {
  final _emailController = TextEditingController();
  final _phoneForIdController = TextEditingController();
  final _nameController = TextEditingController();
  final _idController = TextEditingController();
  final _phoneForPasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _phoneForIdController.dispose();
    _nameController.dispose();
    _idController.dispose();
    _phoneForPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = FindIdPasswordViewModel();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2F362F),
        scrolledUnderElevation: 0,
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
                padding: const EdgeInsets.all(64.0),
                child: ListView(
                  children: [
                    const Text('아이디 찾기'),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _nameController,
                            decoration: const InputDecoration(hintText: '이름'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '필수항목입니다.';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: _phoneForIdController,
                            decoration:
                                const InputDecoration(hintText: '핸드폰 번호'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '필수항목입니다.';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          String id = await viewModel.findDocumentId(
                              _nameController.text, _phoneForIdController.text);

                          showDialog(
                            context: context,
                            builder: (context) {
                              return OneAnswerDialog(
                                onTap: () {
                                  Navigator.pop(context);
                                  context.go('/profile_page/login_page');
                                },
                                title: id != ''
                                    ? 'id는 $id 입니다.'
                                    : '입력하신 정보로 아이디를 찾을 수 없습니다.',
                                subtitle: id != ''
                                    ? null
                                    : '다시 시도해 주시거나 회원가입을 해 주세요.',
                                firstButton: '확인',
                                imagePath: id != ''
                                    ? 'assets/gifs/success.gif'
                                    : 'assets/gifs/fail.gif',
                              );
                            },
                          );
                        }
                      },
                      child: Text('찾기'),
                    ),
                    SizedBox(
                      height: 32.h,
                    ),
                    Text('비밀번호 찾기'),
                    Form(
                      key: _formKey2,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _idController,
                            decoration: const InputDecoration(hintText: '아이디'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '필수항목입니다.';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: _phoneForIdController,
                            decoration: InputDecoration(
                                hintText: '회원가입 시 등록된 휴대폰 번호를 입력해주세요.'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '필수항목입니다.';
                              }
                              final RegExp emailRegExp = RegExp(
                                  r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
                              if (!emailRegExp.hasMatch(value)) {
                                return '유효한 이메일 주소를 입력하세요.';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      child: Text('변경하기'),
                      onPressed: () async {
                        if (_formKey2.currentState!.validate()) {
                          try {
                            await FirebaseAuth.instance
                                .sendPasswordResetEmail(
                                    email: _emailController.text);
                          } catch (e) {
                            print(e);
                          }

                          if (context.mounted) {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return OneAnswerDialog(
                                    onTap: () {
                                      Navigator.pop(context);
                                      context.go('/profile_page/login_page');
                                    },
                                    title: '인증번호를 보냈습니다.',
                                    subtitle: '문자를 확인해 주세요.',
                                    firstButton: '확인',
                                    imagePath: 'assets/gifs/success.gif');
                              },
                            );
                          }
                        }
                      },
                    ),
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
