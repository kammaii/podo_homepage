import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:podo_homepage/common/my_widgets.dart';
import 'package:podo_homepage/common/values.dart';
import 'package:podo_homepage/main.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:timelines/timelines.dart';


List<TimelineContent> timelines = [
  TimelineContent("2018.08", texts["brand_30"]!),
  TimelineContent("2019.04", texts["brand_31"]!),
  TimelineContent("2020.02", texts["brand_32"]!),
  TimelineContent("2021.07", texts["brand_33"]!),
  TimelineContent("2023.10", texts["brand_34"]!),
];

Widget getContainer(Color color, Widget widget) {
  return Container(
    color: color,
    padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 50),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(child: widget),
      ],
    ),
  );
}

Widget roundedContainer(IconData icon, String title, {Color bgColor = bgPurple}) {
  return Column(
    children: [
      Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(icon, color: darkPurple, size: 40),
      ),
      const SizedBox(height: 10),
      MyWidgets().getText(title, fontColor: darkPurple)
    ],
  );
}


Widget circleContainer({IconData? icon, double h = 50, double w = 50, Color bgColor = bgPurple}) {
  return Padding(
    padding: const EdgeInsets.all(20),
    child: Container(
      height: h,
      width: w,
      decoration: BoxDecoration(
        color: bgColor,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: darkPurple),
    ),
  );
}

Widget brand(BuildContext context, Function(int) changePage) {
  return Column(
    children: [
      getContainer(
          darkPurple,
          Column(
            children: [
              Image.asset('assets/images/danny.png', width: 150),
              heightSpace,
              MyWidgets().getText("안녕하세요?", isBold: true, fontSize: fontSizeBig, fontColor: Colors.white),
              heightSpace,
              MyWidgets()
                  .getText(texts["brand_1"]!, isBold: true, fontColor: Colors.white, fontSize: fontSizeMiddle),
              heightSpace,
              MyWidgets()
                  .getText(texts["brand_2"]!, isBold: true, fontColor: Colors.white, fontSize: fontSizeMiddle),
              MyWidgets().getText(texts["brand_3"]!, fontColor: Colors.white),
              heightSpace,
              MyWidgets()
                  .getText(texts["brand_5"]!, isBold: true, fontColor: Colors.white, fontSize: fontSizeMiddle),
              heightSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/en.png', width: 40, height: 40),
                  const SizedBox(width: 10),
                  Image.asset('assets/images/th.png', width: 40, height: 40),
                  const SizedBox(width: 10),
                  Image.asset('assets/images/jp.png', width: 40, height: 40),
                  const SizedBox(width: 10),
                  Image.asset('assets/images/cn.png', width: 40, height: 40),
                ],
              )
            ],
          )),
      getContainer(
          Colors.white,
          Column(
            children: [
              MyWidgets()
                  .getText(texts["brand_6"]!, isBold: true, fontColor: darkPurple, fontSize: fontSizeMiddle),
              heightSpace,
              MyWidgets().learningWays(context, bgPurple),
            ],
          )),
      getContainer(
          bgPurple,
          Column(
            children: [
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child:
                        roundedContainer(CupertinoIcons.app_badge_fill, texts["brand_10"]!, bgColor: Colors.white),
                  ),
                  const Positioned(
                      top: 0, right: 0, child: Icon(Icons.star_rounded, color: CupertinoColors.systemYellow)),
                ],
              ),
              heightSpace,
              MyWidgets()
                  .getText(texts["brand_11"]!, isBold: true, fontColor: darkPurple, fontSize: fontSizeMiddle),
              MyWidgets().getText(texts["brand_12"]!, fontColor: darkPurple),
              heightSpace,
              MyWidgets().getText(texts["brand_13"]!, isBold: true, fontColor: darkPurple, fontSize: fontSizeBig),
            ],
          )),
      getContainer(
          Colors.white,
          Column(
            children: [
              MyWidgets().getText(texts["brand_14"]!, isBold: true, fontColor: darkPurple),
              heightSpace,
              MyWidgets().getText(texts["brand_14_1"]!, isBold: true, fontColor: darkPurple),
              heightSpace,
              MyWidgets().getText(texts["brand_15"]!, isBold: true, fontSize:fontSizeBig, fontColor: darkPurple),
              const Divider(height: 80),
              MyWidgets().getText(texts["brand_16"]!, isBold: true, fontColor: darkPurple),
              heightSpace,
              MyWidgets().getText(texts["brand_16_1"]!, isBold: true, fontColor: darkPurple),
              heightSpace,
              MyWidgets().getText(texts["brand_17"]!, isBold: true, fontSize:fontSizeBig, fontColor: darkPurple),
            ],
          )),
      getContainer(
          bgPurple,
          Column(
            children: [
              MyWidgets()
                  .getText(texts["brand_18"]!, isBold: true, fontColor: darkPurple, fontSize: fontSizeMiddle),
              heightSpace,
              MyWidgets()
                  .getText(texts["brand_19"]!, isBold: true, fontColor: darkPurple, fontSize: fontSizeMiddle),
              heightSpace,
              MyWidgets().getText(texts["brand_20"]!, isBold: true, fontColor: darkPurple, fontSize: fontSizeBig),
            ],
          )),
      getContainer(
          Colors.white,
          Column(
            children: [
              MyWidgets()
                  .getText(texts["brand_21"]!, isBold: true, fontColor: darkPurple, fontSize: fontSizeMiddle),
              heightSpace,
              MyWidgets()
                  .getText(texts["brand_22"]!, isBold: true, fontColor: darkPurple, fontSize: fontSizeMiddle),
              heightSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyWidgets().getText(texts["brand_23"]!,
                      isBold: true,
                      fontColor: Colors.grey,
                      fontSize: MediaQuery.of(context).size.width < 480 ? 15 : 20),
                  circleContainer(w: 10, h: 10, bgColor: Colors.grey),
                  MyWidgets().getText(texts["brand_24"]!,
                      isBold: true,
                      fontColor: Colors.grey,
                      fontSize: MediaQuery.of(context).size.width < 480 ? 15 : 20),
                  circleContainer(w: 10, h: 10, bgColor: Colors.grey),
                  MyWidgets().getText(texts["brand_25"]!,
                      isBold: true,
                      fontColor: Colors.grey,
                      fontSize: MediaQuery.of(context).size.width < 480 ? 15 : 20),
                ],
              )
            ],
          )),
      getContainer(
          bgPurple,
          Column(
            children: [
              MyWidgets()
                  .getText(texts["brand_26"]!, isBold: true, fontColor: darkPurple, fontSize: fontSizeMiddle),
              heightSpace,
              MyWidgets()
                  .getText(texts["brand_27"]!, isBold: true, fontColor: darkPurple, fontSize: fontSizeMiddle),
              heightSpace,
              MyWidgets().highlightText(texts["brand_28"]!),
            ],
          )),
      Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 50),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  MyWidgets()
                      .getText(texts["brand_35"]!, isBold: true, fontColor: darkPurple, fontSize: fontSizeMiddle),
                  heightSpace,
                  MyWidgets()
                      .getText(texts["brand_36"]!, isBold: true, fontColor: darkPurple, fontSize: fontSizeMiddle),
                  heightSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(child: Center(child: MyWidgets().highlightText(texts["brand_37"]!))),
                      circleContainer(w: 10, h: 10, bgColor: darkPurple),
                      Expanded(child: Center(child: MyWidgets().highlightText(texts["brand_38"]!))),
                    ],
                  ),
                  heightSpace,
                  MyWidgets().getText(texts["brand_39"]!, fontColor: darkPurple),
                  heightSpace,
                  MyWidgets()
                      .getText(texts["brand_40"]!, isBold: true, fontColor: darkPurple, fontSize: fontSizeMiddle),
                ],
              ),
            ),
            MediaQuery.of(context).size.width < 945
                ? const SizedBox.shrink()
                : Expanded(
                    child: SizedBox(
                      height: 600,
                      child: Timeline.tileBuilder(
                        builder: TimelineTileBuilder.fromStyle(
                          contentsAlign: ContentsAlign.basic,
                          contentsBuilder: (context, index) {
                            Color color = (index + 1 == timelines.length) ? darkPurple : Colors.black;
                            double size = (index + 1 == timelines.length) ? 18 : 15;
                            return Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MyWidgets().getText(timelines[index].date,
                                      isBold: true, fontColor: color, fontSize: size),
                                  MyWidgets().getText(timelines[index].content, fontColor: color, fontSize: size),
                                ],
                              ),
                            );
                          },
                          itemCount: timelines.length,
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
      getContainer(
          bgPurple,
          MyWidgets().downloadNow(context)),
      MyWidgets().footer(context, changePage),
    ],
  );
}

class TimelineContent {
  late String date;
  late String content;

  TimelineContent(this.date, this.content);
}
