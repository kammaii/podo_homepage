import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:podo_homepage/common/values.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyWidgets {
  Widget getText(String text,
      {bool isBold = false,
      Color fontColor = Colors.black,
      double fontSize = 15,
      TextAlign textAlign = TextAlign.center,
      double? fontHeight}) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'EnglishFont',
        fontSize: fontSize,
        color: fontColor,
        fontWeight: isBold ? FontWeight.bold : null,
        height: fontHeight,
      ),
      textAlign: textAlign,
    );
  }

  Future<void> runUrl(String urlString) async {
    Uri url = Uri.parse(urlString);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $urlString';
    }
  }

  Widget storeBadge(BuildContext context, {bool isPodoKorean = true}) {
    double w = MediaQuery.of(context).size.width < 550 ? 150 : 200;
    double gap = MediaQuery.of(context).size.width < 550 ? 30 : 50;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
            onTap: () async {
              isPodoKorean ?
              runUrl('https://apps.apple.com/kr/app/podo-korean/id6451487431') : runUrl('https://apps.apple.com/us/app/podo-words/id1578269591');
            },
            child: Image.asset("assets/images/apple.png", width: w-10)),
        SizedBox(width: gap),
        GestureDetector(
            onTap: () async {
              isPodoKorean ?
              runUrl('https://play.google.com/store/apps/details?id=net.awesomekorean.newpodo&hl=en_US') : runUrl('https://play.google.com/store/apps/details?id=net.awesomekorean.podo_words&hl=en_US');
            },
            child: Image.asset("assets/images/google.png", width: w)),
      ],
    );
  }

  Widget roundedContainer(IconData icon, String title, Color bgColor) {
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

  Widget learningWays(BuildContext context, Color bgColor) {
    return MediaQuery.of(context).size.width < 650
        ? Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  roundedContainer(CupertinoIcons.chat_bubble_2_fill, texts["brand_7"]!, bgColor),
                  const SizedBox(width: 30),
                  roundedContainer(CupertinoIcons.book_fill, texts["brand_8"]!, bgColor),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  roundedContainer(CupertinoIcons.play_arrow_solid, texts["brand_9"]!, bgColor),
                  const SizedBox(width: 50),
                  roundedContainer(CupertinoIcons.app_badge_fill, texts["brand_10"]!, bgColor),
                ],
              )
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: MediaQuery.of(context).size.width < 650
                ? []
                : [
                    roundedContainer(CupertinoIcons.chat_bubble_2_fill, texts["brand_7"]!, bgColor),
                    widthSpace,
                    roundedContainer(CupertinoIcons.book_fill, texts["brand_8"]!, bgColor),
                    widthSpace,
                    roundedContainer(CupertinoIcons.play_arrow_solid, texts["brand_9"]!, bgColor),
                    widthSpace,
                    roundedContainer(CupertinoIcons.app_badge_fill, texts["brand_10"]!, bgColor),
                  ],
          );
  }

  Widget highlightText(String text) {
    return Stack(
      children: [
        Positioned(
          bottom: 5,
          left: 0,
          right: 0,
          child: Container(
            height: 20,
            color: Colors.yellow.withOpacity(0.5),
          ),
        ),
        MyWidgets().getText(text, isBold: true, fontColor: darkPurple, fontSize: fontSizeBig)
      ],
    );
  }

  Widget downloadNow(BuildContext context) {
    return Column(
      children: [
        MyWidgets().getText(texts["home_54"]!, isBold: true, fontSize: fontSizeBig, fontColor: darkPurple),
        heightSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.arrow_circle_down, color: darkPurple),
            widthSpace,
            MyWidgets()
                .getText(texts["home_55"]!, isBold: true, fontSize: fontSizeBig, fontColor: darkPurple),
            widthSpace,
            const Icon(Icons.arrow_circle_down, color: darkPurple),
          ],
        ),
        heightSpace,
        MyWidgets().storeBadge(context),
        heightSpace,
        Image.asset('assets/images/podo_logo.png', width: 300),
      ],
    );
  }

  Widget footerLeft() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyWidgets().getText('ㆍ Awesome Korean | Jeongwoo Park', fontColor: Colors.white, fontSize: 10),
        MyWidgets().getText('ㆍ Contact | akorean.help@gmail.com', fontColor: Colors.white, fontSize: 10),
        MyWidgets().getText('ㆍ Business Registration Number | 240-14-01074',
            fontColor: Colors.white, fontSize: 10),
        MyWidgets().getText('ㆍ Mail order sales Registration Number | 2019-대전중구-0212',
            fontColor: Colors.white, fontSize: 10),
        // const SizedBox(height: 10),
        // GestureDetector(
        //     onTap: () {},
        //     child: MyWidgets().getText('ㆍ Terms of Service', fontColor: Colors.white, fontSize: 10)),
        GestureDetector(
            onTap: () async {
              runUrl('https://www.podokorean.com/privacyPolicy.html');
            },
            child: MyWidgets().getText('ㆍ Privacy Policy', fontColor: Colors.white, fontSize: 10, isBold: true)),
      ],
    );
  }

  Widget footerRight(Function(int) changePage) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            IconButton(onPressed: () async {
              runUrl('https://www.instagram.com/koreanwithpodo/');
            }, icon: const Icon(FontAwesomeIcons.instagram), color: Colors.white),
            IconButton(onPressed: () async {
              runUrl('https://www.facebook.com/koreanwithpodo');
            }, icon: const Icon(FontAwesomeIcons.facebook), color: Colors.white),
            IconButton(onPressed: () async {
              runUrl('https://www.reddit.com/r/podokorean/?feed=home');
            }, icon: const Icon(FontAwesomeIcons.reddit), color: Colors.white),
            IconButton(onPressed: () async {
              runUrl('https://blog.podokorean.com');
            }, icon: const Icon(FontAwesomeIcons.blogger), color: Colors.white),
            IconButton(onPressed: () {
              changePage(6);
            }, icon: const Icon(Icons.email), color: Colors.white),
          ],
        ),
        const SizedBox(height: 10),
        MyWidgets().getText('© 2023 Awesome Korean, All rights reserved.', fontColor: Colors.white, fontSize: 10),
      ],
    );
  }

  Widget footer (BuildContext context, Function(int) changePage) {
    return Container(
        color: darkPurple,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
          child: MediaQuery.of(context).size.width < 650 ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              footerLeft(),
              const SizedBox(height: 20),
              footerRight(changePage)
            ],
          ) : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              footerLeft(),
              const SizedBox(width: 20),
              footerRight(changePage)
            ],
          ),
        ));
  }

}
