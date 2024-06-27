import 'package:Birthday_Presents_List/view/page/presents_list_page/presents_list_view_model.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../widgets/two_answer_dialog.dart';
import '../search_page/mall_link_list.dart';

class PresentListPageWidget extends StatefulWidget {
  final Map<String, dynamic> presentsListItem;
  final bool Function(int) resetNavigation;

  PresentListPageWidget({
    super.key,
    required this.presentsListItem,
    required this.resetNavigation,
  });

  @override
  State<PresentListPageWidget> createState() => _PresentListPageWidgetState();
}

class _PresentListPageWidgetState extends State<PresentListPageWidget> {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<PresentsListViewModel>();
    final state = viewModel.state;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: AbsorbPointer(
                absorbing: (widget.presentsListItem['isSelected']),
                child: GestureDetector(
                  onTap:  
                  (){
                    //TODO: 선택안된 아이템 Tap 시 링크 연결
                  },
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: ColorFiltered(
                            colorFilter: ColorFilter.mode(
                              (widget.presentsListItem['isSelected']) ? Colors.grey : Colors.transparent,
                              BlendMode.saturation,
                            ),
                            child: Container(
                              width: 50.w, // 너비 설정
                              height: 50.w, // 높이 설정
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.0),
                                image: DecorationImage(
                                  image: AssetImage(
                                    'images/${urls.keys.firstWhere((key) => widget.presentsListItem['mallLink'].contains(urls[key]!.split('://')[1]), orElse: () => 'Not_found')}.png',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Text(
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          '${widget.presentsListItem['mallLink']}',
                          style: const TextStyle(
                              fontFamily: 'Jalnan',
                              fontSize: 18,
                              color: Color(0xFF3A405A)),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => TwoAnswerDialog(
                            title: '상품을 삭제하시겠습니까?',
                            firstButton: '아니요',
                            secondButton: '예',
                            imagePath: 'assets/gifs/two_answer_dialog.gif',
                            onFirstTap: () {
                              Navigator.pop(context);
                            },
                            onSecondTap: () async {
                              await viewModel.removeFromPresentsList(
                                  widget.presentsListItem, context);
                              final newBadgeCount =
                                  await viewModel.getBadgeCount();
                              widget.resetNavigation(newBadgeCount);
                              if (context.mounted) {
                                Navigator.pop(context);
                              }
                            },
                          ));
                },
                icon: const Icon(BootstrapIcons.trash3))
          ],
        ),
        const Divider(),
      ],
    );
  }
}
