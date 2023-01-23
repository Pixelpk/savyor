import 'package:flutter/material.dart';
import 'package:savyor/application/core/extensions/extensions.dart';
import 'package:savyor/application/main_config/routes/route_path.dart';
import 'package:savyor/constant/Images/svgs.dart';
import 'package:savyor/constant/constants.dart';
import 'package:savyor/constant/style.dart';
import 'package:savyor/ui/base/base_widget.dart';
import 'package:savyor/ui/widget/big_btn.dart';
import 'package:savyor/ui/widget/nil.dart';
import 'package:savyor/ui/widget/section_horizontal_widget.dart';
import 'package:savyor/ui/widget/section_vertical_widget.dart';

class AccountScreen extends BaseStateFullWidget {
  AccountScreen({Key? key}) : super(key: key);

  @override
  AccountScreenState createState() => AccountScreenState();
}

class AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.scaffoldBackground,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
        child: Column(
          children: [
            widget.dimens.k100.verticalBoxPadding(),
            Center(
                child: SizedBox.square(
              dimension: 150,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Assets.defaultProfile,
                  ),
                  Assets.progress,
                  Positioned(bottom: 0, right: 0, child: Assets.editProfile)
                ],
              ),
            )),
            widget.dimens.k25.verticalBoxPadding(),
            Text('Account name', style: context.textTheme.headline6?.copyWith(fontWeight: FontWeight.w600, color: Style.textColor)),
            widget.dimens.k50.verticalBoxPadding(),
            Container(
              decoration: BoxDecoration(color: Style.cardBg, borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                title: Text('Application', style: context.textTheme.subtitle1?.copyWith(fontWeight: FontWeight.w500, color: Style.accentColor)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widget.dimens.k8.verticalBoxPadding(),
                    SectionHorizontalWidget(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      firstWidget: Text('Change password',
                          style: context.textTheme.subtitle1?.copyWith(fontWeight: FontWeight.bold, color: Style.textHintColor)),
                      secondWidget: Assets.frwd,
                    ),
                  ],
                ),
              ),
            ),
            widget.dimens.k25.verticalBoxPadding(),
            Container(
              decoration: BoxDecoration(color: Style.cardBg, borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                title: Text('Support', style: context.textTheme.subtitle1?.copyWith(fontWeight: FontWeight.w500, color: Style.accentColor)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widget.dimens.k16.verticalBoxPadding(),
                    SectionHorizontalWidget(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      firstWidget: Text('About Savyor',
                          style: context.textTheme.subtitle1?.copyWith(fontWeight: FontWeight.bold, color: Style.textHintColor)),
                      secondWidget: Assets.frwd,
                    ),
                    const Divider(
                      thickness: 2,
                      color: Style.divider,
                      height: 40,
                    ),
                    SectionHorizontalWidget(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      firstWidget: Text('Privacy policy',
                          style: context.textTheme.subtitle1?.copyWith(fontWeight: FontWeight.bold, color: Style.textHintColor)),
                      secondWidget: Assets.frwd,
                    ),
                  ],
                ),
              ),
            ),
            widget.dimens.k20.verticalBoxPadding(),
            SectionVerticalWidget(
              crossAxisAlignment: CrossAxisAlignment.center,
              gap: 15,
              firstWidget: BigBtn(
                onTap: () {
                  widget.navigator.pushNamedAndRemoveUntil(RoutePath.login);
                },
                color: Style.primaryColor,
                child: SectionHorizontalWidget(firstWidget: Text(
                  'Log out',
                  style: context.textTheme.subtitle1?.copyWith(
                      fontFamily: 'Montserrat Alternates', color: Style.scaffoldBackground, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),secondWidget: Assets.exit,),
              ),
              secondWidget: Text(
                '1.1 version',
                style: context.textTheme.subtitle1?.copyWith(color: Style.textColor.withOpacity(0.75)),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
