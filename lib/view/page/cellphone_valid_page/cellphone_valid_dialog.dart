import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'celllphone_vaild_page_view_model.dart';

class CellphoneValidPage extends StatefulWidget {
  const CellphoneValidPage(
      {super.key, required this.servicePhoneNo, required this.phoneNumber});

  final String servicePhoneNo;
  final String phoneNumber;

  @override
  _CellphoneValidPageState createState() => _CellphoneValidPageState();
}

class _CellphoneValidPageState extends State<CellphoneValidPage> {
  Timer? _timer;
  bool _isTimeout = true;
  bool _canResend = true;
  bool _correctVerificationCode = true;
  int _start = 180; // 3 minutes in seconds
  int _attempts = 0;
  final int _maxAttempts = 5;

  @override
  void initState() {
    super.initState();
    init();
    // startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void init() async {
    _attempts = await CelllphoneVaildPageViewModel()
        .getVerificationPhoneNo(widget.phoneNumber);
    setState(() {
      _attempts;
    });
    if (_attempts >= 5 && (_canResend || _isTimeout)) {
      // 5번 시도 및 시간초과 시 false 반환. 다른번호 유도
      Navigator.pop(context, false);
    }
  }

  void startTimer() {
    _start = 180;
    _isTimeout = false;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_start > 0) {
          _start--;
        } else {
          _isTimeout = true;
          _timer?.cancel();
        }
      });
    });
  }

  Future<void> sendCode(String phoneNumber) async {
    if (_attempts < _maxAttempts) {
      setState(() {
        _canResend = false;
        _isTimeout = false;
      });
      startTimer();
      await CelllphoneVaildPageViewModel()
          .sendVerificationCode(widget.servicePhoneNo, widget.phoneNumber);
      _attempts = (await CelllphoneVaildPageViewModel()
          .getVerificationPhoneNo(widget.phoneNumber));
      Future.delayed(const Duration(seconds: 60), () {
        if (mounted) {
          setState(() {
            _canResend = true;
          });
        }
      });
    } else {
      setState(() {
        _canResend = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = CelllphoneVaildPageViewModel();

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
              const Text('휴대폰 번호인증',
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16)),
              const SizedBox(height: 16),
              const Text('문자를 확인하시고 인증번호를 입력해 주세요.',
                  style: TextStyle(fontSize: 13)),
              const SizedBox(height: 16),
              OtpTextField(
                fieldWidth: 35,
                numberOfFields: 6,
                borderColor: Colors.black,
                focusedBorderColor: Colors.black,
                styles: const [
                  TextStyle(color: Colors.black),
                  TextStyle(color: Colors.black),
                  TextStyle(color: Colors.black),
                  TextStyle(color: Colors.black),
                  TextStyle(color: Colors.black),
                  TextStyle(color: Colors.black)
                ],
                showFieldAsBox: false,
                borderWidth: 4.0,
                onCodeChanged: (String code) {
                  setState(() {
                    _correctVerificationCode = true;
                  });
                },
                clearText: !_correctVerificationCode,
                onSubmit: (String verificationCode) {
                  if (verificationCode == viewModel.verificationNumber) {
                    viewModel.clearVerificationPhoneNo();
                    // 인증성공. true 반환
                    Navigator.pop(context, true);
                  } else if (verificationCode.length ==
                          viewModel.verificationNumber.length &&
                      verificationCode != viewModel.verificationNumber) {
                    // 인증번호 잘못 입력 시
                    setState(() {
                      _correctVerificationCode = false;
                    });
                  }
                }, // end onSubmit
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _start <= 0
                        ? const Text(
                            "시간초과",
                            style: TextStyle(color: Colors.red, fontSize: 11),
                          )
                        : Text(
                            "남은 시간: ${_start ~/ 60}:${NumberFormat("00").format(_start % 60)}",
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 11),
                          ),
                    (!_correctVerificationCode)
                        ? const Text(
                            "인증번호 오류",
                            style: TextStyle(color: Colors.red, fontSize: 11),
                          )
                        : const SizedBox()
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                child: ElevatedButton(
                    style: OutlinedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        backgroundColor: _canResend && _isTimeout
                            ? const Color(0xFF2F362F)
                            : Colors.grey),
                    onPressed: _canResend && _isTimeout
                        ? () async {
                            await sendCode(widget.phoneNumber);
                            setState(() {
                              _attempts;
                            });
                            if (_attempts >= 5) {
                              // 5번 시도 및 시간초과 시 false 반환. 다른번호 유도
                              Future.delayed(Duration(seconds: _start), () {
                                Navigator.pop(context, false);
                              });
                            }
                          }
                        : () {},
                    child: Text("인증번호 발송 ($_attempts/$_maxAttempts)",
                        style: const TextStyle(
                            fontSize: 14, color: Colors.white))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
