import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _newPasswordController = TextEditingController();
  final _newPasswordConfirmController = TextEditingController();

  String? _errorNewPasswordText;
  String? _errorNewPasswordConfirmText;

  @override
  void dispose() {
    _newPasswordController.dispose();
    _newPasswordConfirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: Colors.white,
        ),
        width: 300,
        height: 300,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('비밀번호 재설정',
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16)),
              const SizedBox(height: 8),
              // 여기에 새 비밀번호 텍스트 입력
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Stack(
                  children: [
                    TextFormField(
                      obscureText: true,
                      controller: _newPasswordController,
                      style: const TextStyle(fontSize: 15),
                      decoration: InputDecoration(
                        hintText: '새 비밀번호',
                        contentPadding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
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
                            color: (_errorNewPasswordText == null)
                                ? Colors.grey
                                : const Color(0xFFba1a1a),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2,
                            color: (_errorNewPasswordText == null)
                                ? const Color(0xFF2F362F)
                                : const Color(0xFFba1a1a),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _errorNewPasswordText =
                              (value.isEmpty ? '필수항목입니다.' : null);
                        });
                      },
                      // validator: (value) {
                      //   if (value == null || value.isEmpty) {
                      //     return '필수항목입니다.';
                      //   }
                      //   return null;
                      // },
                    ),
                    if (_errorNewPasswordText != null)
                      Positioned(
                        top: 15,
                        right: 15,
                        child: Container(
                          color: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Text(
                            _errorNewPasswordText!,
                            style: const TextStyle(
                                color: Color(0xFFba1a1a), fontSize: 12),
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 8),
              // 여기에 비밀번호 확인 텍스트 입력
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Stack(
                  children: [
                    TextFormField(
                      obscureText: true,
                      controller: _newPasswordConfirmController,
                      style: const TextStyle(fontSize: 15),
                      decoration: InputDecoration(
                        hintText: '새 비밀번호 확인',
                        contentPadding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
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
                            color: (_errorNewPasswordConfirmText == null)
                                ? Colors.grey
                                : const Color(0xFFba1a1a),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2,
                            color: (_errorNewPasswordConfirmText == null)
                                ? const Color(0xFF2F362F)
                                : const Color(0xFFba1a1a),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _errorNewPasswordConfirmText =
                              (value.isEmpty ? '필수항목입니다.' : null);
                        });
                      },
                      // validator: (value) {
                      //   if (value == null || value.isEmpty) {
                      //     return '필수항목입니다.';
                      //   }
                      //   return null;
                      // },
                    ),
                    if (_errorNewPasswordConfirmText != null)
                      Positioned(
                        top: 15,
                        right: 15,
                        child: Container(
                          color: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Text(
                            _errorNewPasswordConfirmText!,
                            style: const TextStyle(
                                color: Color(0xFFba1a1a), fontSize: 12),
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  children: [
                    Expanded(child: Container()),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            _errorNewPasswordText =
                                (_newPasswordController.text.isEmpty
                                    ? '필수항목입니다.'
                                    : _newPasswordController.text.length < 6
                                        ? '6자리 이상 입력해주세요.'
                                        : null);
                            _errorNewPasswordConfirmText =
                                (_newPasswordConfirmController.text.isEmpty
                                    ? '필수항목입니다.'
                                    : _newPasswordConfirmController
                                                .text.length <
                                            6
                                        ? '6자리 이상 입력해주세요.'
                                        : (_newPasswordController.text !=
                                                _newPasswordConfirmController
                                                    .text)
                                            ? '비밀번호가 서로 다릅니다.'
                                            : null);
                          });
                          if (_errorNewPasswordText == null &&
                              _errorNewPasswordConfirmText == null) {
                            Navigator.pop(
                                context, _newPasswordConfirmController.text);
                          }
                        },

                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2F362F),
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)))),
                        child: const Text(
                          '재설정',
                          style: TextStyle(color: Colors.white),
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
    );
  }
}
