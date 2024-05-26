import 'package:firebase_auth/firebase_auth.dart'  as firebase_auth;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/simple_logger.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _passwordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _newPasswordConfirmController = TextEditingController();

  String? _errorPasswordText;
  String? _errorNewPasswordText;
  String? _errorNewPasswordConfirmText;

  @override
  void dispose() {
    _passwordController.dispose();
    _newPasswordController.dispose();
    _newPasswordConfirmController.dispose();
    super.dispose();
  }

  // 현재 비밀번호 다시 확인
  Future<bool> _reauthenticateUser(String currentPassword) async {
    try {
      firebase_auth.User? user = firebase_auth.FirebaseAuth.instance.currentUser;
      if (user == null) {
        setState(() {
          _errorPasswordText = '사용자가 인증되지 않았습니다.';
        });
        return false;
      }

      firebase_auth.AuthCredential credential = firebase_auth.EmailAuthProvider.credential(
        email: user.email!,
        password: currentPassword,
      );

      await user.reauthenticateWithCredential(credential);
      return true;
    } catch (e) {
      setState(() {
        _errorPasswordText = '현재 비밀번호가 잘못되었습니다.';
      });
      return false;
    }
  }

  // 비밀번호 재설정 메서드(여기서 사용하지 않음)
  Future<void> passwordUpdate(String newPassword) async {

    String currentPassword = _passwordController.text;
    if (await _reauthenticateUser(currentPassword)) {
      try {
        firebase_auth.User? user = firebase_auth.FirebaseAuth.instance.currentUser;
        if (user != null) {
          await user.updatePassword(newPassword);
        }
      } catch (e) {
        logger.info('Error changing password: $e');
      }
    }

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
              const Text('비밀번호 변경',
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16)),
              const SizedBox(height: 8),
              // 여기에 현재 비밀번호 텍스트 입력
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Stack(
                  children: [
                    TextFormField(
                      obscureText: true,
                      controller: _passwordController,
                      style: const TextStyle(fontSize: 15),
                      decoration: InputDecoration(
                        hintText: '현재 비밀번호',
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
                            color: (_errorPasswordText == null)
                                ? Colors.grey
                                : const Color(0xFFba1a1a),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2,
                            color: (_errorPasswordText == null)
                                ? const Color(0xFF2F362F)
                                : const Color(0xFFba1a1a),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _errorPasswordText =
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
                    if (_errorPasswordText != null)
                      Positioned(
                        top: 15,
                        right: 15,
                        child: Container(
                          color: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Text(
                            _errorPasswordText!,
                            style: const TextStyle(
                                color: Color(0xFFba1a1a), fontSize: 12),
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 2),
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

              const SizedBox(height: 2),
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

              const SizedBox(height: 7),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  children: [
                    Expanded(child: Container()),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            _errorPasswordText =
                            (_passwordController.text.isEmpty
                                ? '필수항목입니다.'
                                : _passwordController.text.length < 6
                                ? '6자리 이상 입력해주세요.'
                                : null);
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
                          if (_errorPasswordText == null && _errorNewPasswordText == null &&
                              _errorNewPasswordConfirmText == null) {
                            await passwordUpdate(_newPasswordConfirmController.text);
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
                          '변경',
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
