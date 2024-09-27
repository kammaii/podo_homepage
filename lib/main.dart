import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:podo_homepage/common/my_widgets.dart';
import 'package:podo_homepage/common/values.dart';
import 'package:podo_homepage/screens/brand.dart';
import 'package:podo_homepage/screens/contact.dart';
import 'package:podo_homepage/screens/curriculum.dart';
import 'package:podo_homepage/screens/home.dart';
import 'package:podo_homepage/screens/premium.dart';
import 'package:podo_homepage/screens/preview.dart';
import 'package:url_launcher/url_launcher.dart';
import 'firebase_options.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:get/get.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(MainController());
  runApp(const MyApp());

  // await EasyLocalization.ensureInitialized();
  // String langCode = html.window.navigator.language.split('-')[0];
  // print('Browser Language: $langCode');
  // const supportedLanguages = ['en', 'es', 'fr', 'de', 'pt', 'id', 'ru'];
  // if(!supportedLanguages.contains(langCode)) {
  //   langCode = 'en';
  // }
  // runApp(EasyLocalization(supportedLocales: const [
  //   Locale('en'),
  //   Locale('es'),
  //   Locale('fr'),
  //   Locale('de'),
  //   Locale('pt'),
  //   Locale('id'),
  //   Locale('ru'),
  // ], path: 'assets/translations',startLocale: Locale(langCode), fallbackLocale: const Locale('en'), child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseAnalytics.instance;

    return GetMaterialApp(
      title: 'Podo Korean',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      builder: (context, child) => ResponsiveWrapper.builder(
        child!,
        maxWidth: 1200,
        minWidth: 450,
        defaultScale: true,
        breakpoints: const [
          ResponsiveBreakpoint.resize(450, name: MOBILE),
          ResponsiveBreakpoint.resize(800, name: TABLET),
          ResponsiveBreakpoint.autoScale(1200, name: DESKTOP),
        ],
      ),
      home: MyHomePage(),
      // localizationsDelegates: context.localizationDelegates,
      // supportedLocales: context.supportedLocales,
      // locale: context.locale,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final controller = Get.find<MainController>();

  void changePage(int pageIndex) {
    controller.selectedIndex = pageIndex;
    setState(() {
      if (pageIndex == 0) {
        controller.sc.jumpTo(controller.homeScrollOffset);
      } else if (pageIndex == 1) {
        controller.sc.jumpTo(controller.brandScrollOffset);
      } else {
        controller.sc.jumpTo(0);
      }
    });
  }

  Widget menuTitle(int index, String title) {
    Color color = controller.selectedIndex == index ? darkPurple : Colors.black;
    return GestureDetector(
        onTap: () {
          if (index == 5) {
            openBlog();
          } else {
            changePage(index);
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: MyWidgets().getText(title, isBold: true, fontColor: color),
        ));
  }

  List<Widget> getMenu(BuildContext context) {
    List<Widget> menuList = [];
    menuList.add(menuTitle(0, texts["main_1"]!));
    menuList.add(menuTitle(1, texts["main_2"]!));
    menuList.add(menuTitle(2, texts["main_3"]!));
    menuList.add(menuTitle(3, texts["main_4"]!));
    menuList.add(menuTitle(4, texts["main_5"]!));
    menuList.add(menuTitle(5, texts["main_6"]!));
    menuList.add(menuTitle(6, texts["main_7"]!));
    return menuList;
  }

  ListTile getMenuTile(BuildContext context, IconData icon, String title, int index) {
    return ListTile(
      leading: Icon(icon, color: controller.selectedIndex == index ? Colors.white : darkPurple),
      title: MyWidgets().getText(texts[title]!,
          fontColor: controller.selectedIndex == index ? Colors.white : darkPurple, isBold: true),
      selected: controller.selectedIndex == index,
      onTap: () {
        if (index == 5) {
          openBlog();
        } else {
          Navigator.pop(context);
          changePage(index);
        }
      },
      selectedTileColor: darkPurple,
    );
  }

  openBlog() async {
    String urlString = 'https://blog.podokorean.com';
    Uri url = Uri.parse(urlString);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $urlString';
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      home(context, changePage),
      brand(context, changePage),
      preview(context, changePage),
      curriculum(context, changePage),
      premium(context, changePage),
      brand(context, changePage),
      contact(context, changePage),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: GestureDetector(
          onTap: () {
            changePage(0);
            controller.sc.jumpTo(0);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset('assets/images/podo_logo.png', width: 100, height: 50),
                    MyWidgets().getText('Podo Korean', isBold: true),
                  ],
                ),
                MediaQuery.of(context).size.width < 850
                    ? const SizedBox.shrink()
                    : Row(
                        children: getMenu(context),
                      )
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(controller: controller.sc, child: pages[controller.selectedIndex]),
      drawer: MediaQuery.of(context).size.width < 850
          ? Drawer(
              child: ListView(children: [
                getMenuTile(context, Icons.home, "main_1", 0),
                getMenuTile(context, Icons.history, "main_2", 1),
                getMenuTile(context, Icons.app_shortcut_rounded, "main_3", 2),
                getMenuTile(context, Icons.school_rounded, "main_4", 3),
                getMenuTile(context, Icons.workspace_premium_rounded, "main_5", 4),
                getMenuTile(context, Icons.library_books_rounded, "main_6", 5),
                getMenuTile(context, Icons.email_rounded, "main_7", 6),
              ]),
            )
          : null,
    );
  }
}

class MainController extends GetxController {
  ScrollController sc = ScrollController();
  ScrollController mc = ScrollController();
  late Timer timer;
  int selectedIndex = 0;
  double homeScrollOffset = 0.0;
  double brandScrollOffset = 0.0;

  @override
  void onInit() {
    super.onInit();
    sc.addListener(() {
      if (selectedIndex == 0) {
        homeScrollOffset = sc.offset;
      } else if (selectedIndex == 1) {
        brandScrollOffset = sc.offset;
      }
    });
    timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (mc.hasClients) {
        final maxScrollExtent = mc.position.maxScrollExtent;
        final pixels = mc.position.pixels;

        if (pixels >= maxScrollExtent) {
          mc.jumpTo(0);
        }
        mc.animateTo(pixels + 10, duration: const Duration(milliseconds: 100), curve: Curves.linear);
      }
    });
  }

  @override
  void onClose() {
    sc.dispose();
    mc.dispose();
    timer.cancel();
    super.onClose();
  }
}
