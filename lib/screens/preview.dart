import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:podo_homepage/common/my_widgets.dart';
import 'package:podo_homepage/common/values.dart';
import 'package:podo_homepage/main.dart';
import 'package:podo_homepage/screens/home.dart';

List<bool> appToggle = [true, false];
int swiperIndex = 0;
const podoLength = 14;
const wordsLength = 7;
SwiperController swiperController = SwiperController();

Widget devicePart(BuildContext context, double w) {
  return Column(
    children: [
      ToggleButtons(
        isSelected: appToggle,
        onPressed: (int index) {
          swiperIndex = 0;
          swiperController.move(0);
          appToggle[0] = 0 == index;
          appToggle[1] = 1 == index;
          controller.update();
        },
        constraints: const BoxConstraints(minHeight: 30, minWidth: 50),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        selectedBorderColor: darkPurple,
        selectedColor: Colors.white,
        fillColor: darkPurple,
        color: darkPurple,
        children: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text('Podo Korean', style: TextStyle(fontSize: 15)),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text('Podo Words', style: TextStyle(fontSize: 15)),
          ),
        ],
      ),
      const SizedBox(height: 30),
      SizedBox(
        width: 350,
        height: 450,
        child: Stack(
          children: [
            Swiper(
              controller: swiperController,
              itemCount: appToggle[0] ? podoLength: wordsLength,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 28, bottom: 40),
                  child: Image.asset('assets/images/${appToggle[0] ? 'podo_' : 'words_'}${index + 1}.jpg'),
                );
              },
              indicatorLayout: PageIndicatorLayout.COLOR,
              pagination: const SwiperPagination(
                alignment: Alignment.bottomCenter,
              ),
              control: const SwiperControl(),
              scale: 0.9,
              onIndexChanged: (index) {
                swiperIndex = index;
                controller.update();
              },
            ),
            Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: Image.asset('assets/images/mobile.png'),
                ))
          ],
        ),
      ),
    ],
  );
}

Widget explainPart(BuildContext context, double w) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //SizedBox(height: w >= 920 ? 100 : 50),
        heightSpace,
        w >= 920 ?
        iconAndStoreBadge(context, isRow: true) : const SizedBox.shrink(),
        heightSpace,
        Row(
          children: [
            MyWidgets()
                .getText('( ${(swiperIndex + 1).toString()} / ${appToggle[0] ? podoLength : wordsLength} )', fontSize: 13, isBold: true),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: SingleChildScrollView(
                  child: MyWidgets().getText(texts["preview_${appToggle[0] ? swiperIndex + 1 : swiperIndex + 15}"]!,
                      fontColor: darkPurple,
                      fontSize: fontSizeMiddle,
                      textAlign: TextAlign.start,
                      fontHeight: 1.8),
                )),
          ],
        ),
        heightSpace,
        w < 920 ? iconAndStoreBadge(context, isRow: false) : const SizedBox.shrink()
      ],
    ),
  );
}

Widget iconAndStoreBadge(BuildContext context, {required bool isRow}) {
  return isRow ? Row(
    children: [
      Container(
        height: 80,
        width: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.white,
        ),
        child: Image.asset(appToggle[0] ? 'assets/images/podo_icon.png' : 'assets/images/podo_words_icon.png', width: 80, height: 80),
      ),
      widthSpace,
      MyWidgets().storeBadge(context, isPodoKorean: appToggle[0]),
    ],
  ) : Column(
    children: [
      Container(
        height: 80,
        width: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.white,
        ),
        child: Image.asset(appToggle[0] ? 'assets/images/podo_icon.png' : 'assets/images/podo_words_icon.png', width: 80, height: 80),
      ),
      heightSpace,
      MyWidgets().storeBadge(context, isPodoKorean: appToggle[0]),
    ],
  );
}

Widget preview(BuildContext context, Function(int) changePage) {
  double w = MediaQuery.of(context).size.width;

  return GetBuilder<MainController>(builder: (controller) {
    return Column(
      children: [
        Container(
          color: bgPurple,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: w >= 700 ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                devicePart(context, w),
                widthSpace,
                Expanded(
                  child: explainPart(context, w),
                ),
              ],
            ) : Column(
              children: [
                devicePart(context, w),
                explainPart(context, w),
              ],
            )
          ),
        ),
        heightSpace,
        Image.asset('assets/images/podo_logo.png', width: 300),
        heightSpace,
        MyWidgets().footer(context, changePage),
      ],
    );
  });
}
