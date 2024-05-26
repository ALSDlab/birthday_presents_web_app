import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/simple_logger.dart';

class UserWithdrawalPage extends StatefulWidget {
  const UserWithdrawalPage({super.key});

  @override
  State<UserWithdrawalPage> createState() => _UserWithdrawalPageState();
}

class _UserWithdrawalPageState extends State<UserWithdrawalPage> {
  final _passwordController = TextEditingController();

  String? _errorPasswordText;
  firebase_auth.User? user = firebase_auth.FirebaseAuth.instance.currentUser;

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  // 현재 비밀번호 다시 확인
  Future<bool> _reauthenticateUser(String currentPassword) async {
    try {
      if (user == null) {
        setState(() {
          _errorPasswordText = '사용자가 인증되지 않았습니다.';
        });
        return false;
      }
      firebase_auth.AuthCredential credential =
          firebase_auth.EmailAuthProvider.credential(
        email: user!.email!,
        password: currentPassword,
      );
      await user!.reauthenticateWithCredential(credential);
      return true;
    } catch (e) {
      setState(() {
        _errorPasswordText = '현재 비밀번호가 잘못되었습니다.';
      });
      return false;
    }
  }

  // 회원탈퇴 메서드 작성
  Future<void> userWithdrawal() async {
    String currentPassword = _passwordController.text;
    if (await _reauthenticateUser(currentPassword)) {
      try {
        if (user != null) {
          await user!.delete();
          //TODO: 회원탈퇴 및 유저정보, 프로필 이미지 삭제 기능 넣기
        }
      } catch (e) {
        logger.info('Error user withdrawal: $e');
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
              const Text('정말 탈퇴하시겠습니까?',
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16)),
              const SizedBox(height: 8),
              const Text(
                '확인을 위해 현재 비밀번호를 입력해 주세요.',
                style: TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
                overflow: TextOverflow.visible,
              ),
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

              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 100,
                      height: 32,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: OutlinedButton.styleFrom(
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              backgroundColor: const Color(0xFF2F362F)),
                          child: const Text('아니오',
                              style: TextStyle(
                                  fontSize: 14, color: Colors.white))),
                    ),
                    const SizedBox(width: 14),
                    SizedBox(
                      width: 100,
                      height: 32,
                      child: ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              _errorPasswordText =
                                  (_passwordController.text.isEmpty
                                      ? '필수항목입니다.'
                                      : _passwordController.text.length < 6
                                          ? '6자리 이상 입력해주세요.'
                                          : null);
                            });
                            if (_errorPasswordText == null) {
                              await userWithdrawal();
                              Navigator.pop(context, true);
                            }
                          },
                          style: OutlinedButton.styleFrom(
                              // shape: const RoundedRectangleBorder(
                              //     borderRadius: BorderRadius.zero),
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              backgroundColor: Colors.grey.shade200),
                          child: const Text('예',
                              style: TextStyle(
                                  fontSize: 14, color: Colors.black))),
                    ),
                    const SizedBox(height: 10),
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
