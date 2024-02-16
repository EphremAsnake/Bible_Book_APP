import 'package:bible_book_app/app/core/shared_controllers/theme_controller.dart';
import 'package:bible_book_app/app/modules/detail/controllers/detail_controller.dart';
import 'package:bible_book_app/app/utils/helpers/api_state_handler.dart';
import 'package:bible_book_app/app/utils/helpers/in_app_web_viewer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class HomeAD extends StatelessWidget {
  HomeAD({
    super.key,
  });
  final themeData = Get.find<ThemeController>().themeData.value;
  final DetailController detailController = Get.find<DetailController>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailController>(
      init: DetailController(),
      initState: (_) {},
      builder: (_) {
        if (detailController.apiStateHandler.apiState == ApiState.loading) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
              child: Container(
                width: double.infinity,
                height: 35,
                color: themeData!.whiteColor,
              ),
            ),
          );
        } else if (detailController.apiStateHandler.apiState ==
            ApiState.success) {
          if (detailController
                  .apiStateHandler.data!.houseAds[1].houseAd2!.show ==
              true) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                onTap: () {
                  if (detailController.apiStateHandler.data!.houseAds[1]
                          .houseAd2!.openInAppBrowser ==
                      true) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => InAppWebViewer(
                            url: detailController.apiStateHandler.data!
                                .houseAds[1].houseAd2!.url),
                      ),
                    );
                  } else {
                    detailController.openWebBrowser(detailController
                        .apiStateHandler.data!.houseAds[1].houseAd2!.url);
                  }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xffEEEDED),
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: Offset(0, 8), // horizontal, vertical offset
                      ),
                      BoxShadow(
                        color: Color(0xffEEEDED),
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: Offset(0, -8), // horizontal, vertical offset
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: Text(
                            detailController.apiStateHandler.data!.houseAds[1]
                                .houseAd2!.title,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xff7B5533),
                            border: Border.all(
                              color: const Color(0xff7B5533).withOpacity(0.5),
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 2.0, horizontal: 15),
                            child: Text(
                              detailController.apiStateHandler.data!.houseAds[1]
                                  .houseAd2!.buttonText,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
