import 'package:daum_postcode_search/data_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myk_market_app/view/page/order_page/fill_order_form_page_view_model.dart';
import 'package:myk_market_app/view/page/signup_page/platform_check/check_file.dart'
    as check;
import 'package:provider/provider.dart';

import '../../../data/model/order_model.dart';
import '../../../utils/gif_progress_bar.dart';
import '../../../utils/simple_logger.dart';
import '../agreement_page/agreement_texts.dart';
import 'for_order_list_widget.dart';

class FillOrderFormPage extends StatefulWidget {
  const FillOrderFormPage({super.key, required this.forOrderItems});

  final List<OrderModel> forOrderItems;

  @override
  State<FillOrderFormPage> createState() => _FillOrderFormPageState();
}

class _FillOrderFormPageState extends State<FillOrderFormPage> {
  bool isAllChecked = false;
  bool isTermsNConditionsChecked = false;
  bool isTermsNConditionsOpened = false;
  bool isPersonalInfoChecked = false;
  bool isPersonalInfoOpened = false;
  bool isPersonalInfoForDeliverChecked = false;
  bool isPersonalInfoForDeliverOpened = false;
  bool inevitableChecked = false;
  bool moreDataNeed = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<FillOrderFormPageViewModel>();
    final state = viewModel.state;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
        ),
        backgroundColor: const Color(0xFF2F362F),
        scrolledUnderElevation: 0,
        title: const Text(
          '주문서 작성',
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
                                const Padding(
                                  padding: EdgeInsets.only(top: 8, left: 8),
                                  child: Text(
                                    '주문 상품',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: widget.forOrderItems.length,
                                  itemBuilder: (context, index) {
                                    final forOrderItem =
                                        widget.forOrderItems[index];
                                    return ForOrderListWidget(
                                      orderItem: forOrderItem,
                                    );
                                  },
                                ),
                                const Divider(),
                                const Padding(
                                  padding: EdgeInsets.only(top: 8, left: 8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '배송 정보',
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                      Text('* 표시된 항목은 필수 입력해야 합니다.'),
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
                                                          Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      right:
                                                                          16.0),
                                                              child:
                                                                  OutlinedButton(
                                                                style: OutlinedButton
                                                                    .styleFrom(
                                                                        // shape: const RoundedRectangleBorder(
                                                                        //     borderRadius: BorderRadius.zero),
                                                                        shape: const RoundedRectangleBorder(
                                                                            borderRadius: BorderRadius.all(Radius.circular(
                                                                                10))),
                                                                        backgroundColor:
                                                                            const Color(0xFF2F362F)),
                                                                onPressed:
                                                                    () async {
                                                                  try {
                                                                    viewModel
                                                                        .addressChangeRequest();
                                                                    DataModel?
                                                                        model =
                                                                        await Navigator.of(context)
                                                                            .push(
                                                                      MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              check.pr),
                                                                    );
                                                                    setState(
                                                                      () {
                                                                        viewModel.daumPostcodeSearchDataModel =
                                                                            model;
                                                                      },
                                                                    );
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
                                                          Expanded(
                                                            flex: 1,
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
                                                                  index],
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
                                                            .controllers[index],
                                                      ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                Visibility(
                                    visible:
                                        FirebaseAuth.instance.currentUser ==
                                            null,
                                    child: Column(
                                      children: [
                                        const Divider(),
                                        const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: 8, left: 8),
                                              child: Text(
                                                '약관 동의',
                                                style: TextStyle(fontSize: 18),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8, bottom: 8),
                                          child: Container(
                                            margin: const EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.3),
                                                  spreadRadius: 2,
                                                  blurRadius: 3,
                                                  offset: const Offset(0, 3),
                                                ),
                                              ],
                                            ),
                                            padding: const EdgeInsets.all(3),
                                            child: ListView(
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Checkbox(
                                                      value: isAllChecked,
                                                      onChanged:
                                                          (bool? newValue) {
                                                        setState(() {
                                                          isAllChecked =
                                                              newValue!;
                                                          isTermsNConditionsChecked =
                                                              newValue;
                                                          isPersonalInfoChecked =
                                                              newValue;
                                                          isPersonalInfoForDeliverChecked =
                                                              newValue;
                                                        });
                                                      },
                                                      activeColor: const Color(
                                                          0xFF2F362F),
                                                      checkColor: Colors.white,
                                                    ),
                                                    const Expanded(
                                                      child: Text(
                                                          '건강담은 민영기염소탕 흑염소진액의 모든 약관을 확인하고 전체 동의합니다.'),
                                                    ),
                                                  ],
                                                ),
                                                const Divider(
                                                  indent: 50,
                                                  endIndent: 50,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Checkbox(
                                                          value:
                                                              isTermsNConditionsChecked,
                                                          onChanged:
                                                              (bool? newValue) {
                                                            setState(() {
                                                              isTermsNConditionsChecked =
                                                                  newValue!;
                                                            });
                                                          },
                                                          activeColor:
                                                              const Color(
                                                                  0xFF2F362F),
                                                          checkColor:
                                                              Colors.white,
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
                                                        alignment:
                                                            Alignment.center,
                                                        decoration:
                                                            const BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                            Radius.circular(10),
                                                          ),
                                                        ),
                                                        child:
                                                            isTermsNConditionsOpened
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
                                                  duration: const Duration(
                                                      milliseconds: 500),
                                                  child: SizedBox(
                                                    height:
                                                        isTermsNConditionsOpened
                                                            ? null
                                                            : 0.0,
                                                    child:
                                                        Text(agreementTexts[0]),
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Checkbox(
                                                          value:
                                                              isPersonalInfoChecked,
                                                          onChanged:
                                                              (bool? newValue) {
                                                            setState(() {
                                                              isPersonalInfoChecked =
                                                                  newValue!;
                                                            });
                                                          },
                                                          activeColor:
                                                              const Color(
                                                                  0xFF2F362F),
                                                          checkColor:
                                                              Colors.white,
                                                        ),
                                                        const Text(
                                                            '(필수) 개인정보 수집 및 이용'),
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
                                                        alignment:
                                                            Alignment.center,
                                                        decoration:
                                                            const BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                            Radius.circular(10),
                                                          ),
                                                        ),
                                                        child:
                                                            isPersonalInfoOpened
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
                                                  duration: const Duration(
                                                      milliseconds: 500),
                                                  child: SizedBox(
                                                    height: isPersonalInfoOpened
                                                        ? null
                                                        : 0.0,
                                                    child:
                                                        Text(agreementTexts[1]),
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Checkbox(
                                                          value:
                                                              isPersonalInfoForDeliverChecked,
                                                          onChanged:
                                                              (bool? newValue) {
                                                            setState(() {
                                                              isPersonalInfoForDeliverChecked =
                                                                  newValue!;
                                                            });
                                                          },
                                                          activeColor:
                                                              const Color(
                                                                  0xFF2F362F),
                                                          checkColor:
                                                              Colors.white,
                                                        ),
                                                        const Text(
                                                            '(선택) 개인정보 수집 및 이용'),
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
                                                        alignment:
                                                            Alignment.center,
                                                        decoration:
                                                            const BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                            Radius.circular(10),
                                                          ),
                                                        ),
                                                        child:
                                                            isPersonalInfoForDeliverOpened
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
                                                  duration: const Duration(
                                                      milliseconds: 500),
                                                  child: SizedBox(
                                                    height:
                                                        isPersonalInfoForDeliverOpened
                                                            ? null
                                                            : 0.0,
                                                    child:
                                                        Text(agreementTexts[2]),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ))
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Visibility(
                              visible: (inevitableChecked == true &&
                                  isTermsNConditionsChecked == false),
                              child: const Text(
                                '(필수) 이용약관 을 체크해주세요.',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: (inevitableChecked == true &&
                                isTermsNConditionsChecked == true &&
                                isPersonalInfoChecked == false),
                            child: const Text(
                              '(필수) 개인정보 수집 및 이용 을 체크해주세요.',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                          Visibility(
                            visible: (moreDataNeed),
                            child: const Text(
                              '배송정보를 다시 확인해 주세요.',
                              style: TextStyle(color: Colors.red),
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
                                        context.pop(true);
                                      },
                                      child: const Text(
                                        '취소',
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
                                      onPressed: () async {
                                        if ((viewModel.currentUser.isEmpty) &&
                                            (isTermsNConditionsChecked ==
                                                    false ||
                                                isPersonalInfoChecked ==
                                                    false)) {
                                          setState(() {
                                            inevitableChecked = true;
                                          });
                                        } else if (viewModel
                                                    .controllers[0].text ==
                                                '' ||
                                            viewModel.controllers[1].text ==
                                                '' ||
                                            viewModel.controllers[2].text ==
                                                '') {
                                          setState(() {
                                            moreDataNeed = true;
                                          });
                                        } else {
                                          final orderedDate = DateTime.now()
                                              .toString()
                                              .substring(2, 10)
                                              .replaceAll('-', '');
                                          final ordererId = viewModel
                                                  .currentUser.isEmpty
                                              ? 'notRegistered'
                                              : viewModel.currentUser.first.id;
                                          final personalInfoForDeliverChecked =
                                              viewModel.currentUser.isEmpty
                                                  ? isPersonalInfoForDeliverChecked
                                                  : viewModel.currentUser.first
                                                      .checked;
                                          final ordererName =
                                              viewModel.controllers[0].text;
                                          final ordererPhoneNo =
                                              viewModel.controllers[1].text;
                                          final ordererPostcode =
                                              viewModel.controllers[2].text;

                                          final ordererAddress =
                                              viewModel.controllers[3].text;
                                          final ordererAddressDetail =
                                              viewModel.controllers[4].text;
                                          await Future.forEach(
                                              widget.forOrderItems
                                                  .asMap()
                                                  .entries, (entry) async {
                                            final index = entry.key;
                                            final item = entry.value;
                                            await viewModel.saveOrdersInfo(
                                              item,
                                              index.toString(),
                                              orderedDate,
                                              personalInfoForDeliverChecked,
                                              ordererId,
                                              ordererName,
                                              ordererPhoneNo,
                                              ordererAddress,
                                              ordererAddressDetail,
                                              ordererPostcode,
                                            );
                                          });

                                          if (context.mounted) {
                                            GoRouter.of(context).push(
                                                '/shopping_cart_page/fill_order_page/pay_page',
                                                extra: {
                                                  'orderModelList':
                                                      widget.forOrderItems
                                                });
                                          }
                                        }
                                      },
                                      child: const Text(
                                        '다음',
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
