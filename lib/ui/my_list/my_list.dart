import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:savyor/application/core/extensions/extensions.dart';
import 'package:savyor/constant/Images/svgs.dart';
import 'package:savyor/constant/constants.dart';
import 'package:savyor/constant/style.dart';
import 'package:savyor/data/models/active_product.dart';
import 'package:savyor/ui/base/base_widget.dart';
import 'package:savyor/ui/my_list/component/mylist_item.dart';
import 'package:savyor/ui/my_list/component/search_delegate.dart';
import 'package:savyor/ui/my_list/my_list_view_model.dart';
import 'package:savyor/ui/widget/section_horizontal_widget.dart';

import '../../application/core/failure/failure.dart';
import '../../application/core/result.dart';
import '../../application/network/error_handler/error_handler.dart';
import '../../common/logger/log.dart';
import '../widget/flutter_toast.dart';
import '../widget/loading_overlay.dart';

class MyList extends BaseStateFullWidget {
  MyList({Key? key}) : super(key: key);

  @override
  MyListState createState() => MyListState();
}

class MyListState extends State<MyList> implements Result<ActiveProduct> {
  // final _list = List.generate(10, (index) => 'Retailer $index').toList();
  bool readOnly = true;

  // List<Product> list = [];

  TextEditingController textEditingController = TextEditingController();
  // late final Timer timer;
  bool inActiveProducts = false;

  @override
  void initState() {
    // timer = Timer.periodic(const Duration(seconds: 30), (Timer t) async {
    //
    // });

    Future.microtask(() async {
      await context.read<MyListViewModel>().getActiveProducts(result: this);
    });

    super.initState();
  }

  @override
  void dispose() {
    // timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MyListViewModel>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Style.scaffoldBackground,
          elevation: 1,
          title: CupertinoTextField(
            onTap: readOnly
                ? () async {
                    List<Product> result = await showSearch(
                        context: context, delegate: ProductSearchDelegate(list: viewModel.currentProducts));

                    viewModel.currentProducts = result;
                    if (viewModel.currentProducts.isNotEmpty) {
                      readOnly = false;
                      textEditingController.text = viewModel.currentProducts[0].productName ?? '';
                      FocusManager.instance.primaryFocus?.unfocus();
                    }
                  }
                : null,
            readOnly: readOnly,
            placeholder: 'I\'m looking for...',
            padding: const EdgeInsets.all(10),
            textInputAction: TextInputAction.search,
            placeholderStyle: context.textTheme.subtitle2
                ?.copyWith(fontFamily: 'DM Sans', fontSize: 15, color: Style.unSelectedColor),
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
                List<Product> result = await showSearch(
                    query: textEditingController.text,
                    context: context,
                    delegate: ProductSearchDelegate(list: viewModel.currentProducts));
                viewModel.currentProducts = result;
                if (viewModel.currentProducts.isNotEmpty) {
                  readOnly = false;
                  textEditingController.text = viewModel.currentProducts[0].productName ?? '';
                  FocusManager.instance.primaryFocus?.unfocus();
                }
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
                  viewModel.currentProducts = viewModel.products;
                });
              }),
            ),
            suffixMode: OverlayVisibilityMode.editing,
            decoration: BoxDecoration(color: const Color(0xffF8F8F9), borderRadius: BorderRadius.circular(8)),
          ),
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(80),
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(inActiveProducts ? 'InActive Products' : 'Active Products',
                              style: context.textTheme.subtitle2
                                  ?.copyWith(fontFamily: 'DM Sans', color: Style.unSelectedColor, fontSize: 15)),
                          const Spacer(),
                          Row(
                            children: [
                              Text('Hide',
                                  style: context.textTheme.subtitle2
                                      ?.copyWith(fontFamily: 'DM Sans', color: Style.unSelectedColor, fontSize: 15)),
                              widget.dimens.k5.horizontalBoxPadding(),
                              CupertinoSwitch(
                                value: inActiveProducts,
                                onChanged: (value) async {
                                  inActiveProducts = value;
                                  setState(
                                    () {},
                                  );
                                  if (inActiveProducts) {
                                    await viewModel.getInActiveProducts(result: this);
                                  } else {
                                    await viewModel.getActiveProducts(result: this);
                                  }
                                },
                                activeColor: Style.primaryColor,
                              ),
                              widget.dimens.k5.horizontalBoxPadding(),
                              Text('Show',
                                  style: context.textTheme.subtitle2
                                      ?.copyWith(fontFamily: 'DM Sans', color: Style.unSelectedColor, fontSize: 15))
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Sort by:',
                            style: context.textTheme.subtitle2
                                ?.copyWith(fontFamily: 'DM Sans', color: Style.unSelectedColor, fontSize: 15),
                          ),
                          widget.dimens.k12.horizontalBoxPadding(),
                          TabBar(
                            indicator: const UnderlineTabIndicator(
                                borderSide: BorderSide(width: 1, color: Style.primaryColor),
                                insets: EdgeInsets.only(bottom: 10, left: 0, right: 12)),
                            isScrollable: true,
                            onTap: (page) {
                              switch (page) {
                                case 0:
                                  {
                                    viewModel.selectedFilter = Filter.retailer;
                                  }
                                  break;
                                case 1:
                                  {
                                    viewModel.selectedFilter = Filter.price;
                                  }
                                  break;
                                case 2:
                                  {
                                    viewModel.selectedFilter = Filter.period;
                                  }
                                  break;
                              }
                            },
                            labelPadding: const EdgeInsets.only(right: 12, top: 4),
                            unselectedLabelColor: Style.unSelectedColor,
                            labelColor: Style.primaryColor,
                            labelStyle: context.textTheme.subtitle2?.copyWith(fontFamily: 'DM Sans', fontSize: 15),
                            unselectedLabelStyle:
                                context.textTheme.subtitle2?.copyWith(fontFamily: 'DM Sans', fontSize: 15),
                            tabs: ['Retailer', 'Price', 'Day'].map((label) => Tab(text: label)).toList(),
                          ),
                          widget.dimens.k2.horizontalBoxPadding(),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: SectionHorizontalWidget(
                              firstWidget: Assets.arrowDown(viewModel.isDec ? Style.primaryColor : null).onTap(() {
                                viewModel.isDec = true;
                              }),
                              secondWidget: Assets.arrowUp(viewModel.isDec ? null : Style.primaryColor).onTap(() {
                                viewModel.isDec = false;
                              }),
                            ),
                          )
                        ],
                      ),
                    ],
                  )))),
      body: LoadingOverLay(
        loadingState: viewModel.state,
        child: viewModel.currentProducts.isEmpty
            ? Center(child: Text(inActiveProducts ? "No InActive products" : "No Active products"))
            : Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                child: RefreshIndicator(
                  onRefresh: () async {
                    inActiveProducts
                        ? await viewModel.getInActiveProducts(result: this)
                        : await viewModel.getActiveProducts(result: this);
                  },
                  child: ListView.builder(
                      itemCount: viewModel.currentProducts.length,
                      itemBuilder: (_, index) {
                        final product = viewModel.currentProducts[index];
                        product.viewModel = viewModel;
                        return MyListItem(
                          product: product,
                          voidCallback: () async {
                            inActiveProducts
                                ? await viewModel.getInActiveProducts(result: this)
                                : await viewModel.getActiveProducts(result: this);
                          },
                        );
                      }),
                ),
              ),
      ),
    );
  }

  @override
  onError(Failure error) {
    SectionToast.show(ErrorMessage.fromError(error).message);
  }

  @override
  onSuccess(ActiveProduct result) {
    return;
  }
}
