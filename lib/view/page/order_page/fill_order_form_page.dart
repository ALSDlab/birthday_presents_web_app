import 'package:daum_postcode_search/data_model.dart';
import 'package:flutter/material.dart';
import 'package:myk_market_app/view/page/order_page/fill_order_form_page_view_model.dart';
import 'package:myk_market_app/view/page/signup_page/platform_check/check_file.dart'
    as check;

import '../../../data/model/order_model.dart';
import '../../../styles/app_text_colors.dart';

class FillOrderFormPage extends StatefulWidget {
  FillOrderFormPage({super.key, required this.forOrderItems});

  List<OrderModel> forOrderItems;

  @override
  State<FillOrderFormPage> createState() => _FillOrderFormPageState();
}

class _FillOrderFormPageState extends State<FillOrderFormPage> {
  final _formKey = GlobalKey<FormState>();

  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var addressController = TextEditingController();
  var extraAddressController = TextEditingController();
  var commentController = TextEditingController();

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
              const Text('주문 상품'),
              //TODO: 주문 상품 불러오기
              const Divider(),
              const Text('배송 정보'),
              Expanded(
                child: Form(
                  key: _formKey,
                  child: ListView.builder(
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
                                          style: const TextStyle(fontSize: 12),
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
                                                                    check.pr),
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
                                          style: const TextStyle(fontSize: 12),
                                          decoration: InputDecoration(
                                            border: const OutlineInputBorder(),
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
                        //TODO: 결재페이지로 이동
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
