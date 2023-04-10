import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:savyor/application/core/extensions/extensions.dart';
import 'package:savyor/constant/Images/svgs.dart';
import 'package:savyor/constant/constants.dart';
import 'package:savyor/constant/style.dart';
import 'package:savyor/data/models/track_product.dart';
import 'package:savyor/ui/base/base_state.dart';
import 'package:savyor/ui/base/base_widget.dart';
import 'package:savyor/ui/my_list/my_list_view_model.dart';
import 'package:savyor/ui/widget/section_horizontal_widget.dart';
import 'package:savyor/ui/widget/section_vertical_widget.dart';
import 'package:savyor/ui/widget/big_btn.dart';

import '../../application/core/failure/failure.dart';
import '../../application/core/result.dart';
import '../../application/network/error_handler/error_handler.dart';
import '../../data/models/active_product.dart';
import '../../domain/entities/update_product_entity/track_product_entity.dart';
import '../widget/flutter_toast.dart';
import '../widget/loading_overlay.dart';
import '../widget/rounded_text_field.dart';

class MyListDetail extends BaseStateFullWidget {
  MyListDetail({Key? key, required this.product}) : super(key: key);
  final Product product;

  @override
  State<MyListDetail> createState() => _MyListDetailState();
}

class _MyListDetailState extends State<MyListDetail> implements Result<ServerResponse> {
  final oCcy = NumberFormat("#,##0.00", "en_US");

  double price = 0;

  int period = 1;

  late TextEditingController trackPriceController;

  @override
  void initState() {
    price = double.tryParse(widget.product.targetPrice.toString()) ?? 0;
    trackPriceController = TextEditingController(text: "\$${widget.product.targetPrice}");
    period = int.tryParse(widget.product.targetPeriod.toString()) ?? 0;
    widget.product.viewModel?.updateProductState = BaseLoadingState.none;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final retailer = Uri.tryParse(widget.product.productURL)?.host.replaceAll(".com", '').replaceAll("www.", "");

    return ChangeNotifierProvider.value(
      value: widget.product.viewModel,
      child: Consumer<MyListViewModel>(builder: (ctx, viewModel, c) {
        return Scaffold(
          backgroundColor: Style.scaffoldBackground,
          appBar: AppBar(
            //  toolbarHeight: 100,
            elevation: 0,
            leading: IconButton(
                onPressed: () {
                  widget.navigator.pop();
                },
                icon: const Icon(Icons.arrow_back, color: Style.textColor)),
            backgroundColor: Colors.white,
            automaticallyImplyLeading: true,
            title: Text(widget.utils.compactText(widget.product.productName)),
            flexibleSpace: Material(
              elevation: 1,
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
              child: SizedBox(
                height: 150,
                width: context.width,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: LoadingOverLay(
              loadingState: viewModel.updateProductState,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SectionVerticalWidget(
                  gap: 50,
                  firstWidget: SectionHorizontalWidget(
                    firstWidget: SizedBox.square(
                        dimension: 150,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.network(widget.product.pictureURL),
                        )),
                    secondWidget: Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${retailer?.capitalize()}',
                              style: context.textTheme.subtitle2
                                  ?.copyWith(fontWeight: FontWeight.w600, color: Style.textColor)),
                          Text("\$${widget.utils.compactText(widget.product.currentPrice)}",
                              style: context.textTheme.subtitle1
                                  ?.copyWith(fontWeight: FontWeight.w600, color: Style.textColor)),
                          AutoSizeText(widget.utils.compactText(widget.product.productName),
                              style: context.textTheme.headline6?.copyWith(color: Style.textColor),
                              maxFontSize: 12,
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                              minFontSize: 12),
                          widget.dimens.k8.verticalBoxPadding(),

                          // widget.dimens.k8.verticalBoxPadding(),
                          // if(widget.product.rootCate!=null)
                          //   AutoSizeText(
                          //     '${widget.product.rootCate}',
                          //     maxLines: 1,
                          //     overflow: TextOverflow.ellipsis,
                          //     style: context.textTheme.subtitle2?.copyWith(fontWeight: FontWeight.normal, color: Style.textHintColor),
                          //     maxFontSize: 12,
                          //     minFontSize: 8,
                          //   ),
                          //
                          // if(widget.product.subCate!=null)AutoSizeText(
                          //   '${widget.product.subCate}',
                          //   maxLines: 1,
                          //   overflow: TextOverflow.ellipsis,
                          //   style: context.textTheme.subtitle2?.copyWith(fontWeight: FontWeight.normal, color: Style.textHintColor),
                          //   maxFontSize: 12,
                          //   minFontSize: 8,
                          // ),
                          // widget.dimens.k8.verticalBoxPadding(),
                          SectionVerticalWidget(
                            firstWidget: Text('Track price',
                                style: context.textTheme.subtitle1
                                    ?.copyWith(fontWeight: FontWeight.normal, color: Style.textColor.withOpacity(0.5))),
                            secondWidget: SectionHorizontalWidget(
                              firstWidget: Assets.minus(isZero: price <= 0).onTap(() {
                                setState(() {
                                  if (double.parse(trackPriceController.text.replaceAll('\$', '')) > 0) {
                                    trackPriceController.text =
                                        (double.parse(trackPriceController.text.replaceAll('\$', '')) - 1.0).toString();
                                    trackPriceController.text = "\$${trackPriceController.text}";
                                  }
                                  if (price > 0) {
                                    price -= 1.0;
                                  }
                                });
                              }),
                              secondWidget: Expanded(
                                  child: RoundedTextField(
                                      textFieldHeight: 34,
                                      keyboardType: TextInputType.number,
                                      style: context.textTheme.subtitle2?.copyWith(color: Style.textColor),
                                      controller: trackPriceController,
                                      hintText: 'Track Price')),
                              thirdWidget: Assets.plus().onTap(() {
                                setState(() {
                                  trackPriceController.text =
                                      (double.parse(trackPriceController.text.replaceAll('\$', '')) + 1.0).toString();
                                  trackPriceController.text = "\$${trackPriceController.text}";
                                  price += 1.0;
                                });
                              }),
                            ),
                          ),
                          widget.dimens.k8.verticalBoxPadding(),
                          SectionVerticalWidget(
                            firstWidget: Text(
                              'Track period',
                              style: context.textTheme.subtitle1
                                  ?.copyWith(fontWeight: FontWeight.normal, color: Style.textColor.withOpacity(0.5)),
                            ),
                            secondWidget: SectionHorizontalWidget(
                              firstWidget: Assets.minus(isZero: period <= 0).onTap(() {
                                if (period > 0) {
                                  setState(() {
                                    period -= 1;
                                  });
                                }
                              }),
                              secondWidget: Container(
                                constraints: const BoxConstraints(minWidth: 100),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Style.unSelectedColor,
                                    ),
                                    borderRadius: BorderRadius.circular(999)),
                                child: Padding(
                                  padding: const EdgeInsets.all(6),
                                  child: Text(
                                    widget.utils.compactText(period),
                                    style: context.textTheme.subtitle2?.copyWith(color: Style.textColor),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              thirdWidget: Assets.plus().onTap(() {
                                setState(() {
                                  period += 1;
                                });
                              }),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  secondWidget: SectionVerticalWidget(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    firstWidget: SizedBox(
                      width: context.width,
                      child: IconButton(
                        icon: Text(
                          widget.product.productActive! ? 'Stop Track' : "Start Track",
                          style: context.textTheme.headline6?.copyWith(
                              fontSize: 16,
                              fontFamily: 'Montserrat Alternates',
                              fontWeight: FontWeight.w600,
                              color: Style.primaryColor),
                        ),
                        onPressed: () {
                          final UpdateProductEntity params = UpdateProductEntity(
                              productLink: widget.product.productURL, productActive: widget.product.productActive!);
                          viewModel.updateProduct(this, params);
                        },
                      ),
                    ),
                    secondWidget: BigBtn(
                      onTap: () {
                        final UpdateProductEntity params = UpdateProductEntity(
                          productLink: widget.product.productURL,
                          productId: widget.product.iD,
                          targetPeriod: period.toString(),
                          targetPrice: trackPriceController.text.replaceAll('\$', ''),
                        );
                        viewModel.updateProduct(this, params);
                      },
                      color: Style.primaryColor,
                      child: Text(
                        'Save',
                        style: context.textTheme.subtitle1?.copyWith(
                            fontFamily: 'Montserrat Alternates',
                            color: Style.scaffoldBackground,
                            fontWeight: FontWeight.w600,
                            fontSize: widget.dimens.k16),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  @override
  onError(Failure error) {
    SectionToast.show(ErrorMessage.fromError(error).message);
  }

  @override
  onSuccess(ServerResponse result) {
    if (mounted) {
      // SectionToast.show(result.msg ?? "Success");
      Navigator.pop(context);
    }
    return;
  }
}
