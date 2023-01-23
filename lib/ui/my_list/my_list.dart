import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:savyor/application/core/extensions/extensions.dart';
import 'package:savyor/constant/Images/svgs.dart';
import 'package:savyor/constant/constants.dart';
import 'package:savyor/constant/style.dart';
import 'package:savyor/ui/base/base_widget.dart';
import 'package:savyor/ui/my_list/component/mylist_item.dart';
import 'package:savyor/ui/my_list/component/search_delegate.dart';
import 'package:savyor/ui/widget/section_horizontal_widget.dart';

class MyList extends BaseStateFullWidget {
  MyList({Key? key}) : super(key: key);

  @override
  MyListState createState() => MyListState();
}

class MyListState extends State<MyList> {
  bool isDec = true;
  final _list = List.generate(10, (index) => 'Retailer $index').toList();
  bool readOnly = true;
  List<String> list = [];
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
   list = _list;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Style.scaffoldBackground,
        elevation: 1,
        title: CupertinoTextField(
          onTap: readOnly ? () async {
           List<String> result = await showSearch(context: context, delegate: CustomSearchDelegate(list: list));
           setState(() {
             list = result;
             if(list.isNotEmpty){
               readOnly = false;
               textEditingController.text = list[0];
               FocusManager.instance.primaryFocus?.unfocus();
             }
           });
          }:null,
          readOnly: readOnly,
          placeholder: 'I\'m looking for...',
          padding: const EdgeInsets.all(10),
          textInputAction: TextInputAction.search,
          placeholderStyle: context.textTheme.subtitle2?.copyWith(fontFamily: 'DM Sans', fontSize: 15, color: Style.unSelectedColor),
          prefix: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Assets.search,
          ),
          onChanged: (input){
            if(input.isEmpty){
            setState(() {
              readOnly = true;
              textEditingController.clear();
              FocusManager.instance.primaryFocus?.unfocus();
            });
            }
          },
          onEditingComplete: () async {
            if(textEditingController.text.isNotEmpty) {
              List<String> result = await showSearch(query: textEditingController.text,context: context, delegate: CustomSearchDelegate(list: list));
              setState(() {
                list = result;
                if (list.isNotEmpty) {
                  readOnly = false;
                  textEditingController.text = list[0];
                  FocusManager.instance.primaryFocus?.unfocus();
                }
              });
            }
          },
          controller: textEditingController,
          //prefixInsets: const EdgeInsets.only(left: 8.0),
          suffix:  Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: const Icon(
              CupertinoIcons.xmark_circle_fill,
              color: Style.accentColor,
            ).onTap((){
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
          preferredSize: const Size.fromHeight(40),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Text(
                  'Sort by:',
                  style: context.textTheme.subtitle2?.copyWith(fontFamily: 'DM Sans', color: Style.unSelectedColor, fontSize: 15),
                ),
                widget.dimens.k12.horizontalBoxPadding(),
                TabBar(
                  indicator: const UnderlineTabIndicator(
                      borderSide: BorderSide(
                        width: 1,
                        color: Style.primaryColor,
                      ),
                      insets: EdgeInsets.only(bottom: 10, left: 0, right: 12)),
                  isScrollable: true,
                  labelPadding: const EdgeInsets.only(right: 12, top: 4),
                  unselectedLabelColor: Style.unSelectedColor,
                  labelColor: Style.primaryColor,
                  labelStyle: context.textTheme.subtitle2?.copyWith(fontFamily: 'DM Sans', fontSize: 15),
                  unselectedLabelStyle: context.textTheme.subtitle2?.copyWith(fontFamily: 'DM Sans', fontSize: 15),
                  tabs: ['Retailer', 'Price', 'Day'].map((label) => Tab(text: label)).toList(),
                ),
                widget.dimens.k2.horizontalBoxPadding(),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: SectionHorizontalWidget(
                    firstWidget: Assets.arrowDown(isDec ? Style.primaryColor : null).onTap(() {
                      setState(() {
                        isDec = !isDec;
                      });
                    }),
                    secondWidget: Assets.arrowUp(isDec ? null : Style.primaryColor).onTap(() {
                      setState(() {
                        isDec = !isDec;
                      });
                    }),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
        child: ListView.builder(
            itemCount: list.length,
            itemBuilder: (_, index) {
              return MyListItem(title: list[index],);
            }),
      ),
    );
  }
}
