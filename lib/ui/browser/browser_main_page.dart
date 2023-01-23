import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:savyor/application/core/extensions/extensions.dart';
import 'package:savyor/application/main_config/routes/route_path.dart';
import 'package:savyor/constant/Images/svgs.dart';
import 'package:savyor/constant/constants.dart';
import 'package:savyor/constant/style.dart';
import 'package:savyor/ui/base/base_widget.dart';
import 'package:savyor/ui/browser/model/browser_model.dart';
import 'package:savyor/ui/my_list/component/mylist_item.dart';
import 'package:savyor/ui/my_list/component/search_delegate.dart';
import 'package:savyor/ui/widget/section_horizontal_widget.dart';
import 'package:savyor/ui/widget/section_vertical_widget.dart';

class BrowserMainPage extends BaseStateFullWidget {
  BrowserMainPage({Key? key}) : super(key: key);

  @override
  BrowserMainPageState createState() => BrowserMainPageState();
}

class BrowserMainPageState extends State<BrowserMainPage> {
  bool isDec = true;
  final _list = [
    BrowserModel(img: 'assets/amazon.png', name: 'Amazon'),
    BrowserModel(img: 'assets/target.png', name: 'Target'),
    BrowserModel(img: 'assets/nike.png', name: 'Nike'),
    BrowserModel(img: 'assets/amazon.png', name: 'Amazon'),
    BrowserModel(img: 'assets/target.png', name: 'Target'),
    BrowserModel(img: 'assets/nike.png', name: 'Nike'),
    BrowserModel(img: 'assets/amazon.png', name: 'Amazon'),
    BrowserModel(img: 'assets/target.png', name: 'Target'),
    BrowserModel(img: 'assets/nike.png', name: 'Nike'),
    BrowserModel(img: 'assets/amazon.png', name: 'Amazon'),
    BrowserModel(img: 'assets/target.png', name: 'Target'),
    BrowserModel(img: 'assets/nike.png', name: 'Nike'),
    BrowserModel(img: 'assets/amazon.png', name: 'Amazon'),
    BrowserModel(img: 'assets/target.png', name: 'Target'),
    BrowserModel(img: 'assets/nike.png', name: 'Nike'),
    BrowserModel(img: 'assets/amazon.png', name: 'Amazon'),
    BrowserModel(img: 'assets/target.png', name: 'Target'),
    BrowserModel(img: 'assets/nike.png', name: 'Nike'),
    BrowserModel(img: 'assets/amazon.png', name: 'Amazon'),
    BrowserModel(img: 'assets/target.png', name: 'Target'),
    BrowserModel(img: 'assets/nike.png', name: 'Nike'),
  ];
  bool readOnly = true;
  List<BrowserModel> list = [];
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    list = _list;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: Style.scaffoldBackground,
        elevation: 0,
        title: CupertinoTextField(
          onTap: readOnly
              ? () async {
                  List<String> result = await showSearch(context: context, delegate: CustomSearchDelegate(list: list.map((e) => e.name).toList()));
                  setState(() {
                    list = _list.where((element) => result.contains(element.name)).toList();
                    if (list.isNotEmpty) {
                      readOnly = false;
                      textEditingController.text = list[0].name;
                      FocusManager.instance.primaryFocus?.unfocus();
                    }
                  });
                }
              : null,
          readOnly: readOnly,
          placeholder: 'I\'m looking for...',
          padding: const EdgeInsets.all(10),
          textInputAction: TextInputAction.search,
          placeholderStyle: context.textTheme.subtitle2?.copyWith(fontFamily: 'DM Sans', fontSize: 15, color: Style.unSelectedColor),
          prefix: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Assets.search,
          ),
          onChanged: (input) {
            if (input.isEmpty) {
              setState(() {
                readOnly = true;
                textEditingController.clear();
                FocusManager.instance.primaryFocus?.unfocus();
              });
            }
          },
          onEditingComplete: () async {
            if (textEditingController.text.isNotEmpty) {
              List<String> result = await showSearch(
                  query: textEditingController.text, context: context, delegate: CustomSearchDelegate(list: list.map((e) => e.name).toList()));
              setState(() {
                list = _list.where((element) => result.contains(element.name)).toList();
                if (list.isNotEmpty) {
                  readOnly = false;
                  textEditingController.text = list[0].name;
                  FocusManager.instance.primaryFocus?.unfocus();
                }
              });
            }
          },
          controller: textEditingController,
          //prefixInsets: const EdgeInsets.only(left: 8.0),
          suffix: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: const Icon(
              CupertinoIcons.xmark_circle_fill,
              color: Style.accentColor,
            ).onTap(() {
              setState(() {
                textEditingController.clear();
                readOnly = true;
                list = _list;
              });
            }),
          ),
          suffixMode: OverlayVisibilityMode.editing,

          decoration: BoxDecoration(color: const Color(0xffF8F8F9), borderRadius: BorderRadius.circular(8)),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(30),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Text('Feature stores', style: context.textTheme.headline6?.copyWith(color: Style.textColor, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
        child: SectionVerticalWidget(
          gap: 0,
          firstWidget: Expanded(
            child: SingleChildScrollView(
              child: StaggeredGrid.count(
                crossAxisCount: 4,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                children: list
                    .map(
                      (e) => StaggeredGridTile.count(
                          crossAxisCellCount: 2,
                          mainAxisCellCount: 2,
                          child: SectionVerticalWidget(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            firstWidget: SizedBox(
                                height: 130,
                                child: Image.asset(
                                  e.img,
                                )),
                            secondWidget:
                                Row(
                                  children: [
                                    Text(e.name, style: context.textTheme.subtitle1?.copyWith(color: Style.textColor, fontWeight: FontWeight.w500)),
                                  ],
                                ),
                          ).onTap(() {
                            widget.navigator.pushNamed(RoutePath.webView, object: '');
                          })),
                    )
                    .toList(),
              ),
            ),
          ),
          secondWidget: const Divider(),
          thirdWidget: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                'We are always adding support to new stores. If you can’t find the store you are shopping for, blow the whistle and we are on it!',
                style: context.textTheme.subtitle1?.copyWith(color: Style.textColor.withOpacity(0.75))),
          ),
        ),
      ),
    );
  }
}
