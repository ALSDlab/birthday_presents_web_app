import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myk_market_app/view/page/signup_page/signup_page_view_model.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  var idController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordConfController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var addressController = TextEditingController();

  @override
  void dispose() {
    idController.dispose();
    passwordConfController.dispose();
    passwordController.dispose();
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('기본정보'),
                Text('* 표시된 항목은 필수 입력해야 합니다.'),
              ],
            ),
            Expanded(
              child: Form(
                child: ListView.builder(
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          '*',
                          style: TextStyle(color: Colors.red),
                        ),
                        Expanded(
                            child:
                                Text(SignupViewModel().gridLeftArray[index])),
                        Expanded(
                          flex: 3,
                          child: TextFormField(
                            controller: idController,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
