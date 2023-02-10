import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:savyor/application/core/extensions/extensions.dart';
import 'package:savyor/application/main_config/routes/route_path.dart';
import 'package:savyor/application/network/external_values/iExternalValue.dart';
import 'package:savyor/constant/Images/svgs.dart';
import 'package:savyor/constant/constants.dart';
import 'package:savyor/constant/style.dart';
import 'package:savyor/data/models/active_product.dart';
import 'package:savyor/ui/base/base_widget.dart';
import 'package:savyor/ui/widget/section_horizontal_widget.dart';
import 'package:savyor/ui/widget/section_vertical_widget.dart';

import '../../../di/di.dart';

class MyListItem extends BaseStateLessWidget {
  MyListItem({Key? key, required this.product}) : super(key: key);
  final Product product;
  @override
  Widget build(BuildContext context) {
    final retailer = Uri.tryParse(product.productURL)?.host.replaceAll(".com", '').replaceAll("www.", "") ;
    return SizedBox(
      height: 175,
      width: context.width,
      child: SectionVerticalWidget(
        gap: 0,
        firstWidget: SectionHorizontalWidget(
          firstWidget: SizedBox.square(
              dimension: 150,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(
                  product.pictureURL,
                ),
              )).onTap(() { navigator.pushNamed(RoutePath.webView, object: product.productURL);}),
          secondWidget: Expanded(
            child: SizedBox(
              height: 150,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${retailer?.capitalize()}',
                        style: context.textTheme.subtitle2?.copyWith(fontWeight: FontWeight.w600, color: Style.textColor),
                      ),
                      IconButton(onPressed: (){
                        navigator.pushNamed(RoutePath.detail, object: product);
                      }, icon:   Assets.edit)


                    ],
                  ),
                  Text(
                    '\$${product.currentPrice}',
                    style: context.textTheme.subtitle2?.copyWith(fontWeight: FontWeight.w600, color: Style.textColor),
                  ),
                  AutoSizeText(

                    utils.compactText(product.productName),
                    style: context.textTheme.subtitle1?.copyWith(fontWeight: FontWeight.normal, color: Style.textColor),
                    maxLines: 2,
                    maxFontSize: 12,
                    minFontSize: 12,
                    overflow: TextOverflow.ellipsis,
                  ),


                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     if(product.rootCate!=null)
                  //       AutoSizeText(
                  //         '${product.rootCate}',
                  //         maxLines: 1,
                  //         overflow: TextOverflow.ellipsis,
                  //         style: context.textTheme.subtitle2?.copyWith(fontWeight: FontWeight.normal, color: Style.textHintColor),
                  //         maxFontSize: 12,
                  //         minFontSize: 8,
                  //       ),
                  //
                  //     if(product.subCate!=null)AutoSizeText(
                  //       '${product.subCate}',
                  //       maxLines: 1,
                  //       overflow: TextOverflow.ellipsis,
                  //       style: context.textTheme.subtitle2?.copyWith(fontWeight: FontWeight.normal, color: Style.textHintColor),
                  //       maxFontSize: 12,
                  //       minFontSize: 8,
                  //     ),
                  //
                  //
                  //   ],
                  // )


                  Text.rich(
                    TextSpan(text: 'Target ', children: [
                      TextSpan(
                        text: '\$${product.targetPrice} ',
                        style: context.textTheme.subtitle2?.copyWith(fontWeight: FontWeight.w600, color: Style.textColor),
                      ),
                      const TextSpan(
                        text: 'in ',
                      ),
                      TextSpan(
                        text: '${product.getRemainingDays()} ',
                        style: context.textTheme.subtitle2?.copyWith(fontWeight: FontWeight.w600, color: Style.textColor),
                      ),
                      const TextSpan(
                        text: 'days',
                      ),
                    ]),
                    style: context.textTheme.subtitle2?.copyWith(fontWeight: FontWeight.normal, color: Style.textColor),
                  )
                ],
              ),
            ),
          ),
        ),
        secondWidget: const Divider(),
      ),
    ).onTap(() {

      navigator.pushNamed(RoutePath.webView, object: product.productURL);
      // navigator.pushNamed(RoutePath.detail, object: product);
    });
  }
}
