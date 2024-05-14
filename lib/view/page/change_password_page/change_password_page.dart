import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _nameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF2F362F),
        title: const Text(
          '마이페이지',
          style: TextStyle(
              fontFamily: 'Jalnan', fontSize: 20, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: ClipRRect(
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
                        controller: _phoneController,
                        decoration: const InputDecoration(hintText: '핸드폰 번호'),
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
                  onPressed: () {},
                  child: Text('찾기'),
                ),
                SizedBox(
                  height: 32.h,
                ),
                Text('비밀번호 변경'),
                Form(
                  key: _formKey2,
                  child: TextFormField(
                    controller: _currentPasswordController,
                    decoration: InputDecoration(hintText: '현재 비밀번호'),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '필수항목입니다.';
                      }
                      return null;
                    },
                  ),
                ),
                TextButton(
                  child: Text('변경하기'),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
