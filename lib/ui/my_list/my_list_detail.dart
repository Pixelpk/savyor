import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:savyor/application/core/extensions/extensions.dart';
import 'package:savyor/constant/Images/svgs.dart';
import 'package:savyor/constant/constants.dart';
import 'package:savyor/constant/style.dart';
import 'package:savyor/ui/base/base_widget.dart';
import 'package:savyor/ui/widget/section_horizontal_widget.dart';
import 'package:savyor/ui/widget/section_vertical_widget.dart';
import 'package:savyor/ui/widget/big_btn.dart';


class MyListDetail extends BaseStateFullWidget {
  MyListDetail({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyListDetail> createState() => _MyListDetailState();
}

class _MyListDetailState extends State<MyListDetail> {
  final oCcy =  NumberFormat("#,##0.00", "en_US");
  double price = 0;
  int period = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.scaffoldBackground,
      appBar: AppBar(
      //  toolbarHeight: 100,
        elevation: 0,
        backgroundColor: Style.scaffoldBackground,
        automaticallyImplyLeading: true,
        title: Text(
          widget.title,
        ),
        flexibleSpace: Material(
          elevation: 1,
          borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
          child: SizedBox(
            height: 150,
            width: context.width,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SectionVerticalWidget(
          gap: 50,
          firstWidget: SectionHorizontalWidget(
            firstWidget: SizedBox.square(
                dimension: 150,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'assets/sample.png',
                  ),
                )),
            secondWidget: Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: context.textTheme.headline6?.copyWith(color: Style.textColor),
                  ),
                  widget.dimens.k8.verticalBoxPadding(),
                  Text(
                    '\$299.00',
                    style: context.textTheme.subtitle1?.copyWith(fontWeight: FontWeight.w600, color: Style.textColor),
                  ),
                  widget.dimens.k8.verticalBoxPadding(),
                  Text(
                    'Description Lorem ipsum dolor sit amet, consectetur adipiscing elit. Tellus sagittis nisi pellentesque urna',
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.subtitle2?.copyWith(fontWeight: FontWeight.normal, color: Style.textHintColor),
                  ),
                  widget.dimens.k8.verticalBoxPadding(),
                  SectionVerticalWidget(
                    firstWidget: Text(
                      'Track price',
                      style: context.textTheme.subtitle1?.copyWith(fontWeight: FontWeight.normal, color: Style.textColor.withOpacity(0.5)),
                    ),
                    secondWidget: SectionHorizontalWidget(
                      firstWidget: Assets.minus( isZero: price<=0).onTap(() {
                        setState(() {
                          if(price > 0){
                            price -= 1.0;
                          }
                        });
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
                            '\$${oCcy.format(price)}',
                            style: context.textTheme.subtitle2?.copyWith(color: Style.textColor),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      thirdWidget: Assets.plus().onTap(() {
                        setState(() {
                          price +=1.0;
                        });
                      }),
                    ),
                  ),
                  widget.dimens.k8.verticalBoxPadding(),
                  SectionVerticalWidget(
                    firstWidget: Text(
                      'Track period',
                      style: context.textTheme.subtitle1?.copyWith(fontWeight: FontWeight.normal, color: Style.textColor.withOpacity(0.5)),
                    ),
                    secondWidget: SectionHorizontalWidget(
                      firstWidget: Assets.minus( isZero: period<=0).onTap(() {
                        if(period>0){
                          setState(() {
                            period -=1;
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
                            '$period',
                            style: context.textTheme.subtitle2?.copyWith(color: Style.textColor),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      thirdWidget: Assets.plus().onTap(() {
                        setState(() {
                          period +=1;
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
            firstWidget: Text(
              'Stop track',
              style: context.textTheme.headline6?.copyWith(fontSize: 16,fontFamily: 'Montserrat Alternates',fontWeight: FontWeight.w600, color: Style.primaryColor),
            ), secondWidget: BigBtn(
            onTap: () {

            },
            color: Style.primaryColor,
            child: Text(
              'Save',
              style: context.textTheme.subtitle1?.copyWith(
                  fontFamily: 'Montserrat Alternates', color: Style.scaffoldBackground, fontWeight: FontWeight.w600, fontSize: widget.dimens.k16),
              textAlign: TextAlign.center,
            ),
          ),
          ),

        ),
      ),
    );
  }
}
