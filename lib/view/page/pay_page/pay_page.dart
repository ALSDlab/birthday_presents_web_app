import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:myk_market_app/data/model/order_model.dart';
import 'package:myk_market_app/view/page/pay_page/pay_address_widget.dart';
import 'package:myk_market_app/view/page/pay_page/pay_page_view_model.dart';
import 'package:provider/provider.dart';

import '../../../data/model/coupons_model.dart';
import '../../../data/model/sales_model.dart';
import '../../../utils/gif_progress_bar.dart';
import '../order_page/for_order_list_widget.dart';

class PayPage extends StatefulWidget {
  PayPage(
      {super.key,
      required this.forOrderItems,
      required this.hideNavBar,
      this.newOrderCreated = false});

  final List<OrderModel> forOrderItems;
  final bool Function(bool) hideNavBar;
  bool? newOrderCreated;

  @override
  State<PayPage> createState() => _PayPageState();
}

class _PayPageState extends State<PayPage> {
  bool finalConfirmNeed = false;
  bool finalConfirmDemand = false;
  bool isCalculating = false;
  Map<String, SalesModel?> salesContentsList = {};
  num salePrice = 0;
  CouponsModel? selectedCoupon;
  List<CouponsModel?> myCouponList = [];

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      final payViewModel = context.read<PayPageViewModel>();
      if (widget.forOrderItems.isNotEmpty) {
        await payViewModel.fetchMyOrderData(widget.forOrderItems.first.orderId);
        salesContentsList =
            await payViewModel.getSalesContentsList(widget.forOrderItems);
        for (int i = 0; i < widget.forOrderItems.length; i++) {
          salePrice += calculatedSalesPrice(widget.forOrderItems[i].price,
                  salesContentsList[widget.forOrderItems[i].productId]) *
              widget.forOrderItems[i].count;
        }
      }
      if (mounted && widget.newOrderCreated == true) {
        payViewModel.showSnackbar(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<PayPageViewModel>();
    final state = viewModel.state;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF2F362F),
        scrolledUnderElevation: 0,
        title: const Text(
          '주문 확인',
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
                  ? Center(
                      child: GifProgressBar(),
                    )
                  : Padding(
                      padding: EdgeInsets.only(
                          top: 5.0,
                          left: 5.0,
                          right: 5.0,
                          bottom: state.showSnackbarPadding
                              ? MediaQuery.of(context).padding.bottom + 48.0
                              : 0), // Snackbar 높이만큼 padding 추가
                      child: Column(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 8, left: 8, right: 8),
                              child: ListView(
                                physics: const BouncingScrollPhysics(),
                                children: [
                                  Row(
                                    children: [
                                      const Text(
                                        '주문 번호',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: Text(
                                            (state.orderItems.isNotEmpty)
                                                ? state.orderItems.first.orderId
                                                : '',
                                            style: const TextStyle(
                                                color: Color(0xFF019934),
                                                fontSize: 16,
                                                fontWeight: FontWeight.w900),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  const Divider(),
                                  const Text(
                                    '배송지 정보',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8, bottom: 8),
                                    child: (state.orderItems.isNotEmpty)
                                        ? PayAddressWidget(
                                            orderFirstItem:
                                                state.orderItems.first)
                                        : Center(
                                            child: GifProgressBar(),
                                          ),
                                  ),
                                  const Divider(),
                                  const Text(
                                    '주문 상품',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: state.orderItems.length,
                                    itemBuilder: (context, index) {
                                      final forOrderItem =
                                          state.orderItems[index];
                                      return ForOrderListWidget(
                                        orderItem: forOrderItem,
                                        forConfirm: true,
                                        salesContent: salesContentsList[
                                            state.orderItems[index].productId],
                                      );
                                    },
                                  ),
                                  const Divider(
                                    indent: 30,
                                    endIndent: 30,
                                    height: 0.2,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16.0, right: 16),
                                    child: Column(
                                      children: [
                                        // 상품금액 총합
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              '상품금액',
                                              style: TextStyle(fontSize: 14),
                                            ),
                                            Text(
                                              '${NumberFormat('###,###,###,###').format(state.orderItems.fold(0, (e, v) => e + int.parse(v.price.replaceAll(',', '')) * v.count))} 원',
                                              style:
                                                  const TextStyle(fontSize: 13),
                                            )
                                          ],
                                        ),
                                        // 할인되는 금액 총합
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              '할인금액',
                                              style: TextStyle(fontSize: 12),
                                            ),
                                            Text(
                                              '- ${NumberFormat('###,###,###,###').format(salePrice)} 원',
                                              style:
                                                  const TextStyle(fontSize: 12),
                                            )
                                          ],
                                        ),
                                        // 쿠폰적용 할인금액
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              '쿠폰사용',
                                              style: TextStyle(fontSize: 12),
                                            ),
                                            Text(
                                              '- ${NumberFormat('###,###,###,###').format((state.orderItems.isNotEmpty) ? viewModel.dcResult : 0)} 원',
                                              style:
                                                  const TextStyle(fontSize: 12),
                                            )
                                          ],
                                        ),
                                        // 배송비 금액(주문리스트 중 가장 낮은금액으로 책정)
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              '배송비',
                                              style: TextStyle(fontSize: 12),
                                            ),
                                            Text(
                                              '${NumberFormat('###,###,###,###').format((state.orderItems.isNotEmpty) ? state.orderItems.first.deliveryCostByOrder : 0)} 원',
                                              style:
                                                  const TextStyle(fontSize: 12),
                                            )
                                          ],
                                        ),
                                        // 총 결제금액
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              '총 결제금액',
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            Text(
                                              '${NumberFormat('###,###,###,###').format((state.orderItems.fold(0, (e, v) => e + v.payAmount!) - viewModel.dcResult).toInt())} 원',
                                              style: const TextStyle(
                                                  color: Color(0xFF019934),
                                                  fontSize: 16),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Divider(),
                                  Container(
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
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, right: 8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            '쿠폰 사용',
                                            style: TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                          (viewModel.myCouponList.length == 1)
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    child: Container(
                                                      color: const Color(
                                                          0xFFcacaca),
                                                      child: const Padding(
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        child: Text(
                                                            '- 보유중인 쿠폰이 없습니다.'),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : DropdownButton(
                                                  value: selectedCoupon,
                                                  items: viewModel.myCouponList
                                                      .map((e) {
                                                    return DropdownMenuItem(
                                                        value: e,
                                                        child: (e != null)
                                                            ? Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(e
                                                                      .couponName),
                                                                  const SizedBox(
                                                                    width: 30,
                                                                  ),
                                                                  Text((e.dcAmount >
                                                                          0)
                                                                      ? '${e.dcAmount} 원'
                                                                      : '${e.dcRate} %')
                                                                ],
                                                              )
                                                            : const Text(
                                                                '사용안함'));
                                                  }).toList(),
                                                  onChanged: (value) {
                                                    // items 의 DropdownMenuItem 의 value 반환
                                                    setState(() {
                                                      selectedCoupon = value
                                                          as CouponsModel?;
                                                    });
                                                    viewModel
                                                        .calculateDcByCoupon(
                                                            state.orderItems,
                                                            selectedCoupon);
                                                  },
                                                )
                                        ],
                                      ),
                                    ),
                                  ),
                                  const Divider(),
                                  Visibility(
                                    visible: ((state.orderItems.isNotEmpty) &&
                                        (state.orderItems.first.payAndStatus! <
                                            1)),
                                    // -1: 결제실패, 0: 결제전, 1: 결제완료, 2: 결제취소, 3: 배송중, 4: 배송완료
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '청약의사 재확인',
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        Text(''),
                                      ],
                                    ),
                                  ),
                                  Visibility(
                                    visible: ((state.orderItems.isNotEmpty) &&
                                        (state.orderItems.first.payAndStatus! <
                                            1)),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 13, bottom: 16, right: 13),
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            finalConfirmNeed =
                                                !finalConfirmNeed;
                                          });
                                        },
                                        child: Row(
                                          children: [
                                            Checkbox(
                                              value: finalConfirmNeed,
                                              onChanged: (bool? newValue) {
                                                setState(() {
                                                  finalConfirmNeed = newValue!;
                                                });
                                              },
                                              activeColor:
                                                  const Color(0xFF2F362F),
                                              checkColor: Colors.white,
                                            ),
                                            const Expanded(
                                              child: Text(
                                                '(필수) 구매하실 상품의 모든 정보를 확인하였으며, 구매진행에 동의합니다.',
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Visibility(
                            visible: (finalConfirmDemand == true),
                            child: const Text(
                              '(필수) 청약의사 재확인을 동의하셔야 주문이 진행됩니다.',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
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
                                        widget.hideNavBar(false);
                                      },
                                      child: const Text(
                                        '이전',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible:
                                      widget.forOrderItems.first.payAndStatus! <
                                          1,
                                  child: Expanded(
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
                                        onPressed: () {
                                          if (finalConfirmNeed == false) {
                                            setState(() {
                                              finalConfirmDemand = true;
                                            });
                                          } else {
                                            viewModel.bootpayPayment(
                                                context,
                                                state.orderItems,
                                                state.orderItems.fold(
                                                        0,
                                                        (e, v) =>
                                                            e + v.payAmount!) -
                                                    viewModel.dcResult +
                                                    state.orderItems.first
                                                        .deliveryCostByOrder,
                                                selectedCoupon?.couponId,
                                                widget.hideNavBar);
                                          }
                                        },
                                        child: const Text(
                                          '결제',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(child: Container())
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

// 세일로 할인된 금액 계산
  num calculatedSalesPrice(String originalPrice, SalesModel? saleContent) {
    num originPrice = int.parse(originalPrice.replaceAll(',', ''));
    num salePrice = 0;
    if (saleContent != null) {
      if (saleContent.salesRate <= 0 && saleContent.salesAmount > 0) {
        salePrice = saleContent.salesAmount;
      } else if (saleContent.salesRate > 0 && saleContent.salesAmount <= 0) {
        salePrice = originPrice * (saleContent.salesRate) / 100;
      }
    }
    return salePrice;
  }
}
