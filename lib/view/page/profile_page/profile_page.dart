import 'dart:io';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../widgets/one_answer_dialog.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.hideNavBar});

  final bool Function(bool) hideNavBar;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  XFile? _pickedFile;

  @override
  Widget build(BuildContext context) {
    const double imageSize = 100;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
                padding: const EdgeInsets.fromLTRB(25, 40, 25, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 9),
                      child: Row(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          if (_pickedFile == null)
                            Container(
                              constraints: const BoxConstraints(
                                minHeight: imageSize,
                                minWidth: imageSize,
                              ),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    width: 2,
                                    color:
                                        Theme.of(context).colorScheme.primary),
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  _showBottomSheet();
                                },
                                child: Center(
                                  child: AvatarGlow(
                                    startDelay:
                                        const Duration(milliseconds: 1000),
                                    glowColor: Colors.red,
                                    glowShape: BoxShape.circle,
                                    animate: true,
                                    curve: Curves.fastOutSlowIn,
                                    glowCount: 3,
                                    glowRadiusFactor: 0.2,
                                    child: const Material(
                                      elevation: 8.0,
                                      shape: CircleBorder(),
                                      color: Colors.transparent,
                                      child: CircleAvatar(
                                        backgroundImage: AssetImage(
                                          'assets/images/myk_market_logo.png',
                                        ),
                                        radius: imageSize / 2,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          else
                            Container(
                              constraints: const BoxConstraints(
                                minHeight: imageSize,
                                minWidth: imageSize,
                              ),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    width: 2,
                                    color:
                                        Theme.of(context).colorScheme.primary),
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  _showBottomSheet();
                                },
                                child: Center(
                                  child: AvatarGlow(
                                    startDelay:
                                        const Duration(milliseconds: 1000),
                                    glowColor: Colors.red,
                                    glowShape: BoxShape.circle,
                                    animate: true,
                                    curve: Curves.fastOutSlowIn,
                                    glowCount: 3,
                                    glowRadiusFactor: 0.2,
                                    child: Material(
                                      elevation: 8.0,
                                      shape: const CircleBorder(),
                                      color: Colors.transparent,
                                      child: CircleAvatar(
                                        backgroundImage:
                                            FileImage(File(_pickedFile!.path)),
                                        radius: 50.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          SizedBox(
                            width: 50.h,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 50,),
                              const Text('반갑습니다.',style: TextStyle(fontSize: 20),),
                              Text(
                                '${FirebaseAuth.instance.currentUser?.displayName} 님,',
                                style: const TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 70.h,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            GoRouter.of(context).push(
                                '/profile_page/order_history_page',
                                extra: {'hideNavBar': widget.hideNavBar});
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 24, left: 12),
                            child: Container(
                              width: double.infinity,
                              color: Colors.transparent,
                              child: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    '주문내역',
                                    style: TextStyle(
                                      color: Colors.black87, fontSize: 20
                                    ),
                                  ),
                                  Text(' > 상세보기'),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const Divider(
                          indent: 10,
                          thickness: 0.5,
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            //TODO: 회원정보 수정 페이지로 이동
                            GoRouter.of(context)
                                .push('/profile_page/edit_user_info_page');
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 24, left: 12),
                            child: Container(
                              width: double.infinity,
                              color: Colors.transparent,
                              child: const Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    '회원정보 수정',
                                    style: TextStyle(
                                      color: Colors.black87,  fontSize: 20
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const Divider(
                          indent: 10,
                          thickness: 0.5,
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            FirebaseAuth.instance.signOut();
                            if (context.mounted) {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return OneAnswerDialog(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        title: '찾아주셔서 감사합니다.',
                                        subtitle: '로그아웃 되었습니다.',
                                        firstButton: '확인',
                                        imagePath: 'assets/gifs/success.gif');
                                  });
                            }
                            GoRouter.of(context).go('/main_page');
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 24, left: 12),
                            child: Container(
                              width: double.infinity,
                              color: Colors.transparent,
                              child: const Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    '로그아웃',
                                    style: TextStyle(
                                      color: Colors.black87, fontSize: 20
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const Divider(
                          indent: 10,
                          thickness: 0.5,
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            //TODO: 회원탈퇴 기능 넣기
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 24, left: 12),
                            child: Container(
                              width: double.infinity,
                              color: Colors.transparent,
                              child: const Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    '회원탈퇴',
                                    style: TextStyle(
                                      color: Colors.black87, fontSize: 20
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const Divider(
                          indent: 10,
                          thickness: 0.5,
                          height: 10,
                        ),
                      ],
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

  _showBottomSheet() {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () => _getCameraImage(),
              child: const Text('사진찍기'),
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              thickness: 3,
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () => _getPhotoLibraryImage(),
              child: const Text('라이브러리에서 불러오기'),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        );
      },
    );
  }

  _getCameraImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _pickedFile = pickedFile;
      });
    } else {
      if (kDebugMode) {
        print('이미지 선택안함');
      }
    }
  }

  _getPhotoLibraryImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _pickedFile = pickedFile;
      });
    } else {
      if (kDebugMode) {
        print('이미지 선택안함');
      }
    }
  }
}
