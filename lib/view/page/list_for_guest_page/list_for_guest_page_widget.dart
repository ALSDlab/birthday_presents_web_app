import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/image_load_widget.dart';
import '../search_page/mall_link_list.dart';
import 'list_for_guest_page_view_model.dart';

class ListForGuestPageWidget extends StatelessWidget {
  final Map<String, dynamic> presentsListItem;
  final Map<String, dynamic> updateListItem;
  final int index;
  final String? title;
  final String? imageUrl;

  const ListForGuestPageWidget({
    super.key,
    required this.presentsListItem,
    required this.index,
    required this.updateListItem,
     this.title,
     this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ListForGuestPageViewModel>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () async {
              await launchUrl(Uri.parse(updateListItem['mallLink']));
            },
            child: ColorFiltered(
              colorFilter: presentsListItem['isSelected']
                  ? const ColorFilter.matrix(<double>[
                      0.2126,
                      0.7152,
                      0.0722,
                      0,
                      0,
                      0.2126,
                      0.7152,
                      0.0722,
                      0,
                      0,
                      0.2126,
                      0.7152,
                      0.0722,
                      0,
                      0,
                      0,
                      0,
                      0,
                      1,
                      0,
                    ])
                  : const ColorFilter.mode(
                      Colors.transparent,
                      BlendMode.multiply,
                    ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: (imageUrl != null)
                              ? ImageLoadWidget(
                                  imageUrl: imageUrl!,
                                  width: 100 + 10.w, // 너비 설정
                                  height: 100 + 10.w,
                                  fit: BoxFit.cover)
                              : Container(
                                  width: 100 + 10.w, // 너비 설정
                                  height: 100 + 10.w, // 높이 설정
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
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            width: 80 + 10.w, // 너비 설정
                            height: 80 + 10.w, // 높이 설정
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0),
                                borderRadius: BorderRadius.circular(20.0),
                                image: (presentsListItem['isSelected'])
                                    ? const DecorationImage(
                                        opacity: 0.5,
                                        image: AssetImage(
                                          'images/selected.png',
                                        ),
                                        fit: BoxFit.cover,
                                      )
                                    : null),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Text(
                        //   maxLines: 2,
                        //   overflow: TextOverflow.ellipsis,
                        //   title,
                        //   style: const TextStyle(
                        //       fontFamily: 'Jalnan',
                        //       fontSize: 20,
                        //       color: Color(0xFF3A405A)),
                        // ),
                        // SizedBox(
                        //   height: 10.w,
                        // ),
                        Text(
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          '${updateListItem['mallLink']}',
                          style: const TextStyle(
                            fontFamily: 'KoPub',
                            fontSize: 18,
                            color: Color(0xFF3A405A),
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                ],
              ),
            ),
          ),
        ),
        Visibility(
          visible: !presentsListItem['isSelected'],
          child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Transform.scale(
                scale: 2,
                child: Checkbox(
                    value: updateListItem['isSelected'],
                    onChanged: (value) {
                      viewModel.toggleSelection(index, value!);
                    }),
              )),
        )
      ],
    );
  }
}
