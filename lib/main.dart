import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:get/get.dart';
import 'package:podo_homepage/common/my_widgets.dart';
import 'package:podo_homepage/common/values.dart';
import 'package:podo_homepage/common/add_contact.dart';
import 'package:podo_homepage/screens/brand.dart';
import 'package:podo_homepage/screens/contact.dart';
import 'package:podo_homepage/screens/curriculum.dart';
import 'package:podo_homepage/screens/home.dart';
import 'package:podo_homepage/screens/premium.dart';
import 'package:podo_homepage/screens/preview.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:url_launcher/url_launcher.dart';
import 'firebase_options.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:js' as js;
import 'dart:html' as html;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(MainController());
  setUrlStrategy(PathUrlStrategy());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const HOME = 'Home';
  static const BRAND_STORY = 'Brand Story';
  static const APP_PREVIEW = 'App Preview';
  static const CURRICULUM = 'Curriculum';
  static const PREMIUM = 'Premium';
  static const BLOG = 'Blog';
  static const CONTACT = 'Contact';

  @override
  Widget build(BuildContext context) {

    GetPage getPage(String name) {
      String routeName = name.replaceAll(' ', '').toLowerCase();
      routeName = '/$routeName';
      if (name == HOME) {
        routeName = '/';
      }
      return GetPage(name: routeName, page: () => MyHomePage(pageName: name), transition: Transition.noTransition);
    }

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
      getPages: [
        getPage(HOME),
        getPage(BRAND_STORY),
        getPage(APP_PREVIEW),
        getPage(CURRICULUM),
        getPage(PREMIUM),
        getPage(BLOG),
        getPage(CONTACT),
        GetPage(name: '/add_contact', page: () => const AddContact(), transition: Transition.noTransition),
      ],
      initialRoute: '/',
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({required this.pageName, super.key});

  String pageName;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final controller = Get.find<MainController>();
  ScrollController sc = ScrollController();
  bool isLoading = false;
  String source = 'website';



  @override
  void initState() {
    super.initState();
    final uri = Uri.parse(html.window.location.href);
    final shouldShowDialog = uri.queryParameters['showDialog'] == 'true';

    if(shouldShowDialog) {
      source = uri.queryParameters['source'] ?? 'website';
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showWorkbookDownloadDialog();
      });
    }
  }

  void logEvent(String name, Map<String, dynamic> params) {
    final jsParams = js.JsObject.jsify(params);
    js.context.callMethod('gtag', ['event', name, jsParams]);
  }

  void changePage(String title, {bool shouldOff = false}) {
    controller.selectedPage = title;
    logEvent('view_menu', {'title': title});
    String route = title.replaceAll(' ', '').toLowerCase();
    route = '/$route';
    if (title == MyApp.HOME) {
      route = '/';
    }
    if (shouldOff) {
      Get.offNamed(route);
    } else {
      Get.toNamed(route);
    }
  }

  Widget menuTitle(String title) {
    Color color = controller.selectedPage == title ? darkPurple : Colors.black;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
          onTap: () {
            if (title == MyApp.BLOG) {
              openBlog();
            } else {
              changePage(title, shouldOff: true);
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: MyWidgets().getText(title, isBold: true, fontColor: color),
          )),
    );
  }

  List<Widget> getMenu(BuildContext context) {
    List<Widget> menuList = [];
    menuList.add(menuTitle(MyApp.HOME));
    menuList.add(menuTitle(MyApp.BRAND_STORY));
    menuList.add(menuTitle(MyApp.APP_PREVIEW));
    menuList.add(menuTitle(MyApp.CURRICULUM));
    menuList.add(menuTitle(MyApp.PREMIUM));
    menuList.add(menuTitle(MyApp.BLOG));
    menuList.add(menuTitle(MyApp.CONTACT));
    return menuList;
  }

  ListTile getMenuTile(BuildContext context, IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: controller.selectedPage == title ? Colors.white : darkPurple),
      title: MyWidgets()
          .getText(title, fontColor: controller.selectedPage == title ? Colors.white : darkPurple, isBold: true),
      selected: controller.selectedPage == title,
      onTap: () {
        if (title == MyApp.BLOG) {
          openBlog();
        } else {
          Navigator.pop(context);
          changePage(title, shouldOff: true);
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

  showWorkbookDownloadDialog() {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    bool agreedToEmails = false;
    final emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");

    Get.dialog(StatefulBuilder(
      builder: (context, setState) {
        final isFormValid = nameController.text.isNotEmpty &&
            emailController.text.isNotEmpty &&
            emailRegex.hasMatch(emailController.text) &&
            agreedToEmails;

        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          contentPadding: const EdgeInsets.all(24),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(CupertinoIcons.gift_fill, size: 60, color: darkPurple),
                const SizedBox(height: 16),

                // 큰 타이틀
                MyWidgets().getText('Get Your Free Hangul Workbook!',
                    fontSize: 20, isBold: true, fontColor: darkPurple),

                // 부제목
                const SizedBox(height: 8),
                MyWidgets().getText(
                  'Start learning Korean the fun and easy way',
                  fontColor: Colors.grey,
                ),
                const SizedBox(height: 24),

                // 이름 입력
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (_) => setState(() {}),
                ),
                const SizedBox(height: 16),

                // 이메일 입력
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (_) => setState(() {}),
                ),
                const SizedBox(height: 16),

                // 이메일 수신 동의 체크박스
                Row(
                  children: [
                    Checkbox(
                      value: agreedToEmails,
                      onChanged: (value) {
                        setState(() {
                          agreedToEmails = value ?? false;
                        });
                      },
                      activeColor: darkPurple,
                    ),
                    Expanded(
                      child: MyWidgets().getText(
                        'I agree to receive emails from Podo Korean.',
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // 버튼
                isLoading
                    ? const CircularProgressIndicator()
                    : SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.send),
                    label: const Text('Send My Workbook'),
                    onPressed: isFormValid
                        ? () async {
                      setState(() {
                        isLoading = true;
                      });
                      final name = nameController.text;
                      final email = emailController.text;

                      final response = await http.post(
                        Uri.parse(
                            'https://us-central1-podo-49335.cloudfunctions.net/onAddContactToZoho'),
                        headers: {
                          'Content-Type': 'application/x-www-form-urlencoded',
                        },
                        body: {
                          'email': email,
                          'name': name,
                          'source': source,
                        },
                      );
                      isLoading = false;

                      Get.back();
                      if (response.statusCode == 200) {
                        print('성공');
                        logEvent('submit_contact_form', {'email': email, 'name': name});
                        launchUrl(Uri.parse('https://www.podokorean.com/thankyou.html'));
                      } else {
                        print('오류 발생: ${response.statusCode}');
                        String msg = json.decode(response.body)['message'];
                        Get.dialog(AlertDialog(
                          title: const Text('Failed'),
                          content: Text(msg),
                          actions: [
                            TextButton(onPressed: () => Get.back(), child: const Text('OK'))
                          ],
                        ));
                      }
                    }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isFormValid ? darkPurple : Colors.grey.shade300,
                      foregroundColor: isFormValid ? Colors.white : Colors.grey.shade700,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                // 보조 설명
                Text(
                  'Immediate download. No sign-up required.',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    controller.selectedPage = widget.pageName;
    Widget getPage() {
      Widget widget = home(context, changePage);
      String pageName = controller.selectedPage;
      switch (pageName) {
        case MyApp.HOME:
          widget = home(context, changePage);
          break;
        case MyApp.BRAND_STORY:
          widget = brand(context, changePage);
          break;
        case MyApp.APP_PREVIEW:
          widget = preview(context, changePage);
          break;
        case MyApp.CURRICULUM:
          widget = curriculum(context, changePage);
          break;
        case MyApp.PREMIUM:
          widget = premium(context, changePage);
          break;
        case MyApp.CONTACT:
          widget = contact(context, changePage);
          break;
      }
      return widget;
    }

    sc = ScrollController();
    controller.sc = sc;
    sc.addListener(() {
      if (controller.selectedPage == MyApp.HOME) {
        controller.homeScrollOffset = sc.offset;
      } else if (controller.selectedPage == MyApp.BRAND_STORY) {
        controller.brandScrollOffset = sc.offset;
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        if (controller.selectedPage == MyApp.HOME) {
          sc.jumpTo(controller.homeScrollOffset);
        } else if (controller.selectedPage == MyApp.BRAND_STORY) {
          sc.jumpTo(controller.brandScrollOffset);
        } else {
          sc.jumpTo(0);
        }
      }
    });

    String freeWorkbookTitle = 'Get your FREE Hangul Workbook';
    String freeWorkbookSubTitle = 'Start learning Korean with the beauty of Hangul';
    String freeWorkbookBtn = 'Get Now!';

    Widget freeWorkbookWidget = Container(
      color: const Color(0xFFFFEB3B),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(CupertinoIcons.gift_fill, color: Color(0xffF74A30), size: 40),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyWidgets().getText(freeWorkbookTitle, fontSize: 18, isBold: true),
              MyWidgets().getText(freeWorkbookSubTitle),
            ],
          ),
          const SizedBox(width: 15),
          ElevatedButton(
            onPressed: () {
              logEvent('open_workbook_dialog', {});
              showWorkbookDownloadDialog();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFD81B60),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: MyWidgets().getText(freeWorkbookBtn, fontColor: Colors.white, isBold: true),
          )
        ],
      ),
    );
    if (MediaQuery.of(context).size.width < 850) {
      freeWorkbookWidget = Container(
        color: const Color(0xFFFFEB3B),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                MyWidgets().getText(freeWorkbookTitle, fontSize: 18, isBold: true),
                MyWidgets().getText(freeWorkbookSubTitle),
                const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () {
                    logEvent('open_workbook_dialog', {});
                    showWorkbookDownloadDialog();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD81B60),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: MyWidgets().getText(freeWorkbookBtn, fontColor: Colors.white, isBold: true),
                ),
              ],
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    changePage(MyApp.HOME, shouldOff: true);
                    controller.homeScrollOffset = 0;
                  },
                  child: Row(
                    children: [
                      Image.asset('assets/images/podo_logo.png', width: 100, height: 50),
                      MyWidgets().getText('Podo Korean', isBold: true),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 20),
              MediaQuery.of(context).size.width < 850
                  ? const SizedBox.shrink()
                  : Row(
                      children: getMenu(context),
                    )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        controller: sc,
        child: Column(
          children: [
            controller.showFreeWorkbook ? freeWorkbookWidget : const SizedBox.shrink(),
            getPage(),
          ],
        ),
      ),
      drawer: MediaQuery.of(context).size.width < 850
          ? Drawer(
              child: ListView(children: [
                getMenuTile(context, Icons.home, MyApp.HOME),
                getMenuTile(context, Icons.history, MyApp.BRAND_STORY),
                getMenuTile(context, Icons.app_shortcut_rounded, MyApp.APP_PREVIEW),
                getMenuTile(context, Icons.school_rounded, MyApp.CURRICULUM),
                getMenuTile(context, Icons.workspace_premium_rounded, MyApp.PREMIUM),
                getMenuTile(context, Icons.library_books_rounded, MyApp.BLOG),
                getMenuTile(context, Icons.email_rounded, MyApp.CONTACT),
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
  String selectedPage = MyApp.HOME;
  double homeScrollOffset = 0.0;
  double brandScrollOffset = 0.0;
  bool showFreeWorkbook = true;

  @override
  void onInit() {
    super.onInit();
    // Home의 리뷰를 왼쪽으로 흐르게 함
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
