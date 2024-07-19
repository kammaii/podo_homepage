import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:podo_homepage/common/my_widgets.dart';
import 'package:podo_homepage/common/values.dart';

List<CourseCard> cards = [
  CourseCard("course_0", "curriculum_4", "curriculum_5"),
  CourseCard("course_1", "curriculum_6", "curriculum_7"),
  CourseCard("course_2", "curriculum_8", "curriculum_9"),
  CourseCard("course_3", "curriculum_10", "curriculum_11"),
  CourseCard("course_4", "curriculum_12", "curriculum_13"),
  CourseCard("course_5", "curriculum_14", "curriculum_15"),
  CourseCard("course_6", "curriculum_16", "curriculum_17"),
];

Widget getCard(int index) {
  CourseCard card = cards[index];
  return Card(
    color: Colors.white,
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            children: [
              Image.asset(
                'assets/images/${card.image}.png',
                width: 80,
                height: 80,
              ),
              widthSpace,
              Expanded(
                  child: MyWidgets()
                      .getText(texts[card.title]!, isBold: true, fontColor: darkPurple, textAlign: TextAlign.start, fontSize: fontSizeMiddle))
            ],
          ),
          heightSpace,
          MyWidgets().getText(texts[card.contents]!, textAlign: TextAlign.start, fontHeight: 1.5)
        ],
      ),
    ),
  );
}

Widget curriculum(BuildContext context, Function(int) changePage) {
  double w = MediaQuery.of(context).size.width;
  return Column(
    children: [
      Container(
        color: bgPurple,
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: w > 600 ? 500 : w - 100,
              child: Column(
                children: [
                  heightSpace,
                  MyWidgets().getText(texts["curriculum_1"]!, isBold: true, fontSize: fontSizeBig, fontColor: darkPurple),
                  heightSpace,
                  getCard(0),
                  getCard(1),
                  getCard(2),
                  heightSpace,
                  MyWidgets().getText(texts["curriculum_2"]!, isBold: true, fontSize: fontSizeBig, fontColor: darkPurple),
                  heightSpace,
                  getCard(3),
                  getCard(4),
                  heightSpace,
                  MyWidgets().getText(texts["curriculum_3"]!, isBold: true, fontSize: fontSizeBig, fontColor: darkPurple),
                  heightSpace,
                  getCard(5),
                  getCard(6),
                ],
              ),
            ),
          ],
        ),
      ),
      heightSpace,
      MyWidgets().downloadNow(context),
      MyWidgets().footer(context, changePage),
    ],
  );
}

class CourseCard {
  late String image;
  late String title;
  late String contents;

  CourseCard(this.image, this.title, this.contents);
}
