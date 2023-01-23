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

class LoginScreen extends BaseStateFullWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
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
                        style: context.textTheme.subtitle1?.copyWith(color: Style.textColor, fontWeight: FontWeight.w500),
                        text: 'The only smart way to\n',
                        children: const [TextSpan(text: '      '), TextSpan(text: 'shop online and save')])),
                  ),
                  widget.dimens.k30.verticalBoxPadding(),
                  SectionTextField(
                      hintText: 'Email Address',
                      prefixIcon: Assets.email,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      prefixIconConstraints: const BoxConstraints(maxWidth: 30),
                  ),
                  widget.dimens.k10.verticalBoxPadding(),
                  SectionVerticalWidget(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    gap: 0,
                    firstWidget: SectionTextField(
                      hintText: 'Password',
                      prefixIcon: Assets.lock,
                      suffixIcon: Assets.eye(!obscureText?Style.primaryColor:null).onTap(() {setState(() {
                        obscureText = !obscureText;
                      }); }),
                      obscureText: obscureText,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      prefixIconConstraints: const BoxConstraints(maxWidth: 32),
                      suffixIconConstraints: const BoxConstraints(maxWidth: 25),
                    ),
                    secondWidget: TextButton(
                      onPressed: (){
                        widget.navigator.pushNamed(RoutePath.forgotPassword);
                      },
                      child: Text(
                        'Forgot Password?',
                        style: context.textTheme.subtitle2?.copyWith(
                          color: Style.hintColor,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ),
                  widget.dimens.k40.verticalBoxPadding(),
                  SectionVerticalWidget(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    gap: 0,
                    firstWidget: BigBtn(
                      onTap: () {
                        widget.navigator.pushNamedAndRemoveUntil(RoutePath.home);
                      },
                      color: Style.primaryColor,
                      child: Text(
                        'Log in',
                        style: context.textTheme.subtitle1?.copyWith(
                            fontFamily: 'Raleway', color: Style.scaffoldBackground, fontWeight: FontWeight.w600, fontSize: widget.dimens.k16),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    secondWidget: TextButton(
                      onPressed: (){
                        widget.navigator.pushNamedAndRemoveUntil(RoutePath.signup);
                      },
                      child: Text(
                        'Sign up',
                        style: context.textTheme.subtitle1?.copyWith(color: Style.primaryColor, fontWeight: FontWeight.w700),
                        textAlign: TextAlign.center,
                      ),
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
