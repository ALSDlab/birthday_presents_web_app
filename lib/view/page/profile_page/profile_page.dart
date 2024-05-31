import 'dart:io';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myk_market_app/utils/gif_progress_bar.dart';
import 'package:myk_market_app/utils/image_load_widget.dart';
import 'package:myk_market_app/view/page/profile_page/profile_page_view_model.dart';
import 'package:myk_market_app/view/page/profile_page/user_withdrawal_dialog.dart';
import 'package:myk_market_app/view/widgets/two_answer_dialog.dart';
import 'package:provider/provider.dart';

import '../../../utils/simple_logger.dart';
import '../../widgets/one_answer_dialog.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.hideNavBar});

  final bool Function(bool) hideNavBar;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  XFile? _myPickedFile;

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ProfilePageViewModel>();
    final state = viewModel.state;
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
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 9),
                      child: Row(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            constraints: const BoxConstraints(
                              minHeight: imageSize,
                              minWidth: imageSize,
                            ),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  width: 2,
                                  color: Theme.of(context).colorScheme.primary),
                            ),
                            child: Center(
                              child: (state.isLoading)
                                  ? GifProgressBar(
                                      radius: 15,
                                    )
                                  : GestureDetector(
                                      onTap: () async {
                                        if (kIsWeb) {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return OneAnswerDialog(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                  imagePath:
                                                      'assets/gifs/fail.gif',
                                                  title: '알림',
                                                  subtitle:
                                                      '웹페이지에서는 프로필 편집이 지원되지 않습니다.',
                                                  firstButton: '확인');
                                            },
                                          );
                                        } else {
                                          await _showBottomSheet();
                                          if (_myPickedFile != null) {
                                            await viewModel.saveProfileImage(
                                                _myPickedFile!);
                                          } else {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return OneAnswerDialog(
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                    },
                                                    title: '이미지가 선택되지 않았습니다.',
                                                    subtitle: '다시 시도해 주세요',
                                                    firstButton: '확인',
                                                    imagePath:
                                                        'assets/gifs/fail.gif');
                                              },
                                            );
                                          }
                                        }
                                      },
                                      child: AvatarGlow(
                                        startDelay:
                                            const Duration(milliseconds: 1000),
                                        glowColor: const Color(0xFF2F362F),
                                        glowShape: BoxShape.circle,
                                        animate: true,
                                        curve: Curves.fastOutSlowIn,
                                        glowCount: 5,
                                        glowRadiusFactor: 0.07,
                                        child: Material(
                                          elevation: 8.0,
                                          shape: const CircleBorder(),
                                          color: const Color(0xFFFFF8E7),
                                          child: ClipOval(
                                              child: (_myPickedFile != null)
                                                  ? Image.file(
                                                      File(_myPickedFile!.path),
                                                      width: imageSize,
                                                      height: imageSize,
                                                      fit: BoxFit.cover,
                                                    )
                                                  : (viewModel.currentUser
                                                              .isNotEmpty &&
                                                          viewModel
                                                                  .currentUser
                                                                  .first
                                                                  .profileImage !=
                                                              '')
                                                      ? ImageLoadWidget(
                                                          imageUrl: viewModel
                                                              .currentUser
                                                              .first
                                                              .profileImage,
                                                          width: imageSize,
                                                          height: imageSize,
                                                          fit: BoxFit.cover,
                                                          loadingBarRadius: 15,
                                                        )
                                                      : Image.asset(
                                                          'assets/images/myk_market_logo.png',
                                                          width: imageSize,
                                                          height: imageSize,
                                                          fit: BoxFit.cover,
                                                        )),
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
                              const SizedBox(
                                height: 50,
                              ),
                              const Text(
                                '반갑습니다.',
                                style: TextStyle(fontSize: 20),
                              ),
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
                                        color: Colors.black87, fontSize: 20),
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
                            GoRouter.of(context).push(
                                '/profile_page/edit_user_info_page',
                                extra: {'hideNavBar': widget.hideNavBar});
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
                                        color: Colors.black87, fontSize: 20),
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
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return TwoAnswerDialog(
                                    title: '정말 로그아웃하시겠습니까?',
                                    firstButton: '아니오',
                                    secondButton: '예',
                                    imagePath:
                                        'assets/gifs/two_answer_dialog.gif',
                                    onFirstTap: () {
                                      Navigator.pop(context);
                                    },
                                    onSecondTap: () {
                                      FirebaseAuth.instance.signOut();
                                      Navigator.pop(context);
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
                                                  imagePath:
                                                      'assets/gifs/success.gif');
                                            });
                                      }
                                      GoRouter.of(context).go('/main_page');
                                    },
                                  );
                                });
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
                                        color: Colors.black87, fontSize: 20),
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
                          onTap: (viewModel.currentUser.isEmpty)
                              ? () {}
                              : () async {
                                  final withdrawalResult = await showDialog(
                                      context: context,
                                      builder: (context) {
                                        return const UserWithdrawalPage();
                                      });

                                  if (withdrawalResult && context.mounted) {
                                    // 계정 삭제되어 true 값이 반환되면 유저정보 및 프로필이미지 삭제
                                    GoRouter.of(context).go('/main_page');
                                    await viewModel.userWithdrawalProcess(
                                        viewModel.currentUser.first.id);
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return OneAnswerDialog(
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              title: '정상적으로 완료되었습니다.',
                                              firstButton: '확인',
                                              imagePath:
                                                  'assets/gifs/success.gif');
                                        });
                                  }
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
                                        color: Colors.black87, fontSize: 20),
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

  Future<void> _showBottomSheet() async {
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
            Row(
              children: [
                Expanded(child: Container()),
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        // shape: const RoundedRectangleBorder(
                        //     borderRadius: BorderRadius.zero),
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        backgroundColor: const Color(0xFF2F362F)),
                    onPressed: () async {
                      await _getCameraImage();
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      BootstrapIcons.camera2,
                      color: Colors.white,
                    ),
                  ),
                ),
                Expanded(child: Container()),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(child: Container()),
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                    onPressed: () async {
                      await _getPhotoLibraryImage();
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      BootstrapIcons.file_earmark_image,
                      color: Colors.black,
                    ),
                  ),
                ),
                Expanded(child: Container()),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        );
      },
    );
  }

  Future<void> _getCameraImage() async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        setState(() {
          _myPickedFile = pickedFile;
        });
      } else {
        if (kDebugMode) {
          print('이미지 선택안함');
        }
      }
    } catch (e) {
      logger.info('image load error: $e');
    }
  }

  Future<void> _getPhotoLibraryImage() async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _myPickedFile = pickedFile;
        });
      } else {
        if (kDebugMode) {
          print('이미지 선택안함');
        }
      }
    } catch (e) {
      logger.info('image load error: $e');
    }
  }
}
