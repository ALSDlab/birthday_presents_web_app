import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:myk_market_app/utils/send_sms_widget.dart';

import '../../../utils/simple_logger.dart';

class CellphoneValidPage extends StatefulWidget {
  const CellphoneValidPage(
      {super.key,
      required this.verificationNumber,
      required this.servicePhoneNo,
      required this.phoneNumber});

  final String verificationNumber;
  final String servicePhoneNo;
  final String phoneNumber;

  @override
  _CellphoneValidPageState createState() => _CellphoneValidPageState();
}

class _CellphoneValidPageState extends State<CellphoneValidPage> {
  Timer? _timer;
  int _start = 180; // 3 minutes in seconds
  int _attempts = 0;
  final int _maxAttempts = 5;
  bool _isTimeout = false;
  bool _canResend = true;

  @override
  void initState() {
    super.initState();
    startTimer();
    sendVerificationCode();
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

  void sendVerificationCode() {
    // 실제로 문자 메시지를 발송하는 메서드 호출
    sendSMS(widget.servicePhoneNo, widget.phoneNumber,
        '[민영기염소탕] 인증번호\n[${widget.verificationNumber}]');
    logger.info("Sending verification code...");
  }

  void resendCode() {
    if (_attempts < _maxAttempts) {
      setState(() {
        _attempts++;
        _canResend = false;
        _isTimeout = false;
        startTimer();
        sendVerificationCode();
      });

      Future.delayed(const Duration(seconds: 60), () {
        setState(() {
          _canResend = true;
        });
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("5번 이상 시도했습니다. 다른 휴대폰으로 인증해주세요."),
      ));
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: Colors.white,
        ),
        width: 300,
        height: 300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '휴대폰 번호인증',
              style: theme.textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            Text(
              '문자를 확인하시고 인증번호를 입력해 주세요.',
              style: theme.textTheme.headlineLarge,
            ),
            const Spacer(flex: 2),
            OtpTextField(
              numberOfFields: 6,
              borderColor: Colors.black,
              focusedBorderColor: Colors.black,
              styles: const [TextStyle(color: Colors.black)],
              showFieldAsBox: false,
              borderWidth: 4.0,
              onCodeChanged: (String code) {
                if (code.length == widget.verificationNumber.length &&
                    code == widget.verificationNumber) {
                  context.pop();
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("인증 완료"),
                  ));
                }
              },
              // onSubmit: (String verificationCode) {}, // end onSubmit
            ),
            _isTimeout
                ? const Text(
                    "시간초과",
                    style: TextStyle(color: Colors.red, fontSize: 20),
                  )
                : Text(
                    "남은 시간: ${_start ~/ 60}:${_start % 60}",
                    style: const TextStyle(fontSize: 20),
                  ),
            ElevatedButton(
              onPressed: _canResend && !_isTimeout ? resendCode : null,
              child: const Text("인증번호 재발송"),
            ),
            const SizedBox(height: 20),
            Text(
              "인증 시도 횟수: $_attempts/$_maxAttempts",
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
