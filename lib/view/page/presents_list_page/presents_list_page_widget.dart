import 'package:Birthday_Presents_List/view/page/presents_list_page/presents_list_view_model.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../widgets/two_answer_dialog.dart';
import '../search_page/mall_link_list.dart';

class PresentListPageWidget extends StatelessWidget {
  final Map<String, dynamic> presentsListItem;
  final bool Function(int) resetNavigation;

  PresentListPageWidget({
    super.key,
    required this.presentsListItem,
    required this.resetNavigation,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<PresentsListViewModel>();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: AbsorbPointer(
                absorbing: (presentsListItem['isSelected']),
                child: GestureDetector(
                  onTap:
                  () async {
                    await launchUrl(
                        Uri.parse(presentsListItem['mallLink']));
                  },
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: ColorFiltered(
                            colorFilter: ColorFilter.mode(
                              (presentsListItem['isSelected']) ? Colors.grey : Colors.transparent,
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
                                    'images/${urls.keys.firstWhere((key) => presentsListItem['mallLink'].contains(urls[key]!.split('://')[1]), orElse: () => 'Not_found')}.png',
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
                          '${presentsListItem['mallLink']}',
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
            Visibility(
              visible: (!viewModel.state.isCompleted),
              child: Padding(
                padding: const EdgeInsets.only(right: 24.0),
                child: IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => TwoAnswerDialog(
                                title: 'Delete the item?',
                                firstButton: 'NO',
                                secondButton: 'YES',
                                imagePath: 'assets/gifs/two_answer_dialog.gif',
                                onFirstTap: () {
                                  Navigator.pop(context);
                                },
                                onSecondTap: () async {
                                  await viewModel.removeFromPresentsList(
                                      presentsListItem, context);
                                  final newBadgeCount =
                                      await viewModel.getBadgeCount();
                                  resetNavigation(newBadgeCount);
                                  if (context.mounted) {
                                    Navigator.pop(context);
                                  }
                                },
                              ));
                    },
                    icon: const Icon(BootstrapIcons.trash3, size: 35,)),
              ),
            )
          ],
        ),
        const Divider(),
      ],
    );
  }
}
