import 'dart:ui';

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

class SignupScreen extends BaseStateFullWidget {
  SignupScreen({Key? key}) : super(key: key);

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<SignupScreen> {
  bool obscureText = true;
  bool obscureText2 = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          UiBackground(),
          Padding(
            padding: EdgeInsets.only(left: widget.dimens.k25, right: widget.dimens.k25, top: widget.dimens.k70),
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
                  widget.dimens.k20.verticalBoxPadding(),
                  SizedBox.square(
                    dimension: context.getWidth(0.25),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Assets.defaultProfile,
                        ),
                        Assets.progress,
                        Positioned(bottom: 10, right: 0, child: SizedBox.square(   dimension: context.getWidth(0.05),child: Assets.editProfile))
                      ],
                    ),
                  ),
                  SectionTextField(
                    hintText: 'Email Address',
                    prefixIcon: Assets.email,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    prefixIconConstraints: const BoxConstraints(maxWidth: 30),
                  ),
                  widget.dimens.k10.verticalBoxPadding(),
                  SectionTextField(
                    hintText: 'Password',
                    prefixIcon: Assets.lock,
                    suffixIcon: Assets.eye(!obscureText ? Style.primaryColor : null).onTap(() {
                      setState(() {
                        obscureText = !obscureText;
                      });
                    }),
                    obscureText: obscureText,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    prefixIconConstraints: const BoxConstraints(maxWidth: 32),
                    suffixIconConstraints: const BoxConstraints(maxWidth: 25),
                  ),
                  widget.dimens.k10.verticalBoxPadding(),
                  SectionVerticalWidget(
                    gap: 15,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    firstWidget: SectionTextField(
                      hintText: 'Confirm Password',
                      prefixIcon: Assets.lock,
                      suffixIcon: Assets.eye(!obscureText2 ? Style.primaryColor : null).onTap(() {
                        setState(() {
                          obscureText2 = !obscureText2;
                        });
                      }),
                      obscureText: obscureText2,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      prefixIconConstraints: const BoxConstraints(maxWidth: 32),
                      suffixIconConstraints: const BoxConstraints(maxWidth: 25),
                    ),
                    secondWidget: Text.rich(TextSpan(
                        text: 'By signing up you agree to our ',
                        style: context.textTheme.subtitle2?.copyWith(
                          color: Style.textColor,
                          fontWeight: FontWeight.normal,
                        ),
                        children: [
                          TextSpan(
                              text: 'Privacy policy',
                              style: context.textTheme.subtitle2?.copyWith(
                                color: Style.primaryColor,
                                fontWeight: FontWeight.w500,
                               decoration: TextDecoration.underline
                              ),)
                        ])),
                  ),
                  widget.dimens.k20.verticalBoxPadding(),
                  SectionVerticalWidget(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    gap: 0,
                    firstWidget: BigBtn(
                      onTap: () {
                        widget.navigator.pushNamedAndRemoveUntil(RoutePath.welcome);
                      },
                      color: Style.primaryColor,
                      child: Text(
                        'Sign up',
                        style: context.textTheme.subtitle1?.copyWith(
                            fontFamily: 'Raleway', color: Style.scaffoldBackground, fontWeight: FontWeight.w600, fontSize: widget.dimens.k16),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    secondWidget: TextButton(
                      onPressed: (){
                        widget.navigator.pushNamedAndRemoveUntil(RoutePath.login);
                      },
                      child: Text(
                        'Log in',
                        style: context.textTheme.subtitle1?.copyWith(color: Style.primaryColor, fontWeight: FontWeight.w700),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
               /*   SizedBox(
                    height: 50,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Container(
                          height: 50,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment(-1.029, 0.0),
                              end: Alignment(1.164, 0.0),
                              colors: [
                                Color(0x274e8f38),
                                Color(0xb5e3dcc9),
                                Color(0x26ff8252)
                              ],
                              stops: [0.0, 0.435, 1.0],
                            ),
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(12.0),
                              bottomLeft: Radius.circular(12.0),
                            ),
                          ),
                        ),
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(12.0),
                            bottomLeft: Radius.circular(12.0),
                          ),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
                            child: Container(
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment(0.0, -1.0),
                                  end: Alignment(0.0, 1.0),
                                  colors: [Color(0x004e8f38), Color(0x0027481c)],
                                  stops: [0.0, 1.0],
                                ),
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(12.0),
                                  bottomLeft: Radius.circular(12.0),
                                ),
                              ),
                              child:  ColoredBox(
                                  color: Colors.white.withOpacity(0.3)
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),
                  )*/
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
