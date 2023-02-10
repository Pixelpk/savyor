import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:savyor/application/core/extensions/extensions.dart';
import 'package:savyor/constant/Images/svgs.dart';
import 'package:savyor/constant/style.dart';
import 'package:savyor/ui/account/account_screen.dart';
import 'package:savyor/ui/base/base_widget.dart';
import 'package:savyor/ui/browser/browser_main_page.dart';
import 'package:savyor/ui/browser/web_view.dart';
import 'package:savyor/ui/my_list/my_list.dart';

import '../my_list/my_list_view_model.dart';

class Home extends BaseStateFullWidget {
  Home({Key? key}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  int selectedItem = 1;
  PageController controller = PageController(initialPage: 1);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: PageView(
          controller: controller,
          physics: NeverScrollableScrollPhysics(),
          onPageChanged: (index){
            setState((){
              selectedItem = index;
            });
          },
          children: [BrowserMainPage(),ChangeNotifierProvider(
              create: (_)=>MyListViewModel(),child: MyList()), AccountScreen()],
        ),
        bottomNavigationBar: Container(color: Colors.white,
          child: Material(
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            // elevation: 12.0,

            child: ClipRRect(
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              child: BottomNavigationBar(
                currentIndex: selectedItem,
                onTap: (index) {
                  setState(() {
                    selectedItem = index;
                    controller.jumpToPage(index);
                  });
                },
                backgroundColor: Style.scaffoldBackground,
                selectedItemColor: Style.primaryColor,
                unselectedItemColor: Style.accentColor,
                selectedLabelStyle: context.textTheme.subtitle2?.copyWith(fontFamily: 'DM Sans', height: 1.5),
                unselectedLabelStyle: context.textTheme.subtitle2?.copyWith(fontFamily: 'DM Sans', height: 1.5),
                type: BottomNavigationBarType.fixed,
                items: [
                  BottomNavigationBarItem(label: 'Browse', icon: Assets.browser(Style.accentColor), activeIcon: Assets.browser(Style.primaryColor)),
                  BottomNavigationBarItem(label: 'My List', icon: Assets.list(Style.accentColor), activeIcon: Assets.list(Style.primaryColor)),
                  BottomNavigationBarItem(label: 'Account', icon: Assets.user(Style.accentColor), activeIcon: Assets.user(Style.primaryColor))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
