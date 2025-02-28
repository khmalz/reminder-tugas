import 'package:flutter/material.dart';
import 'package:flutter_popup/flutter_popup.dart';
import 'package:get/get.dart';
import 'package:reminder_tugas/app/data/constant/talker.dart';
import 'package:reminder_tugas/app/routes/app_pages.dart';
import 'package:talker_flutter/talker_flutter.dart';

class DropdownHome extends GetWidget {
  final Talker talker;

  const DropdownHome({
    super.key,
    required this.talker,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPopup(
      showArrow: false,
      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      barrierColor: Colors.transparent,
      contentDecoration: BoxDecoration(
        color: Colors.white,
      ),
      content: SizedBox(
        width: 0.4 * Get.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: TextButton.icon(
                iconAlignment: IconAlignment.start,
                onPressed: () {
                  Get.toNamed(Routes.CATEGORY);
                },
                icon: const Icon(
                  Icons.content_paste,
                  size: 30,
                ),
                label: const Text(
                  'Kategori',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                style: TextButton.styleFrom(
                  alignment: Alignment.centerLeft,
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: TextButton.icon(
                iconAlignment: IconAlignment.start,
                onPressed: () {
                  Get.to(
                    () => TalkerScreen(
                      talker: talker,
                      theme: TalkerScreenTheme(logColors: {
                        LogGood.logKey: Colors.green,
                      }),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.settings,
                  size: 30,
                ),
                label: const Text(
                  'Talker',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                style: TextButton.styleFrom(
                  alignment: Alignment.centerLeft,
                ),
              ),
            ),
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(Icons.more_vert),
      ),
    );
  }
}
