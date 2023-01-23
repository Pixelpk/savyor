import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
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

class ForgotPasswordScreen extends BaseStateFullWidget {
  ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  ForgotPasswordScreenState createState() => ForgotPasswordScreenState();
}

class ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  bool obscureText = true;
  TextEditingController controller = TextEditingController();
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
                        style: context.textTheme.subtitle1?.copyWith(color: Style.textColor, fontWeight: FontWeight.w500),
                        text: 'The only smart way to\n',
                        children: const [TextSpan(text: '      '), TextSpan(text: 'shop online and save')])),
                  ),
                  widget.dimens.k40.verticalBoxPadding(),
                  SectionVerticalWidget(
                    gap: 15,
                    firstWidget: SectionVerticalWidget(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        firstWidget: Text(
                          'Password recovery',
                          style: context.textTheme.headline6?.copyWith(color: Style.textColor, fontWeight: FontWeight.w500),
                        ),
                        secondWidget: Text(
                          'We will send an Email address with the login code',
                          style: context.textTheme.subtitle2?.copyWith(color: Style.textColor, fontWeight: FontWeight.normal),
                        )),
                    secondWidget: SectionTextField(
                      hintText: 'Email Address',
                      prefixIcon: Assets.email,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      prefixIconConstraints: const BoxConstraints(maxWidth: 30),
                      controller: controller,
                    ),
                  ),
                  widget.dimens.k80.verticalBoxPadding(),
                  BigBtn(
                    onTap: () {
                      widget.navigator.pushNamed(RoutePath.pinCode, object: controller.text);
                    },
                    color: Style.primaryColor,
                    child: Text(
                      'Confirm',
                      style: context.textTheme.subtitle1?.copyWith(
                          fontFamily: 'Raleway', color: Style.scaffoldBackground, fontWeight: FontWeight.w600, fontSize: widget.dimens.k16),
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
