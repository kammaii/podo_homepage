import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:podo_homepage/common/my_widgets.dart';
import 'package:podo_homepage/common/values.dart';


const Color mustard = Color(0xffDEA34A);
const Color green = Color(0xff00E0BE);
const Color red = Color(0xffF74A30);

DataColumn getDataColumn(String label) {
  return DataColumn(
    label: Expanded(
      child: Center(
          child: MyWidgets().getText(label)),
    ),
  );
}

DataRow getDataRow(String title, Widget basic, Widget premium, {bool isLimited = false}) {
  return DataRow(cells: <DataCell>[
    DataCell(MyWidgets().getText(title)),
    isLimited
        ? DataCell(Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            basic,
            MyWidgets().getText(texts["premium_10"]!, fontSize: 10, fontColor: mustard),
          ],
        )))
        : DataCell(Center(child: basic)),
    DataCell(Center(child: premium)),
  ]);
}

Widget premium(BuildContext context, Function(int) changePage) {
  return Column(
    children: [
      Container(
        color: bgPurple,
        padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 50),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                children: [
                  MyWidgets().getText(texts["premium_1"]!, isBold: true, fontSize: fontSizeBig, fontColor: darkPurple),
                  heightSpace,
                  DataTable(
                    horizontalMargin: 0,
                    columns: <DataColumn>[
                      getDataColumn(''),
                      getDataColumn(texts["premium_2"]!),
                      getDataColumn(texts["premium_3"]!),
                    ],
                    rows: <DataRow>[
                      getDataRow(
                          texts["premium_4"]!,
                          const Icon(Icons.check_circle_outline, color: mustard),
                          const Icon(Icons.check_circle_outline, color: green),
                          isLimited: true),
                      getDataRow(
                          texts["premium_5"]!,
                          const Icon(Icons.check_circle_outline, color: mustard),
                          const Icon(Icons.check_circle_outline, color: green),
                          isLimited: true),
                      getDataRow(
                          texts["premium_6"]!,
                          const Icon(Icons.check_circle_outline, color: mustard),
                          const Icon(Icons.check_circle_outline, color: green),
                          isLimited: true),
                      getDataRow(
                          texts["premium_7"]!,
                          const Icon(Icons.remove_circle_outline, color: red),
                          const Icon(Icons.check_circle_outline, color: green)),
                      getDataRow(
                          texts["premium_8"]!,
                          const Icon(Icons.remove_circle_outline, color: red),
                          const Icon(Icons.check_circle_outline, color: green)),
                      getDataRow(
                          texts["premium_9"]!,
                          const Icon(Icons.remove_circle_outline, color: red),
                          const Icon(Icons.check_circle_outline, color: green))
                    ],
                  ),
                  heightSpace,
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                      decoration: BoxDecoration(
                        color: red,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: MyWidgets().getText(texts["premium_11"]!, isBold: true, fontColor: Colors.white, fontSize: fontSizeBig)),
                  const SizedBox(height: 20),
                  MyWidgets().getText(texts["premium_12"]!, isBold: true, fontColor: red)
                ],
              ),
            ),
          ],
        ),
      ),
      heightSpace,
      Container(
        color: Colors.white,
        child: MyWidgets().downloadNow(context),
      ),
      MyWidgets().footer(context, changePage)
    ],
  );
}