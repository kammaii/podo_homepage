import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:podo_homepage/common/my_widgets.dart';
import 'package:podo_homepage/common/values.dart';
import 'package:podo_homepage/screens/premium.dart';
import 'package:http/http.dart' as http;

String? name;
String? email;
String? subject;
String? message;
final _formKey = GlobalKey<FormState>();

Widget getForm(String title, Function(String) fn, {int maxLine = 1}) {
  return Column(
    children: [
      TextFormField(
        decoration: InputDecoration(
          labelText: texts[title],
          border: const OutlineInputBorder(),
        ),
        maxLines: maxLine,
        validator: (value) {
          if(value == null || value.isEmpty) {
            return '${texts['contact_7']} ${texts[title]}';
          }
          if (texts[title] == "Email" && !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
            return texts['contact_8'];
          }
          return null;
        },
        onChanged: fn,
      ),
      const SizedBox(height: 20),
    ],
  );
}

void emailSent(String title, String content) {
  Get.defaultDialog(
    title: title,
    middleText: content,
    backgroundColor: Colors.white,
    radius: 10,
    actions: [
      ElevatedButton(
        onPressed: () {
          Get.back();
        },
        child: const Text("OK"),
      ),
    ],
  );
}

Widget contact(BuildContext context, Function(int) changePage) {
  double w = MediaQuery.of(context).size.width;

  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: w > 600 ? 500 : w - 100,
            child: Column(
              children: [
                heightSpace,
                MyWidgets().getText(texts['contact_1']!, fontSize: fontSizeMiddle, isBold: true),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        getForm('contact_2', (input) {
                          name = input;
                        }),
                        getForm('contact_3', (input) {
                          email = input;
                        }),
                        getForm('contact_4', (input) {
                          subject = input;
                        }),
                        getForm('contact_5', (input) {
                          message = input;
                        }, maxLine: 5),
                      ],
                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed: () async {
                      if(_formKey.currentState?.validate() ?? false) {
                        print('validated');
                        Map<String,String?> body = {
                          "name": name,
                          "email": email,
                          "subject": subject,
                          "message": message,
                        };
                        final response = await http.post(
                          Uri.parse('https://us-central1-podo-49335.cloudfunctions.net/onContact'),
                          body: body,
                        );

                        if (response.statusCode == 200) {
                          print('이메일 전송 완료');
                          emailSent(texts["contact_9"]!, texts["contact_10"]!);
                          changePage(0);
                        } else {
                          print('오류 발생: ${response.statusCode}');
                          emailSent(texts["contact_11"]!, texts["${response.statusCode}"]!);
                        }
                      } else {
                        print('not validated');
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                      child: MyWidgets().getText(texts['contact_6']!),
                    )),
                heightSpace,
              ],
            ),
          ),
        ],
      ),
      MyWidgets().footer(context, changePage),
    ],
  );
}
