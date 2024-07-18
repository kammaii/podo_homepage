import 'package:flutter/material.dart';
import 'package:podo_homepage/common/my_widgets.dart';
import '../common/values.dart';

class Footer {
  Widget footer (BuildContext context) {
    return Container(
        color: darkPurple,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
          child: MediaQuery.of(context).size.width < 650 ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyWidgets().getText('ㆍ Awesome Korean | Jeongwoo Park', fontColor: Colors.white, fontSize: 10),
                  MyWidgets().getText('ㆍ Contact | akorean.help@gmail.com', fontColor: Colors.white, fontSize: 10),
                  MyWidgets().getText('ㆍ Business Registration Number | 240-14-01074',
                      fontColor: Colors.white, fontSize: 10),
                  MyWidgets().getText('ㆍ Mail order sales Registration Number | 2019-대전중구-0212',
                      fontColor: Colors.white, fontSize: 10),
                  const SizedBox(height: 10),
                  GestureDetector(
                      onTap: () {},
                      child: MyWidgets().getText('ㆍ Terms of Service', fontColor: Colors.white, fontSize: 10)),
                  GestureDetector(
                      onTap: () {},
                      child: MyWidgets().getText('ㆍ Privacy Policy', fontColor: Colors.white, fontSize: 10)),
                ],
              ),
              const SizedBox(height: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(onPressed: () {}, icon: const Icon(Icons.email), color: Colors.white),
                      IconButton(onPressed: () {}, icon: const Icon(Icons.email), color: Colors.white),
                      IconButton(onPressed: () {}, icon: const Icon(Icons.email), color: Colors.white),
                      IconButton(onPressed: () {}, icon: const Icon(Icons.email), color: Colors.white),
                      IconButton(onPressed: () {}, icon: const Icon(Icons.email), color: Colors.white),
                    ],
                  ),
                  const SizedBox(height: 10),
                  MyWidgets().getText('© 2023 Awesome Korean, All rights reserved.', fontColor: Colors.white, fontSize: 10),
                ],
              )
            ],
          ) : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyWidgets().getText('ㆍ Awesome Korean | Jeongwoo Park', fontColor: Colors.white, fontSize: 10),
                  MyWidgets().getText('ㆍ Contact | akorean.help@gmail.com', fontColor: Colors.white, fontSize: 10),
                  MyWidgets().getText('ㆍ Business Registration Number | 240-14-01074',
                      fontColor: Colors.white, fontSize: 10),
                  MyWidgets().getText('ㆍ Mail order sales Registration Number | 2019-대전중구-0212',
                      fontColor: Colors.white, fontSize: 10),
                  const SizedBox(height: 10),
                  GestureDetector(
                      onTap: () {},
                      child: MyWidgets().getText('ㆍ Terms of Service', fontColor: Colors.white, fontSize: 10)),
                  GestureDetector(
                      onTap: () {},
                      child: MyWidgets().getText('ㆍ Privacy Policy', fontColor: Colors.white, fontSize: 10)),
                ],
              ),
              const SizedBox(width: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(onPressed: () {}, icon: const Icon(Icons.email), color: Colors.white),
                      IconButton(onPressed: () {}, icon: const Icon(Icons.email), color: Colors.white),
                      IconButton(onPressed: () {}, icon: const Icon(Icons.email), color: Colors.white),
                      IconButton(onPressed: () {}, icon: const Icon(Icons.email), color: Colors.white),
                      IconButton(onPressed: () {}, icon: const Icon(Icons.email), color: Colors.white),
                    ],
                  ),
                  const SizedBox(height: 10),
                  MyWidgets().getText('© 2023 Awesome Korean, All rights reserved.', fontColor: Colors.white, fontSize: 10),
                ],
              )
            ],
          ),
        ));

  }
}