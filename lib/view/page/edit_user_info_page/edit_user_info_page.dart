import 'package:daum_postcode_search/data_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myk_market_app/view/page/edit_user_info_page/edit_user_info_view_model.dart';
import 'package:myk_market_app/view/page/signup_page/platform_check/check_file.dart'
    as check;
import 'package:provider/provider.dart';

import '../../../utils/gif_progress_bar.dart';
import '../../../utils/simple_logger.dart';

class EditUserInfoPage extends StatefulWidget {
  const EditUserInfoPage({super.key});

  @override
  State<EditUserInfoPage> createState() => _EditUserInfoPageState();
}

class _EditUserInfoPageState extends State<EditUserInfoPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController idController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController postcodeController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController extraAddressController = TextEditingController();

  bool isValidPhoneNo = false;
  String servicePhoneNo = '01058377427';

  String? _errorIdText;
  String? _errorNameText;

  @override
  void dispose() {
    idController.dispose();
    nameController.dispose();
    phoneController.dispose();
    postcodeController.dispose();
    addressController.dispose();
    extraAddressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> textField = [
      'name',
      'phone',
      'post',
      'address',
      'extraAddress'
    ];

    final viewModel = context.watch<EditUserInfoViewModel>();
    final state = viewModel.state;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF2F362F),
        scrolledUnderElevation: 0,
        title: const Text(
          '회원정보 수정',
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
              child: (state.isLoading)
                  ? const Center(
                      child: GifProgressBar(),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView(
                              physics: const BouncingScrollPhysics(),
                              children: [
                                // TODO: 아이디, 비밀번호 변경 위젯 추가

                                const Divider(),
                                const Padding(
                                  padding: EdgeInsets.only(top: 8, left: 8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '회원 정보',
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                      Text('* 표시된 항목은 필수 입력돼야 합니다.'),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 8, bottom: 8),
                                  child: Container(
                                    margin: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20.0),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.3),
                                          spreadRadius: 2,
                                          blurRadius: 3,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    padding: const EdgeInsets.all(3),
                                    child: Form(
                                      key: _formKey,
                                      child: ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: 5,
                                        padding: const EdgeInsets.all(8.0),
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: (index == 2)
                                                ? const EdgeInsets.fromLTRB(
                                                    4, 4, 4, 0)
                                                : const EdgeInsets.all(4.0),
                                            child: Column(
                                              children: [
                                                (index == 3)
                                                    ? const SizedBox(
                                                        height: 0.5,
                                                      )
                                                    : Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            (index != 4)
                                                                ? '* '
                                                                : '  ',
                                                            style:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .red),
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                              viewModel
                                                                      .gridLeftArray[
                                                                  index],
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize: 15),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                index == 2
                                                    ? Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Expanded(
                                                            flex: 1,
                                                            child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        right:
                                                                            16.0),
                                                                child:
                                                                    OutlinedButton(
                                                                  style: OutlinedButton.styleFrom(
                                                                      // shape: const RoundedRectangleBorder(
                                                                      //     borderRadius: BorderRadius.zero),
                                                                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                                                      backgroundColor: const Color(0xFF2F362F)),
                                                                  onPressed:
                                                                      () async {
                                                                    try {
                                                                      viewModel
                                                                          .addressChangeRequest();
                                                                      dynamic
                                                                          model =
                                                                          await Navigator.of(context)
                                                                              .push(
                                                                        MaterialPageRoute(
                                                                            builder: (context) =>
                                                                                check.pr),
                                                                      );
                                                                      if (model
                                                                          is DataModel) {
                                                                        viewModel.setAddress(
                                                                            model.zonecode,
                                                                            model.address);
                                                                      } else if (model is Map<
                                                                          String,
                                                                          String>) {
                                                                        viewModel.setAddress(
                                                                            model['postcode']!,
                                                                            model['address']!);
                                                                      }
                                                                      viewModel
                                                                          .fillTextField();
                                                                    } catch (error) {
                                                                      logger.info(
                                                                          error);
                                                                    }
                                                                  },
                                                                  child:
                                                                      const Text(
                                                                    '주소검색',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                )),
                                                          ),
                                                          Expanded(
                                                            flex: 2,
                                                            child:
                                                                TextFormField(
                                                              readOnly: true,
                                                              style:
                                                                  const TextStyle(
                                                                      fontSize:
                                                                          15),
                                                              decoration:
                                                                  InputDecoration(
                                                                contentPadding:
                                                                    const EdgeInsets
                                                                        .fromLTRB(
                                                                        10,
                                                                        5,
                                                                        0,
                                                                        5),
                                                                border:
                                                                    OutlineInputBorder(
                                                                  borderSide:
                                                                      const BorderSide(
                                                                    width: 0.1,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                ),
                                                              ),
                                                              controller: viewModel
                                                                      .controllers[
                                                                  textField[
                                                                      index]],
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    : TextFormField(
                                                        readOnly: (index == 3)
                                                            ? true
                                                            : false,
                                                        style: const TextStyle(
                                                            fontSize: 15),
                                                        decoration:
                                                            InputDecoration(
                                                          contentPadding:
                                                              const EdgeInsets
                                                                  .fromLTRB(
                                                                  10, 5, 0, 5),
                                                          border:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                const BorderSide(
                                                              width: 0.1,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                        ),
                                                        controller: viewModel
                                                                .controllers[
                                                            textField[index]],
                                                      ),
                                              ],
                                            ),
                                          );
                                        },
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
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(child: Container()),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                      ),
                                      onPressed: () {
                                        GoRouter.of(context).pop(true);
                                      },
                                      child: const Text(
                                        '이전',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                          // shape: const RoundedRectangleBorder(
                                          //     borderRadius: BorderRadius.zero),
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                          backgroundColor:
                                              const Color(0xFF2F362F)),
                                      onPressed: () async {},
                                      // {
                                      //   if ((viewModel.currentUser.isEmpty) &&
                                      //       (isTermsNConditionsChecked ==
                                      //           false ||
                                      //           isPersonalInfoChecked ==
                                      //               false)) {
                                      //     setState(() {
                                      //       inevitableChecked = true;
                                      //     });
                                      //   } else if (viewModel.controllers['name']
                                      //       ?.text ==
                                      //       '' ||
                                      //       viewModel.controllers['phone']
                                      //           ?.text ==
                                      //           '' ||
                                      //       viewModel.controllers['post']
                                      //           ?.text ==
                                      //           '') {
                                      //     setState(() {
                                      //       moreDataNeed = true;
                                      //     });
                                      //   } else {
                                      //     final orderedDate = DateTime.now()
                                      //         .toString()
                                      //         .substring(2, 10)
                                      //         .replaceAll('-', '');
                                      //     final ordererId = viewModel
                                      //         .currentUser.isEmpty
                                      //         ? 'notRegistered'
                                      //         : viewModel.currentUser.first.id;
                                      //     final personalInfoForDeliverChecked =
                                      //     viewModel.currentUser.isEmpty
                                      //         ? isPersonalInfoForDeliverChecked
                                      //         : viewModel.currentUser.first
                                      //         .checked;
                                      //     final ordererName = viewModel
                                      //         .controllers['name']?.text;
                                      //     final ordererPhoneNo = viewModel
                                      //         .controllers['phone']?.text;
                                      //     final ordererPostcode = viewModel
                                      //         .controllers['post']?.text;
                                      //
                                      //     final ordererAddress = viewModel
                                      //         .controllers['address']?.text;
                                      //     final ordererAddressDetail = viewModel
                                      //         .controllers['extraAddress']
                                      //         ?.text;
                                      //     await Future.forEach(
                                      //         widget.forOrderItems
                                      //             .asMap()
                                      //             .entries, (entry) async {
                                      //       final index = entry.key;
                                      //       final item = entry.value;
                                      //       await viewModel.saveOrdersInfo(
                                      //         item,
                                      //         index.toString(),
                                      //         orderedDate,
                                      //         personalInfoForDeliverChecked,
                                      //         ordererId,
                                      //         ordererName!,
                                      //         ordererPhoneNo!,
                                      //         ordererAddress!,
                                      //         ordererAddressDetail!,
                                      //         ordererPostcode!,
                                      //       );
                                      //     });
                                      //   }
                                      // },
                                      child: const Text(
                                        '변경',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(child: Container()),
                              ],
                            ),
                          )
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
