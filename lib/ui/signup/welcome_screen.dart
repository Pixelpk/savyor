import 'package:flutter/material.dart';
import 'package:savyor/application/core/extensions/extensions.dart';
import 'package:savyor/application/main_config/routes/route_path.dart';
import 'package:savyor/constant/Images/svgs.dart';
import 'package:savyor/constant/constants.dart';
import 'package:savyor/constant/style.dart';
import 'package:savyor/ui/base/base_widget.dart';
import 'package:savyor/ui/widget/big_btn.dart';
import 'package:savyor/ui/widget/section_text_field.dart';
import 'package:savyor/ui/widget/section_vertical_widget.dart';
import 'package:savyor/ui/widget/ui_background.dart';

class WelcomeScreen extends BaseStateFullWidget {
  WelcomeScreen({Key? key}) : super(key: key);

  @override
  WelcomeScreenState createState() => WelcomeScreenState();
}

class WelcomeScreenState extends State<WelcomeScreen> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          UiBackground(),
          Padding(
            padding: EdgeInsets.only(left: widget.dimens.k25, right: widget.dimens.k25, top: widget.dimens.k80),
            child: SizedBox(
              width: context.width,
              height: context.height,
              child: Column(
                children: [
                  SectionVerticalWidget(
                    firstWidget: Assets.logo1_5x,
                    secondWidget: Text.rich(TextSpan(
                        style:
                            context.textTheme.subtitle1?.copyWith(color: Style.textColor, fontWeight: FontWeight.w500),
                        text: 'The only smart way to\n',
                        children: const [TextSpan(text: '      '), TextSpan(text: 'shop online and save')])),
                  ),
                  widget.dimens.k30.verticalBoxPadding(),
                  SectionVerticalWidget(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      firstWidget: Text(
                        'Welcome',
                        textAlign: TextAlign.center,
                        style: context.textTheme.headline2?.copyWith(
                          color: Style.textColor,
                          fontFamily: 'Montserrat Alternates',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      secondWidget: Text(
                        'Have a save trip with',
                        textAlign: TextAlign.center,
                        style: context.textTheme.headline5?.copyWith(
                          color: Style.textColor.withOpacity(0.75),
                          fontFamily: 'Montserrat Alternates',
                          fontWeight: FontWeight.normal,
                        ),
                      )),
                  widget.dimens.k80.verticalBoxPadding(),
                  BigBtn(
                    onTap: () {
                      widget.navigator.pushNamedAndRemoveUntil(RoutePath.home);
                    },
                    color: Style.primaryColor,
                    child: Text(
                      'Get started',
                      style: context.textTheme.subtitle1?.copyWith(
                          fontFamily: 'Raleway',
                          color: Style.scaffoldBackground,
                          fontWeight: FontWeight.w600,
                          fontSize: widget.dimens.k16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
