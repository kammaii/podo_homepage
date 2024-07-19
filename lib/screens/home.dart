import 'dart:async';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:podo_homepage/common/my_widgets.dart';
import 'package:podo_homepage/common/values.dart';
import 'package:podo_homepage/main.dart';

final controller = Get.find<MainController>();
List<ReviewItem> reviewItems = [
  ReviewItem("Jean Reimbold", 5, texts["home_32"]!),
  ReviewItem("aleksa 88", 5, texts["home_33"]!),
  ReviewItem("Joenn2609", 5, texts["home_34"]!),
  ReviewItem("Nikola", 5, texts["home_35"]!),
  ReviewItem("Ирина Ирина", 5, texts["home_36"]!),
  ReviewItem("Dr Shantoux", 5, texts["home_37"]!),
  ReviewItem("Kailane Silva", 5, texts["home_38"]!),
  ReviewItem("dynamo samaha", 5, texts["home_39"]!),
  ReviewItem("Oratile Miyelani", 4, texts["home_40"]!),
  ReviewItem("Margaret Abang", 4, texts["home_41"]!),
];

List<FaqItem> faqItems = [
  FaqItem("01.", texts["home_43"]!, texts["home_44"]!),
  FaqItem("02.", texts["home_45"]!, texts["home_46"]!),
  FaqItem("03.", texts["home_47"]!, texts["home_48"]!),
  FaqItem("04.", texts["home_49"]!, texts["home_50"]!),
  FaqItem("05.", texts["home_51"]!, texts["home_52"]!),
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

TableRow _buildHeaderRow() {
  return TableRow(
    children: [
      _buildTableCell(''),
      _buildTableCell(texts["home_12"]!),
      _buildTableCell(texts["home_13"]!),
    ],
  );
}

List<List<int>> _stars = [
  [3, 1],
  [2, 2],
  [1, 3]
];

TableRow _buildDataRow(int index) {
  return TableRow(children: [
    _buildTableCell(index == 0
        ? texts["home_14"]!
        : index == 1
            ? texts["home_7"]!
            : texts["home_15"]!),
    _buildStarCell(_stars[index][0]),
    _buildStarCell(_stars[index][1]),
  ]);
}

Widget _buildStarCell(int filledStar) {
  List<Widget> stars = List.generate(filledStar, (index) => const Icon(Icons.star_rounded, color: darkPurple));
  for (int i = 0; stars.length < 3; i++) {
    stars.add(const Icon(Icons.star_border_rounded, color: darkPurple));
  }
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: stars,
  );
}

Widget _buildTableCell(String string) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Center(child: MyWidgets().getText(string, isBold: true, fontColor: darkPurple)),
  );
}

void scrollDown() {
  controller.sc
      .animateTo(controller.sc.offset + 500, duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
}

Widget roundContainer(IconData icon, String content) {
  return Container(
    width: 500,
    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
    decoration: BoxDecoration(color: bgPurple, borderRadius: BorderRadius.circular(30)),
    child: Row(
      children: [
        Icon(icon, color: darkPurple),
        widthSpace,
        Expanded(child: MyWidgets().getText(content, fontColor: darkPurple)),
      ],
    ),
  );
}

Widget _review(String name, int star, String review) {
  List<Widget> stars =
      List.generate(star, (index) => const Icon(Icons.star_rounded, color: CupertinoColors.systemYellow));
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Column(
      children: [
        Row(children: stars),
        const SizedBox(height: 10),
        MyWidgets().getText(name),
        const SizedBox(height: 10),
        Container(
          width: 300,
          height: 200,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(child: MyWidgets().getText(review)),
        )
      ],
    ),
  );
}

ExpansionPanel faqPanel(FaqItem item, {String? linkTitle, Function()? fn}) {
  return ExpansionPanel(
    canTapOnHeader: true,
    isExpanded: item.isExpanded,
    headerBuilder: (context, isExpanded) {
      return Padding(
        padding: const EdgeInsets.all(10),
        child: ListTile(
          leading: MyWidgets().getText(item.order, isBold: true, fontColor: Colors.grey),
          title: MyWidgets().getText(item.title, isBold: true, fontColor: darkPurple),
        ),
      );
    },
    body: ListTile(
      title: Column(
        children: [
          const Divider(color: Colors.grey, thickness: 1, height: 30),
          Padding(
            padding: const EdgeInsets.all(10),
            child: MyWidgets().getText(item.content, textAlign: TextAlign.start, fontHeight: 2),
          ),
          linkTitle != null
              ? Row(
                  children: [
                    TextButton(onPressed: fn, child: Text(linkTitle)),
                  ],
                )
              : const SizedBox.shrink()
        ],
      ),
    ),
  );
}

closePanels() {
  for (FaqItem item in faqItems) {
    item.isExpanded = false;
  }
}

Widget home(BuildContext context, Function(int) changePage) {
  return Column(
    children: [
      getContainer(
          darkPurple,
          Column(
            children: [
              MyWidgets().getText(texts["home_1"]!, isBold: true, fontSize: fontSizeBig, fontColor: Colors.white),
              heightSpace,
              MyWidgets().getText(texts["home_2"]!, fontColor: Colors.white),
              heightSpace,
              IconButton(
                  onPressed: () {
                    scrollDown();
                  },
                  icon: const Icon(Icons.arrow_circle_down, color: Colors.white))
            ],
          )),
      getContainer(
          bgPurple,
          Column(
            children: [
              MyWidgets().getText(texts["home_5"]!, fontSize: fontSizeBig, fontColor: darkPurple, isBold: true),
              Column(
                children: [
                  const Divider(color: darkPurple, thickness: 1, height: 100),
                  MyWidgets().learningWays(context, Colors.white),
                ],
              )
            ],
          )),
      getContainer(
          Colors.white,
          Column(
            children: [
              MyWidgets().getText(texts["home_11"]!, fontColor: darkPurple, fontSize: fontSizeBig),
              heightSpace,
              Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                columnWidths: {
                  0: FixedColumnWidth(MediaQuery.of(context).size.width < 530 ? 100 : 150),
                  1: FixedColumnWidth(MediaQuery.of(context).size.width < 530 ? 100 : 150),
                  2: FixedColumnWidth(MediaQuery.of(context).size.width < 530 ? 100 : 150),
                },
                border: TableBorder.all(),
                children: List.generate(4, (index) {
                  if (index == 0) {
                    return _buildHeaderRow();
                  } else {
                    return _buildDataRow(index - 1);
                  }
                }),
              )
            ],
          )),
      getContainer(
          bgPurple,
          Column(
            children: [
              MyWidgets().getText(texts["home_16"]!, fontSize: fontSizeBig, fontColor: darkPurple),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: texts["home_16_1"],
                      style: const TextStyle(
                        fontFamily: 'EnglishFont',
                        fontSize: fontSizeBig,
                        color: darkPurple,
                        fontWeight: FontWeight.bold,
                      )
                    ),
                    TextSpan(
                        text: texts["home_16_2"],
                        style: const TextStyle(
                          fontFamily: 'EnglishFont',
                          fontSize: fontSizeBig,
                          color: darkPurple,
                        )
                    ),
                  ]
                ),
              ),
              heightSpace,
              MyWidgets().getText(texts["home_17"]!, isBold: true, fontSize: fontSizeBig, fontColor: darkPurple),
              heightSpace,
              MyWidgets().getText(texts["home_18"]!, fontColor: darkPurple),
              MyWidgets().getText(texts["home_19"]!, fontColor: darkPurple),
              MyWidgets().getText(texts["home_20"]!, fontColor: darkPurple),
            ],
          )),
      getContainer(
          Colors.white,
          Column(
            children: [
              MyWidgets().getText(texts["home_21"]!, fontSize: fontSizeBig, fontColor: darkPurple),
              heightSpace,
              MyWidgets().getText(texts["home_22"]!, isBold: true, fontSize: fontSizeBig, fontColor: darkPurple),
              heightSpace,
              IconButton(
                  onPressed: () {
                    scrollDown();
                  },
                  icon: const Icon(Icons.arrow_circle_down, color: darkPurple)),
            ],
          )),
      getContainer(
          bgPurple,
          Column(
            children: [
              MyWidgets().getText(texts["home_23"]!, isBold: true, fontSize: fontSizeBig, fontColor: darkPurple),
              MyWidgets().getText(texts["home_24"]!, fontSize: fontSizeBig, fontColor: darkPurple),
              heightSpace,
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.white,
                ),
                child: Image.asset('assets/images/podo_icon.png', width: 100, height: 100),
              ),
              heightSpace,
              MyWidgets().getText(texts["home_25"]!, fontColor: darkPurple),
              heightSpace,
              SizedBox(
                width: 350,
                height: 450,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Swiper(
                        itemCount: 14,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 28, bottom: 40),
                            child: Image.asset('assets/images/podo_${index + 1}.jpg'),
                          );
                        },
                        indicatorLayout: PageIndicatorLayout.COLOR,
                        autoplay: true,
                        pagination: const SwiperPagination(
                          alignment: Alignment.bottomCenter,
                        ),
                        control: const SwiperControl(),
                        scale: 0.9,
                      ),
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
              heightSpace,
              ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: darkPurple, elevation: 5),
                  onPressed: () {
                    changePage(2);
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      MyWidgets().getText(texts["home_26"]!, fontColor: Colors.white),
                      widthSpace,
                      const Icon(Icons.arrow_forward_rounded, color: Colors.white),
                    ],
                  )),
              heightSpace,
              MyWidgets().storeBadge(context),
            ],
          )),
      getContainer(
          Colors.white,
          Column(
            children: [
              MyWidgets().getText(texts["home_27"]!, isBold: true, fontSize: fontSizeBig, fontColor: darkPurple),
              heightSpace,
              roundContainer(Icons.lightbulb, texts["home_28"]!),
              heightSpace,
              roundContainer(Icons.keyboard_voice_rounded, texts["home_29"]!),
              heightSpace,
              roundContainer(CupertinoIcons.wand_stars, texts["home_30"]!),
            ],
          )),
      getContainer(
          bgPurple,
          Column(
            children: [
              MyWidgets().getText(texts["home_31"]!, fontSize: fontSizeBig, fontColor: darkPurple),
              heightSpace,
              SizedBox(
                height: 300,
                child: ListView.builder(
                  controller: controller.mc,
                  scrollDirection: Axis.horizontal,
                  itemCount: 1000,
                  itemBuilder: (context, i) {
                    int index = i % 10;
                    ReviewItem item = reviewItems[index];
                    return _review(item.name, item.star, item.content);
                  },
                ),
              ),
              heightSpace,
              MyWidgets().storeBadge(context),
            ],
          )),
      getContainer(
          Colors.white,
          Column(
            children: [
              MyWidgets().getText(texts["home_42"]!, isBold: true, fontSize: fontSizeBig, fontColor: darkPurple),
              heightSpace,
              GetBuilder<MainController>(builder: (_) {
                double p = MediaQuery.of(context).size.width < 740 ? 10 : 50;
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: p),
                  child: ExpansionPanelList(
                    expansionCallback: (index, isExpanded) {
                      closePanels();
                      faqItems[index].isExpanded = isExpanded;
                      controller.update();
                    },
                    children: [
                      faqPanel(faqItems[0]),
                      faqPanel(faqItems[1], linkTitle: texts["home_56"], fn: () {
                        changePage(1);
                      }),
                      faqPanel(faqItems[2], linkTitle: texts["home_56"], fn: () {
                        changePage(1);
                      }),
                      faqPanel(faqItems[3]),
                      faqPanel(faqItems[4], linkTitle: texts["home_57"], fn: () {
                        changePage(4);
                      }),
                    ],
                  ),
                );
              }),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyWidgets().getText(texts["home_53"]!, isBold: true, fontColor: darkPurple),
                  widthSpace,
                  IconButton(
                      onPressed: () {
                        changePage(6);
                      },
                      icon: const Icon(Icons.arrow_circle_right_outlined, color: darkPurple)),
                ],
              )
            ],
          )),
      getContainer(bgPurple, MyWidgets().downloadNow(context)),
      MyWidgets().footer(context, changePage),
    ],
  );
}

class ReviewItem {
  late String name;
  late int star;
  late String content;

  ReviewItem(this.name, this.star, this.content);
}

class FaqItem {
  late String order;
  late String title;
  late String content;
  bool isExpanded = false;

  FaqItem(this.order, this.title, this.content);
}
