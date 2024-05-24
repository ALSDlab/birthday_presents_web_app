import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.hideNavBar});

  final bool Function(bool) hideNavBar;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
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
                padding: const EdgeInsets.fromLTRB(25, 30, 25, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 9),
                      child: Row(
                        children: [
                          const Icon(Icons.person),
                          SizedBox(
                            width: 15.h,
                          ),
                          Text(
                            FirebaseAuth.instance.currentUser?.displayName ??
                                '사용자',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 32.h,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                '주문내역',
                                style: TextStyle(
                                  color: Colors.black87,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  GoRouter.of(context).push(
                                      '/profile_page/order_history_page',
                                      extra: {'hideNavBar': widget.hideNavBar});
                                },
                                // style: TextButton.styleFrom(
                                //   padding: EdgeInsets.zero,
                                // ),
                                child: const Text(' > 상세보기'),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 0),
                          child: const Divider(
                            thickness: 0.5,
                            height: 4,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            '회원정보 수정',
                            style: TextStyle(color: Colors.black87),
                          ),
                        ),
                        const Divider(
                          thickness: 0.5,
                        ),
                        TextButton(
                          onPressed: () {
                            FirebaseAuth.instance.signOut();
                            GoRouter.of(context).go('/main_page');
                          },
                          child: const Text(
                            '로그아웃',
                            style: TextStyle(color: Colors.black87),
                          ),
                        ),
                        const Divider(
                          thickness: 0.5,
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            '회원탈퇴',
                            style: TextStyle(color: Colors.black87),
                          ),
                        ),
                        const Divider(
                          thickness: 0.5,
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
}
