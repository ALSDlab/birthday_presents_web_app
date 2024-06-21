// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:myk_market_app/view/page/presents_list_page/presents_list_view_model.dart';
// import 'package:myk_market_app/view/widgets/one_answer_dialog.dart';
// import 'package:provider/provider.dart';
//
// import '../../../utils/gif_progress_bar.dart';
//
// class PresentsListPage extends StatefulWidget {
//   const PresentsListPage({
//     super.key,
//     required this.resetNavigation,
//     required this.hideNavBar,
//     required this.docId,
//     required this.name,
//     required this.birthYear,
//   });
//
//   final bool Function(int) resetNavigation;
//   final bool Function(bool) hideNavBar;
//   final String docId;
//   final String name;
//   final int birthYear;
//
//   @override
//   State<PresentsListPage> createState() => _PresentsListPageState();
// }
//
// class _PresentsListPageState extends State<PresentsListPage> {
//   @override
//   Widget build(BuildContext context) {
//     final viewModel = context.watch<PresentsListViewModel>();
//     final state = viewModel.state;
//     final yearCount = DateTime.now().year - widget.birthYear;
//     String countEnding = '';
//     switch (yearCount % 10) {
//       case 1:
//         countEnding = 'st';
//         break;
//       case 2:
//         countEnding = 'nd';
//         break;
//       case 3:
//         countEnding = 'rd';
//         break;
//       default:
//         countEnding = 'th';
//         break;
//     }
//     return Center(
//       child: Container(
//         color: Colors.transparent,
//         child: state.isLoading
//             ? Center(child: GifProgressBar())
//             : Padding(
//                 padding: EdgeInsets.fromLTRB(
//                     (MediaQuery.of(context).size.width >= 1200)
//                         ? 175
//                         : (MediaQuery.of(context).size.width < 900)
//                             ? 25
//                             : (25 +
//                                 (MediaQuery.of(context).size.width - 900) / 2),
//                     10,
//                     (MediaQuery.of(context).size.width >= 1200)
//                         ? 175
//                         : (MediaQuery.of(context).size.width < 900)
//                             ? 25
//                             : (25 +
//                                 (MediaQuery.of(context).size.width - 900) / 2),
//                     10),
//                 child: Column(
//                   children: [
//                     Text("${widget.name}'s $yearCount$countEnding BIRTHDAY!!"),
//                     state.cartList.isEmpty
//                         ? Expanded(
//                             child: Padding(
//                               padding: const EdgeInsets.all(16.0),
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   const Text('EMPTY LIST'),
//                                   const SizedBox(
//                                     height: 15,
//                                   ),
//                                   OutlinedButton(
//                                     style: OutlinedButton.styleFrom(
//                                         shape: const RoundedRectangleBorder(
//                                             borderRadius: BorderRadius.all(
//                                                 Radius.circular(10)))),
//                                     onPressed: () {
//                                       context.go('/search_page', extra: {
//                                         'navSetState': widget.resetNavigation,
//                                         'hideNavBar': widget.hideNavBar
//                                       });
//                                     },
//                                     child: const Text(
//                                       '선물 담으러 가기',
//                                       style: TextStyle(
//                                         color: Colors.black,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           )
//                         : Expanded(
//                             child: Padding(
//                               padding: const EdgeInsets.all(5.0),
//                               child: Column(
//                                 children: [
//                                   Expanded(
//                                     child: ListView.builder(
//                                       physics: const BouncingScrollPhysics(),
//                                       itemBuilder: (context, index) {
//                                         return FutureBuilder<SalesModel?>(
//                                           future: viewModel.getSalesContent(
//                                               state.cartList[index].salesId),
//                                           builder: (context, snapshot) {
//                                             if (snapshot.connectionState ==
//                                                 ConnectionState.waiting) {
//                                               return Center(
//                                                   child: GifProgressBar());
//                                             } else if (snapshot.hasError) {
//                                               return Center(
//                                                   child: Text(
//                                                       'Error: ${snapshot.error}'));
//                                             } else {
//                                               final salesContent =
//                                                   snapshot.data;
//                                               return ShoppingCartPageWidget(
//                                                 presentsListItem:
//                                                     state.cartList[index],
//                                                 removeFromCartList: viewModel
//                                                     .removeFromCartList,
//                                                 navSetState: widget.navSetState,
//                                                 salesContent: salesContent,
//                                               );
//                                             }
//                                           },
//                                         );
//                                       },
//                                       itemCount: state.cartList.length,
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.all(5.0),
//                                     child: Row(
//                                       children: [
//                                         Expanded(child: Container()),
//                                         Expanded(
//                                           child: ElevatedButton(
//                                             onPressed: () async {
//                                               final List<ShoppingProductForCart>
//                                                   reloadedList = await viewModel
//                                                       .updateCartList(
//                                                           state.cartList);
//                                               final List<OrderModel>
//                                                   orderItemList =
//                                                   await viewModel.sendCart(
//                                                       reloadedList
//                                                           .where((e) =>
//                                                               e.isChecked ==
//                                                               true)
//                                                           .toList());
//                                               if (reloadedList
//                                                   .where((e) =>
//                                                       e.isChecked == true)
//                                                   .toList()
//                                                   .isEmpty) {
//                                                 showDialog(
//                                                     context: context,
//                                                     builder: (context) {
//                                                       return OneAnswerDialog(
//                                                           onTap: () {
//                                                             Navigator.pop(
//                                                                 context);
//                                                           },
//                                                           title:
//                                                               '선택된 상품이 없습니다.',
//                                                           subtitle:
//                                                               '상품을 선택해 주세요',
//                                                           firstButton: '확인',
//                                                           imagePath:
//                                                               'assets/gifs/alert.gif');
//                                                     });
//                                               } else {
//                                                 // ShoppingCartPageWidget.checkedList = [];
//                                                 final result = await GoRouter
//                                                         .of(context)
//                                                     .push(
//                                                         '/shopping_cart_page/fill_order_page',
//                                                         extra: {
//                                                       'orderModelList':
//                                                           orderItemList,
//                                                       'navSetState':
//                                                           widget.navSetState,
//                                                       'hideNavBar':
//                                                           widget.hideNavBar
//                                                     });
//                                                 if (result == true) {
//                                                   viewModel.getCartList();
//                                                 }
//                                               }
//                                             },
//                                             style: ElevatedButton.styleFrom(
//                                                 backgroundColor:
//                                                     const Color(0xFF2F362F),
//                                                 shape:
//                                                     const RoundedRectangleBorder(
//                                                         borderRadius:
//                                                             BorderRadius.all(
//                                                                 Radius.circular(
//                                                                     10)))),
//                                             child: const Text(
//                                               '주문하기',
//                                               style: TextStyle(
//                                                   color: Colors.white),
//                                             ),
//                                             // style: ButtonStyle(
//                                             //   backgroundColor: MaterialStateProperty.all(
//                                             //     const Color(0xFF2F362F),
//                                             //   ),
//                                             // ),
//                                           ),
//                                         ),
//                                         Expanded(child: Container()),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           )
//                   ],
//                 ),
//               ),
//       ),
//     );
//   }
// }
