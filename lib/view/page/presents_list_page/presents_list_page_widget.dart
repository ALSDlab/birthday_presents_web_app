// import 'package:flutter/material.dart';
// import 'package:myk_market_app/view/page/presents_list_page/presents_list_view_model.dart';
// import 'package:myk_market_app/view/widgets/two_answer_dialog.dart';
// import 'package:provider/provider.dart';
//
// import '../../../utils/image_load_widget.dart';
//
// class PresentListPageWidget extends StatefulWidget {
//   final Map<String, dynamic> presentsListItem;
//   final bool Function(int) resetNavigation;
//
//   PresentListPageWidget(
//       {super.key,
//       required this.presentsListItem,
//       required this.resetNavigation,
//       });
//
//   @override
//   State<PresentListPageWidget> createState() => _PresentListPageWidgetState();
// }
//
// class _PresentListPageWidgetState extends State<PresentListPageWidget> {
//   @override
//   Widget build(BuildContext context) {
//     final viewModel = context.watch<PresentsListViewModel>();
//     final state = viewModel.state;
//     return Column(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             IconButton(
//                 onPressed: () {
//                   showDialog(
//                       context: context,
//                       builder: (context) => TwoAnswerDialog(
//                             title: '상품을 삭제하시겠습니까?',
//                             firstButton: '아니요',
//                             secondButton: '예',
//                             imagePath: 'assets/gifs/two_answer_dialog.gif',
//                             onFirstTap: () {
//                               Navigator.pop(context);
//                             },
//                             onSecondTap: () async {
//                               // await widget.removeFromCartList(
//                               //     widget.shoppingProductForCart);
//                               final newBadgeCount =
//                                   await viewModel.getCartList();
//                               widget.resetNavigation(newBadgeCount);
//                               if (context.mounted) {
//                                 Navigator.pop(context);
//                               }
//                             },
//                           ));
//                 },
//                 icon: const Icon(Icons.cancel_outlined))
//           ],
//         ),
//         SizedBox(
//           width: (MediaQuery.of(context).size.width >= 1200)
//               ? 1200
//               : MediaQuery.of(context).size.width,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Stack(
//                   children: [
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(10),
//                       child: ImageLoadWidget(
//                         width: ((MediaQuery.of(context).size.width >= 1200)
//                                 ? 1200
//                                 : MediaQuery.of(context).size.width) *
//                             0.32,
//                         height: ((MediaQuery.of(context).size.width >= 1200)
//                                 ? 1200
//                                 : MediaQuery.of(context).size.width) *
//                             0.25,
//                         imageUrl:
//                             widget.presentsListItem['representativeImage'],
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(width: 16),
//             ],
//           ),
//         ),
//         const Divider(),
//       ],
//     );
//   }
//
// }
