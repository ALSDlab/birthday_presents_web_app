import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../search_page/mall_link_list.dart';

class ListForGuestPageWidget extends StatelessWidget {
  final Map<String, dynamic> presentsListItem;

  ListForGuestPageWidget({
    super.key,
    required this.presentsListItem,
  });

  @override
  Widget build(BuildContext context) {
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
          ],
        ),
        const Divider(),
      ],
    );
  }
}
