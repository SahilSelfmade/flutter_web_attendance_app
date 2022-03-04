// ignore_for_file: avoid_print

import 'package:attendance_app/home_screen.dart';
import 'package:attendance_app/register_employee.dart';
import 'package:attendance_app/screens/crud/business_detail_main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'Models/content_view.dart';
import 'Models/tab_controller_handler.dart';
import 'login_screen.dart';
import 'widgets/custom_tab.dart';
import 'widgets/custom_tab_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  void signOut() async {
    print('Sign out Button Pressed');
    await FirebaseAuth.instance.signOut();
    Get.offAll(
      () => const LoginScreen(),
    );
  }

  List<ContentView> contentViews = [
    // ContentView(
    //   tab: const CustomTab(title: 'Home'),
    //   content: const HomePageScreen(),
    // ),
    ContentView(
      tab: const CustomTab(title: 'View Business'),
      content: const BusinessDetails(),
    ),
    ContentView(
      tab: const CustomTab(title: 'Add Business'),
      content: RegisterEmployeeScreen(
        email: '',
        uid: '',
      ),
    ),
    ContentView(
      tab: const CustomTab(title: 'Sign Out'),
      content: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: MaterialButton(
            padding: EdgeInsets.symmetric(
              horizontal: 25,
              vertical: 15,
            ),
            child: Text(
              'Sign Out',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            textColor: Colors.black,
            color: Colors.white,
            onPressed: () async {
              print('Sign out Button Pressed');
              await FirebaseAuth.instance.signOut();
              Get.offAll(
                () => const LoginScreen(),
              );
            },
          ),
        ),
      ),
    ),
  ];

  late ItemScrollController itemScrollController;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  late double screenHeight;
  late double screenWidth;
  late double sidePadding;
  late TabController tabController;
  late double topPadding;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: contentViews.length, vsync: this);
    itemScrollController = ItemScrollController();
  }

  Widget drawer() {
    return SizedBox(
      width: screenWidth * 0.5,
      child: Drawer(
        child: ListView(
          children: [Container(height: screenHeight * 0.1)] +
              contentViews
                  .map((e) => Container(
                        child: ListTile(
                          title: Text(
                            e.tab.title,
                            style: Theme.of(context).textTheme.button,
                          ),
                          onTap: () {
                            itemScrollController.scrollTo(
                                index: contentViews.indexOf(e),
                                duration: const Duration(milliseconds: 300));
                            Navigator.pop(context);
                          },
                        ),
                      ))
                  .toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    topPadding = screenHeight * 0.05;
    // bottomPadding = screenHeight * 0.03;
    sidePadding = screenWidth * 0.05;

    print('Width: $screenWidth');
    print('Height: $screenHeight');
    return Scaffold(
      backgroundColor: const Color(0xff1e1e24),
      key: scaffoldKey,
      endDrawer: drawer(),
      body: Center(
        child: SizedBox(
          // width: screenWidth < 1000 ? screenWidth * 0.95 : screenWidth * 0.4,
          child: Padding(
            padding: EdgeInsets.only(
              top: topPadding,
              bottom: 0.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /// Tab Bar
                SizedBox(
                  height: screenHeight * 0.05,
                  width: screenWidth * 0.9,
                  // width: screenWidth < 1000
                  //     ? screenWidth * 0.95
                  //     : screenWidth * 0.4,
                  child: CustomTabBar(
                      controller: tabController,
                      tabs: contentViews.map((e) => e.tab).toList()),
                ),

                /// Tab Bar View
                SizedBox(
                  height: screenHeight * 0.9,
                  child: TabControllerHandler(
                    tabController: tabController,
                    child: Center(
                      child: SizedBox(
                        width: screenWidth,
                        child: TabBarView(
                          controller: tabController,
                          children: contentViews.map((e) => e.content).toList(),
                        ),
                      ),
                    ),
                  ),
                ),

                /// Bottom Bar
                // BottomBar()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
