import 'package:cableproject/utilities/app_color.dart';
import 'package:cableproject/view/authentication/Home.dart';
// import 'package:cableproject/view/authentication/welcome.dart';
// import 'package:demo_project/utilities/app_color.dart';

import 'package:flutter/material.dart';

// import '../view/authentication/home_screen.dart';
// import '../view/authentication/notifiction_screen.dart';
// import '../view/authentication/profile.dart';
import 'app_constant.dart';
import 'app_image.dart';

class AppFooter extends StatelessWidget {
  const AppFooter(
      {key, required this.selectedMenu, required this.notificationCount})
      : super(key: key);

  final BottomMenus selectedMenu;
  final int notificationCount;

  @override
  Widget build(BuildContext context) {
    // print('notificationCount=====> $notificationCount');
    // print(notificationCount);
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 10 / 100,
      color: AppColor.themeColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SafeArea(
            top: false,
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    if (BottomMenus.notification != selectedMenu) {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Home()));
                    }
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 33.3 / 100,
                    child: Column(
                      children: [
                        Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      BottomMenus.notification == selectedMenu
                                          ? AppImage.activeNotificationIcon
                                          : AppImage.dactiveNotificationIcon))),
                        ),
                        Text(
                          "Notification",
                          style: TextStyle(
                              color: BottomMenus.notification == selectedMenu
                                  ? Colors.orange
                                  : Colors.white,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (BottomMenus.home != selectedMenu) {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Home()));
                    }
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 33.3 / 100,
                    child: Column(
                      children: [
                        Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: AssetImage(
                                      BottomMenus.home == selectedMenu
                                          ? AppImage.activeHomeIcon
                                          : AppImage.dactiveHomeIcon))),
                        ),
                        Text(
                          "Home",
                          style: TextStyle(
                              color: BottomMenus.home != selectedMenu
                                  ? Colors.white
                                  : Colors.orange,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  // onTap: () {
                  //   if (BottomMenus.profile != selectedMenu) {
                  //     Navigator.pushReplacement(context,
                  //         MaterialPageRoute(builder: (context) => ()));
                  //   }
                  // },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 33.3 / 100,
                    child: Column(
                      children: [
                        Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      BottomMenus.profile == selectedMenu
                                          ? AppImage.activeProfileIcon
                                          : AppImage.deactiveProfileIcon))),
                        ),
                        Text(
                          "Profile",
                          style: TextStyle(
                              color: BottomMenus.profile != selectedMenu
                                  ? Colors.white
                                  : Colors.orange,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
