import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:podo_homepage/common/my_widgets.dart';
import 'package:podo_homepage/common/values.dart';
import 'package:podo_homepage/screens/brand.dart';
import 'package:podo_homepage/screens/home.dart';
import 'package:podo_homepage/screens/preview.dart';
import 'firebase_options.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(HomeController());
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
    return GetMaterialApp(
      title: 'Flutter Demo',
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
  final controller = Get.find<HomeController>();
  int selectedIndex = 0;

  Widget menuTitle(int index, String title) {
    Color color = selectedIndex == index ? darkPurple : Colors.black;
    return GestureDetector(
        onTap: () {
          setState(() {
            controller.sc.jumpTo(0);
            selectedIndex = index;
          });
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
    return menuList;
  }

  ListTile getMenuTile(BuildContext context, IconData icon, String title, int index) {
    return ListTile(
      leading: Icon(icon, color: selectedIndex == index ? Colors.white : darkPurple),
      title: MyWidgets()
          .getText(texts[title]!, fontColor: selectedIndex == index ? Colors.white : darkPurple, isBold: true),
      selected: selectedIndex == index,
      onTap: () {
        setState(() {
          controller.sc.jumpTo(0);
          selectedIndex = index;
          Navigator.pop(context);
        });
      },
      selectedTileColor: darkPurple,
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [home(context), brand(context), preview(context), brand(context), brand(context)];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Padding(
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
      body: SingleChildScrollView(controller: controller.sc, child: pages[selectedIndex]),
      drawer: MediaQuery.of(context).size.width < 850
          ? Drawer(
              child: ListView(children: [
                getMenuTile(context, Icons.home, "main_1", 0),
                getMenuTile(context, Icons.history, "main_2", 1),
                getMenuTile(context, Icons.app_shortcut_rounded, "main_3", 2),
                getMenuTile(context, Icons.workspace_premium_rounded, "main_4", 3),
                getMenuTile(context, Icons.library_books_rounded, "main_5", 4),
                getMenuTile(context, Icons.email_rounded, "main_6", 5),
              ]),
            )
          : null,
    );
  }
}
