import 'package:advanced_flutter_arabic/presentation/main/pages/home/view/home_page.dart';
import 'package:advanced_flutter_arabic/presentation/main/pages/search/search_page.dart';
import 'package:advanced_flutter_arabic/presentation/main/pages/settings/setting_page.dart';
import 'package:advanced_flutter_arabic/presentation/resources/color_manager.dart';
import 'package:advanced_flutter_arabic/presentation/resources/strings_manager.dart';
import 'package:advanced_flutter_arabic/presentation/resources/values_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'pages/notifications/notifications_page.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  List<Widget> pages = [
    HomePage(),
    SearchPage(),
    NotificationPage(),
    SettingPage()
  ];

  List<String> titles = [
    AppStrings.home,
    AppStrings.search,
    AppStrings.notification,
    AppStrings.setting
  ];

  var _title = AppStrings.home;
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title,style: Theme.of(context).textTheme.titleSmall,),
      ),
      body: pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow:[ BoxShadow(
            color: ColorManager.lightGrey,
            spreadRadius: AppSize.s1,
          )]
        ),
        child: BottomNavigationBar(
          selectedItemColor: ColorManager.primary,
          unselectedItemColor: ColorManager.grey,
          currentIndex: _currentIndex,
          onTap: onTap,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home_outlined),label: AppStrings.home.tr()),
            BottomNavigationBarItem(icon: Icon(Icons.search),label: AppStrings.search.tr()),
            BottomNavigationBarItem(icon: Icon(Icons.notifications_none_outlined),label: AppStrings.notification.tr()),
            BottomNavigationBarItem(icon: Icon(Icons.settings_outlined),label: AppStrings.setting.tr()),
          ],
        ),
      ),
    );
  }
  onTap(int index ){
    setState(() {
      _currentIndex = index;
      _title = titles[index];
    });
  }

}
