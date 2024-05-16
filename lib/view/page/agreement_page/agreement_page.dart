import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../styles/app_text_colors.dart';
import 'agreement_texts.dart';

class AgreementPage extends StatefulWidget {
  const AgreementPage({super.key});

  @override
  State<AgreementPage> createState() => _AgreementPageState();
}

class _AgreementPageState extends State<AgreementPage> {
  bool isAllChecked = false;
  bool isTermsNConditionsChecked = false;
  bool isTermsNConditionsOpened = false;
  bool isPersonalInfoChecked = false;
  bool isPersonalInfoOpened = false;
  bool isPersonalInfoForDeliverChecked = false;
  bool isPersonalInfoForDeliverOpened = false;
  bool inevitableChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF2F362F),
        title: const Text(
          '회원가입',
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
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 16.0),
                  child: Center(
                      child: Text(
                    '약관 동의',
                    style: TextStyle(fontSize: 20),
                  )),
                ),
                Expanded(
                  child: ListView(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Checkbox(
                            value: isAllChecked,
                            onChanged: (bool? newValue) {
                              setState(() {
                                isAllChecked = newValue!;
                                isTermsNConditionsChecked = newValue;
                                isPersonalInfoChecked = newValue;
                                isPersonalInfoForDeliverChecked = newValue;
                              });
                            },
                            activeColor: Colors.green,
                            checkColor: Colors.white,
                          ),
                          const Expanded(child: Text('건강담은 민영기염소탕 흑염소진액의 모든 약관을 확인하고 전체 동의합니다.', maxLines: 2)),
                        ],
                      ),
                      const Divider(indent: 50,endIndent: 50,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: isTermsNConditionsChecked,
                                onChanged: (bool? newValue) {
                                  setState(() {
                                    isTermsNConditionsChecked = newValue!;
                                  });
                                },
                                activeColor: Colors.green,
                                checkColor: Colors.white,
                              ),
                              const Text('(필수) 이용약관'),
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                isTermsNConditionsOpened =
                                    !isTermsNConditionsOpened;
                              });
                            },
                            child: Container(
                              height: 40,
                              width: 100,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: isTermsNConditionsOpened
                                  ? const Text(
                                      '닫기 ▲',
                                    )
                                  : const Text(
                                      '열기 ▼',
                                    ),
                            ),
                          ),
                        ],
                      ),
                      AnimatedSize(
                        duration: const Duration(milliseconds: 500),
                        child: SizedBox(
                          height: isTermsNConditionsOpened ? null : 0.0,
                          child: Text(agreementTexts[0]),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: isPersonalInfoChecked,
                                onChanged: (bool? newValue) {
                                  setState(() {
                                    isPersonalInfoChecked = newValue!;
                                  });
                                },
                                activeColor: Colors.green,
                                checkColor: Colors.white,
                              ),
                              const Text('(필수) 개인정보 수집 및 이용'),
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                isPersonalInfoOpened = !isPersonalInfoOpened;
                              });
                            },
                            child: Container(
                              height: 40,
                              width: 100,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: isPersonalInfoOpened
                                  ? const Text(
                                      '닫기 ▲',
                                    )
                                  : const Text(
                                      '열기 ▼',
                                    ),
                            ),
                          ),
                        ],
                      ),
                      AnimatedSize(
                        duration: const Duration(milliseconds: 500),
                        child: SizedBox(
                          height: isPersonalInfoOpened ? null : 0.0,
                          child: Text(agreementTexts[1]),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: isPersonalInfoForDeliverChecked,
                                onChanged: (bool? newValue) {
                                  setState(() {
                                    isPersonalInfoForDeliverChecked = newValue!;
                                  });
                                },
                                activeColor: Colors.green,
                                checkColor: Colors.white,
                              ),
                              const Text('(선택) 개인정보 수집 및 이용'),
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                isPersonalInfoForDeliverOpened =
                                    !isPersonalInfoForDeliverOpened;
                              });
                            },
                            child: Container(
                              height: 40,
                              width: 100,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: isPersonalInfoForDeliverOpened
                                  ? const Text(
                                      '닫기 ▲',
                                    )
                                  : const Text(
                                      '열기 ▼',
                                    ),
                            ),
                          ),
                        ],
                      ),
                      AnimatedSize(
                        duration: const Duration(milliseconds: 500),
                        child: SizedBox(
                          height: isPersonalInfoForDeliverOpened ? null : 0.0,
                          child: Text(agreementTexts[2]),
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: (inevitableChecked == true &&
                      isTermsNConditionsChecked == false),
                  child: const Text('(필수) 이용약관 을 체크해주세요.',style: TextStyle(color: Colors.red),),
                ),
                Visibility(
                  visible: (inevitableChecked == true &&
                      isTermsNConditionsChecked == true &&
                      isPersonalInfoChecked == false),
                  child: const Text('(필수) 개인정보 수집 및 이용 을 체크해주세요.',style: TextStyle(color: Colors.red)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        context.pop();
                      },
                      style: ButtonStyle(
                          minimumSize:
                              MaterialStateProperty.all(Size(100.w, 40.h)),
                          //테두리 모양 조절
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(side: const BorderSide(width: 0.5,color: Colors.black),
                              borderRadius: BorderRadius.circular(23))),
                          backgroundColor:
                              MaterialStateProperty.all(const Color(0xFFFFF8E7))),
                      child: const Text(
                        '이전',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (isTermsNConditionsChecked == false ||
                            isPersonalInfoChecked == false) {
                          setState(() {
                            inevitableChecked = true;
                          });
                        } else {
                          context.push('/profile_page/login_page/agreement_page/signup_page',
                              extra: isPersonalInfoForDeliverChecked);
                        }
                      },
                      style: ButtonStyle(
                          minimumSize:
                              MaterialStateProperty.all(Size(100.w, 40.h)),
                          //테두리 모양 조절
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(23))),
                          backgroundColor:
                              MaterialStateProperty.all(AppColors.icon)),
                      child: const Text(
                        '다음',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
