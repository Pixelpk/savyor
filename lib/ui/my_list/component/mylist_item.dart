import 'package:flutter/material.dart';
import 'package:savyor/application/core/extensions/extensions.dart';
import 'package:savyor/application/main_config/routes/route_path.dart';
import 'package:savyor/constant/Images/svgs.dart';
import 'package:savyor/constant/constants.dart';
import 'package:savyor/constant/style.dart';
import 'package:savyor/ui/base/base_widget.dart';
import 'package:savyor/ui/widget/section_horizontal_widget.dart';
import 'package:savyor/ui/widget/section_vertical_widget.dart';

class MyListItem extends BaseStateFullWidget {
  MyListItem({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  MyListItemState createState() => MyListItemState();
}

class MyListItemState extends State<MyListItem> {
  @override
  Widget build(BuildContext context) {
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
                child: Image.asset(
                  'assets/sample.png',
                ),
              )),
          secondWidget: Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.title,
                      style: context.textTheme.subtitle1?.copyWith(fontWeight: FontWeight.w600, color: Style.textColor),
                    ),
                    Assets.edit
                  ],
                ),
                widget.dimens.k8.verticalBoxPadding(),
                Text(
                  '\$299.00',
                  style: context.textTheme.subtitle2?.copyWith(fontWeight: FontWeight.w600, color: Style.textColor),
                ),
                widget.dimens.k8.verticalBoxPadding(),
                Text(
                  'Description Lorem ipsum dolor sit amet, consectetur',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.subtitle2?.copyWith(fontWeight: FontWeight.normal, color: Style.textHintColor),
                ),
                widget.dimens.k8.verticalBoxPadding(),
                Text.rich(
                  TextSpan(text: 'Target ', children: [
                    TextSpan(
                      text: '\$275.00 ',
                      style: context.textTheme.subtitle2?.copyWith(fontWeight: FontWeight.w600, color: Style.textColor),
                    ),
                    const TextSpan(
                      text: 'in ',
                    ),
                    TextSpan(
                      text: '10 ',
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
        secondWidget: const Divider(),
      ),
    ).onTap(() {
      widget.navigator.pushNamed(RoutePath.detail, object: widget.title);
    });
  }
}
