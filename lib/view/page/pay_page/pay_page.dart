import 'package:daum_postcode_search/data_model.dart';
import 'package:flutter/material.dart';
import 'package:myk_market_app/view/page/order_page/fill_order_form_page_view_model.dart';
import 'package:myk_market_app/view/page/signup_page/platform_check/check_file.dart'
as check;

import '../../../data/model/order_model.dart';
import '../../../styles/app_text_colors.dart';
import '../agreement_page/agreement_texts.dart';
import '../order_page/for_order_list_widget.dart';

class PayPage extends StatefulWidget {
  PayPage({super.key, required this.forOrderItems});

  List<OrderModel> forOrderItems;

  @override
  State<PayPage> createState() => _PayPageState();
}

class _PayPageState extends State<PayPage> {
  bool isAllChecked = false;
  bool isTermsNConditionsChecked = false;
  bool isTermsNConditionsOpened = false;
  bool isPersonalInfoChecked = false;
  bool isPersonalInfoOpened = false;
  bool isPersonalInfoForDeliverChecked = false;
  bool isPersonalInfoForDeliverOpened = false;
  bool inevitableChecked = false;

  final _formKey = GlobalKey<FormState>();

  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var addressController = TextEditingController();
  var extraAddressController = TextEditingController();
  var commentController = TextEditingController();

  final getUserList = [];

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    extraAddressController.dispose();
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controllers = [
      nameController,
      phoneController,
      addressController,
      extraAddressController,
      commentController
    ];

    final viewModel = FillOrderFormPageViewModel();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '주문서 작성',
                    style: TextStyle(fontFamily: 'Jalnan', fontSize: 20),
                  ),
                  Text('* 표시된 항목은 필수 입력해야 합니다.'),
                ],
              ),
              const Divider(),
              Expanded(
                child: ListView(
                  children: [
                    const Text(
                      '주문 상품',
                      style: TextStyle(fontSize: 18),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16, bottom: 16),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: widget.forOrderItems.length,
                        itemBuilder: (context, index) {
                          final forOrderItem = widget.forOrderItems[index];
                          return ForOrderListWidget(
                            orderItem: forOrderItem,
                          );
                        },
                      ),
                    ),
                    const Divider(),
                    const Text(
                      '배송 정보',
                      style: TextStyle(fontSize: 18),
                    ),
                    Form(
                      key: _formKey,
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 4,
                        padding: const EdgeInsets.all(16.0),
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
                                  child: Text(FillOrderFormPageViewModel()
                                      .gridLeftArray[index]),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: index == 2
                                      ? Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      TextFormField(
                                        style:
                                        const TextStyle(fontSize: 12),
                                        decoration: InputDecoration(
                                            border:
                                            const OutlineInputBorder(),
                                            hintText: (viewModel
                                                .daumPostcodeSearchDataModel
                                                ?.zonecode !=
                                                null)
                                                ? viewModel
                                                .daumPostcodeSearchDataModel!
                                                .zonecode
                                                : '',
                                            suffixIcon: ElevatedButton(
                                                onPressed: () async {
                                                  try {
                                                    DataModel model =
                                                    await Navigator.of(
                                                        context)
                                                        .push(
                                                      MaterialPageRoute(
                                                          builder:
                                                              (context) =>
                                                          check
                                                              .pr),
                                                    );
                                                    setState(
                                                          () {
                                                        viewModel
                                                            .daumPostcodeSearchDataModel =
                                                            model;
                                                      },
                                                    );
                                                  } catch (error) {
                                                    print(error);
                                                  }
                                                },
                                                child: Text('주소검색'))),
                                        readOnly: true,
                                      ),
                                      TextFormField(
                                        style:
                                        const TextStyle(fontSize: 12),
                                        decoration: InputDecoration(
                                          border:
                                          const OutlineInputBorder(),
                                          hintText: (viewModel
                                              .daumPostcodeSearchDataModel
                                              ?.address !=
                                              null)
                                              ? viewModel
                                              .daumPostcodeSearchDataModel!
                                              .address
                                              : '',
                                        ),
                                        readOnly: true,
                                      ),
                                    ],
                                  )
                                      : TextFormField(
                                    style: const TextStyle(fontSize: 12),
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                    ),
                                    controller: controllers[index],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    // (getUserList.isEmpty)
                    //     ?
                    const Divider(),
                    const Text(
                      '약관 동의',
                      style: TextStyle(fontSize: 18),
                    ),
                    ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: isAllChecked,
                              onChanged: (bool? newValue) {
                                setState(() {
                                  isAllChecked = newValue!;
                                  isTermsNConditionsChecked =
                                      newValue;
                                  isPersonalInfoChecked = newValue;
                                  isPersonalInfoForDeliverChecked =
                                      newValue;
                                });
                              },
                              activeColor: Colors.green,
                              checkColor: Colors.white,
                            ),
                            const Text(
                                '구록원의 모든 약관을 확인하고 전체 동의합니다.'),
                          ],
                        ),
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value: isTermsNConditionsChecked,
                                  onChanged: (bool? newValue) {
                                    setState(() {
                                      isTermsNConditionsChecked =
                                      newValue!;
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
                                  '닫기',
                                )
                                    : const Text(
                                  '열기',
                                ),
                              ),
                            ),
                          ],
                        ),
                        AnimatedSize(
                          duration:
                          const Duration(milliseconds: 500),
                          child: SizedBox(
                            height: isTermsNConditionsOpened
                                ? null
                                : 0.0,
                            child: Text(agreementTexts[0]),
                          ),
                        ),
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value: isPersonalInfoChecked,
                                  onChanged: (bool? newValue) {
                                    setState(() {
                                      isPersonalInfoChecked =
                                      newValue!;
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
                                  isPersonalInfoOpened =
                                  !isPersonalInfoOpened;
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
                                  '닫기',
                                )
                                    : const Text(
                                  '열기',
                                ),
                              ),
                            ),
                          ],
                        ),
                        AnimatedSize(
                          duration:
                          const Duration(milliseconds: 500),
                          child: SizedBox(
                            height:
                            isPersonalInfoOpened ? null : 0.0,
                            child: Text(agreementTexts[1]),
                          ),
                        ),
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value:
                                  isPersonalInfoForDeliverChecked,
                                  onChanged: (bool? newValue) {
                                    setState(() {
                                      isPersonalInfoForDeliverChecked =
                                      newValue!;
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
                                child:
                                isPersonalInfoForDeliverOpened
                                    ? const Text(
                                  '닫기',
                                )
                                    : const Text(
                                  '열기',
                                ),
                              ),
                            ),
                          ],
                        ),
                        AnimatedSize(
                          duration:
                          const Duration(milliseconds: 500),
                          child: SizedBox(
                            height: isPersonalInfoForDeliverOpened
                                ? null
                                : 0.0,
                            child: Text(agreementTexts[2]),
                          ),
                        ),
                      ],
                    ),
                    Visibility(
                      visible: (inevitableChecked == true &&
                          isTermsNConditionsChecked == false),
                      child: const Text('(필수) 이용약관 을 체크해주세요.'),
                    ),
                    Visibility(
                      visible: (inevitableChecked == true &&
                          isTermsNConditionsChecked == true &&
                          isPersonalInfoChecked == false),
                      child:
                      const Text('(필수) 개인정보 수집 및 이용 을 체크해주세요.'),
                    )
                    // : Container()
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
                      child: const Text('취소'),
                    ),
                    TextButton(
                      style: const ButtonStyle(
                          backgroundColor:
                          MaterialStatePropertyAll(AppColors.mainButton)),
                      onPressed: () {
                        if (isTermsNConditionsChecked == false ||
                            isPersonalInfoChecked == false) {
                          setState(() {
                            inevitableChecked = true;
                          });
                        } else {
                          //TODO: 결재페이지로 이동
                        }
                      },
                      child: const Text('결제하기'),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
