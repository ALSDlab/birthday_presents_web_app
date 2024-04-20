import 'package:daum_postcode_search/data_model.dart';
import 'package:flutter/material.dart';
import 'package:myk_market_app/view/page/signup_page/platform_check/check_file.dart' as check;
import 'package:myk_market_app/styles/app_text_colors.dart';
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

  DataModel? _daumPostcodeSearchDataModel;

  @override
  void dispose() {
    idController.dispose();
    passwordConfController.dispose();
    passwordController.dispose();
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controllers = [
      idController,
      passwordController,
      passwordConfController,
      nameController,
      phoneController
    ];
    TableRow buildTableRow(String label, String value) {
      return TableRow(
        children: [
          TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: Text(label, textAlign: TextAlign.center),
          ),
          TableCell(
            child: Text(value, textAlign: TextAlign.center),
          ),
        ],
      );
    }

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
            Divider(),
            Expanded(
              child: Form(
                child: ListView.builder(
                  itemCount: 6,
                  padding: EdgeInsets.all(16.0),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            '*',
                            style: TextStyle(color: Colors.red),
                          ),
                          Expanded(
                            child: Text(SignupViewModel().gridLeftArray[index]),
                          ),
                          Expanded(
                            flex: 3,
                            child: index != 5
                                ? TextFormField(
                                    decoration: const InputDecoration(
                                      border:
                                          OutlineInputBorder(gapPadding: 8.0),
                                    ),
                                    controller: controllers[index],
                                  )
                                : Text('주소 받아오는 곳'),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  ElevatedButton.icon(
                    onPressed: () async {
                      try {
                        DataModel model = await Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) =>
                                  check.pr),
                        );
                        setState(
                          () {
                            _daumPostcodeSearchDataModel = model;
                          },
                        );
                      } catch (error) {
                        print(error);
                      }
                    },
                    icon: const Icon(Icons.search),
                    label: const Text("주소 검색"),
                  ),
                  Visibility(
                    visible: _daumPostcodeSearchDataModel != null,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: RichText(
                                text: TextSpan(
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 20),
                                  children: [
                                    WidgetSpan(
                                      child: Icon(
                                        Icons.check_circle,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                      ),
                                    ),
                                    const TextSpan(text: "주소 검색 결과"),
                                  ],
                                ),
                              ),
                            ),
                            Table(
                              border: TableBorder.symmetric(
                                  inside: const BorderSide(color: Colors.grey)),
                              columnWidths: const {
                                0: FlexColumnWidth(1),
                                1: FlexColumnWidth(2),
                              },
                              children: [
                                buildTableRow(
                                  "한글주소",
                                  _daumPostcodeSearchDataModel?.address ?? "",
                                ),
                                buildTableRow(
                                  "영문주소",
                                  _daumPostcodeSearchDataModel
                                          ?.addressEnglish ??
                                      "",
                                ),
                                buildTableRow(
                                  "우편번호",
                                  _daumPostcodeSearchDataModel?.zonecode ?? "",
                                ),
                                buildTableRow(
                                  "지번주소",
                                  _daumPostcodeSearchDataModel
                                          ?.autoJibunAddress ??
                                      "",
                                ),
                                buildTableRow(
                                  "지번주소(영문)",
                                  _daumPostcodeSearchDataModel
                                          ?.autoJibunAddressEnglish ??
                                      "",
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('취소'),
                  ),
                  TextButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(AppColors.mainButton)),
                    onPressed: () {},
                    child: Text('회원가입'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
