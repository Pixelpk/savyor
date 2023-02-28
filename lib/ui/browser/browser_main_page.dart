import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:savyor/application/core/extensions/extensions.dart';
import 'package:savyor/application/main_config/routes/route_path.dart';
import 'package:savyor/application/network/external_values/iExternalValue.dart';
import 'package:savyor/constant/Images/svgs.dart';
import 'package:savyor/constant/constants.dart';
import 'package:savyor/constant/style.dart';
import 'package:savyor/ui/base/base_widget.dart';
import 'package:savyor/ui/browser/model/browser_model.dart';
import 'package:savyor/ui/browser/store_search_delegate.dart';
import 'package:savyor/ui/home/home_view_model.dart';
import 'package:savyor/ui/my_list/component/mylist_item.dart';
import 'package:savyor/ui/my_list/component/search_delegate.dart';
import 'package:savyor/ui/widget/section_horizontal_widget.dart';
import 'package:savyor/ui/widget/section_vertical_widget.dart';

import '../../common/logger/log.dart';
import '../../data/models/supported_store.dart';
import '../../di/di.dart';

class BrowserMainPage extends BaseStateFullWidget {
  BrowserMainPage({Key? key}) : super(key: key);

  @override
  BrowserMainPageState createState() => BrowserMainPageState();
}

class BrowserMainPageState extends State<BrowserMainPage> {
  bool isDec = true;
  bool readOnly = true;
  List<Store> list = [];
  TextEditingController textEditingController = TextEditingController();
  late final IExternalValues iExternalValues;

  @override
  void initState() {
    iExternalValues = inject<IExternalValues>();
    Future.microtask(() {
      list = context.read<HomeViewModel>().stores;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeViewModel>();

    return Scaffold(
      backgroundColor: Style.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: Style.scaffoldBackground,
        elevation: 0,
        title: CupertinoTextField(
          onTap: readOnly
              ? () async {
                  List<Store> result = await showSearch(context: context, delegate: StoreSearchDelegate(list: list));
                  setState(() {
                    list = result;
                    if (list.isNotEmpty) {
                      readOnly = false;
                      textEditingController.text = list[0].name ?? '';
                      FocusManager.instance.primaryFocus?.unfocus();
                    }
                  });
                }
              : null,
          readOnly: readOnly,
          placeholder: 'I\'m looking for...',
          padding: const EdgeInsets.all(10),
          textInputAction: TextInputAction.search,
          placeholderStyle:
              context.textTheme.subtitle2?.copyWith(fontFamily: 'DM Sans', fontSize: 15, color: Style.unSelectedColor),
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
              List<Store> result = await showSearch(
                  query: textEditingController.text, context: context, delegate: StoreSearchDelegate(list: list));
              setState(() {
                list = result;
                if (list.isNotEmpty) {
                  readOnly = false;
                  textEditingController.text = list[0].name ?? '';
                  FocusManager.instance.primaryFocus?.unfocus();
                }
              });
            }
          },
          onSubmitted: (input) async{
            FocusManager.instance.primaryFocus?.unfocus();
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
                list = viewModel.stores;
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
                Text('Feature stores',
                    style: context.textTheme.headline6?.copyWith(color: Style.textColor, fontWeight: FontWeight.bold)),
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
            child: list.isEmpty
                ? Center(
                    child: Text(
                    "No Store available",
                    style: context.textTheme.subtitle1?.copyWith(color: Style.textColor.withOpacity(0.75)),
                  ))
                : SingleChildScrollView(
                    child: StaggeredGrid.count(
                      crossAxisCount: 4,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      children: list.map((e) {
                        return StaggeredGridTile.count(
                            crossAxisCellCount: 2,
                            mainAxisCellCount: 2,
                            child: SectionVerticalWidget(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              firstWidget: SizedBox(
                                  height: 130,
                                  child: Image.network(
                                    "${iExternalValues.getBaseUrl()}${e.logo}",
                                  )),
                              secondWidget: Row(
                                children: [
                                  Text(widget.utils.compactText(e.name),
                                      style: context.textTheme.subtitle1
                                          ?.copyWith(color: Style.textColor, fontWeight: FontWeight.w500)),
                                ],
                              ),
                            ).onTap(() async {
                              await viewModel.getInstruction(Uri.tryParse(e.url!)!.host);
                              widget.navigator.pushNamed(RoutePath.webView, object: e.url);
                            }));
                      }).toList(),
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

// import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
// import 'package:flutter/material.dart';
// class ModelX{
//   String name ;
//
//   int id ;
//
//   ModelX(this.name, this.id, this.color);
//
//   Color color ;
// }
// class HorizontalExample extends StatefulWidget {
//   const HorizontalExample({Key? key}) : super(key: key);
//
//   @override
//   State createState() => _HorizontalExample();
// }
//
// class InnerList {
//   final String name;
//   List<ModelX> children;
//   InnerList({required this.name, required this.children});
// }
//
// class _HorizontalExample extends State<HorizontalExample> {
//   late List<InnerList> _lists;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _lists = List.generate(3, (outerIndex) {
//       return InnerList(
//         name: outerIndex.toString(),
//         children: List.generate(12, (innerIndex) => ModelX(innerIndex.isEven ? "EVEN" :"ODD",innerIndex,Colors.amber)),
//       );
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Horizontal'),
//       ),
//       body: DragAndDropLists(
//         children: List.generate(_lists.length, (index) => _buildList(index)),
//         onItemReorder: _onItemReorder,
//         onListReorder: _onListReorder,
//         axis: Axis.horizontal,
//         listWidth: 150,
//         listDraggingWidth: 150,
//         listDecoration: BoxDecoration(
//           color: Colors.grey[200],
//           borderRadius: const BorderRadius.all(Radius.circular(7.0)),
//           boxShadow: const <BoxShadow>[
//             BoxShadow(
//               color: Colors.black45,
//               spreadRadius: 3.0,
//               blurRadius: 6.0,
//               offset: Offset(2, 3),
//             ),
//           ],
//         ),
//         listPadding: const EdgeInsets.all(8.0),
//       ),
//     );
//   }
//
//   _buildList(int outerIndex) {
//     var innerList = _lists[outerIndex];
//     return DragAndDropList(
//       header: Row(
//         children: <Widget>[
//           Expanded(
//             child: Container(
//               decoration: const BoxDecoration(
//                 borderRadius: BorderRadius.vertical(top: Radius.circular(7.0)),
//                 color: Colors.pink,
//               ),
//               padding: const EdgeInsets.all(10),
//               child: Text(
//                 'Header ${innerList.name}',
//                 style: Theme.of(context).primaryTextTheme.headline6,
//               ),
//             ),
//           ),
//         ],
//       ),
//       footer: Row(
//         children: <Widget>[
//           Expanded(
//             child: Container(
//               decoration: const BoxDecoration(
//                 borderRadius:
//                 BorderRadius.vertical(bottom: Radius.circular(7.0)),
//                 color: Colors.pink,
//               ),
//               padding: const EdgeInsets.all(10),
//               child: Text(
//                 'Footer ${innerList.name}',
//                 style: Theme.of(context).primaryTextTheme.headline6,
//               ),
//             ),
//           ),
//         ],
//       ),
//       leftSide: const VerticalDivider(
//         color: Colors.pink,
//         width: 1.5,
//         thickness: 1.5,
//       ),
//       rightSide: const VerticalDivider(
//         color: Colors.pink,
//         width: 1.5,
//         thickness: 1.5,
//       ),
//       children: List.generate(innerList.children.length,
//               (index) => _buildItem(innerList.children[index])),
//     );
//   }
//
//   _buildItem(ModelX item) {
//     return DragAndDropItem(
//       child: ListTile(
//         title: Text(item.id.toString()),
//       ),
//     );
//   }
//
//   _onItemReorder(
//       int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {
//     setState(() {
//       var movedItem = _lists[oldListIndex].children.removeAt(oldItemIndex);
//       _lists[newListIndex].children.insert(newItemIndex, movedItem);
//     });
//   }
//
//   _onListReorder(int oldListIndex, int newListIndex) {
//     setState(() {
//       // var movedList = _lists.removeAt(oldListIndex);
//       // _lists.insert(newListIndex, movedList);
//     });
//   }
// }
