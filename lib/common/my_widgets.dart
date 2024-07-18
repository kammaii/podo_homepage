import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:podo_homepage/common/values.dart';
import 'package:podo_homepage/screens/brand.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:podo_homepage/common/values.dart';

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

  Widget storeBadge(BuildContext context) {
    double w = MediaQuery.of(context).size.width < 550 ? 150 : 200;
    double gap = MediaQuery.of(context).size.width < 550 ? 30 : 50;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
            onTap: () async {
              runUrl('https://apps.apple.com/kr/app/podo-korean/id6451487431');
            },
            child: Image.asset("assets/images/apple.png",
                width: w)),
        SizedBox(width: gap),
        GestureDetector(
            onTap: () async {
              runUrl('https://play.google.com/store/apps/details?id=net.awesomekorean.newpodo&hl=en_US');
            },
            child: Image.asset("assets/images/google.png",
                width: MediaQuery.of(context).size.width < 550 ? 150 : 200)),
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
}
