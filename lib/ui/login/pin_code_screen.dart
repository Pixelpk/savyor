import 'dart:async';

import 'package:flutter/gestures.dart';
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

class PinCodeScreen extends BaseStateFullWidget {
  final String email;
  PinCodeScreen({Key? key, required this.email}) : super(key: key);

  @override
  PinCodeScreenState createState() => PinCodeScreenState();
}

class PinCodeScreenState extends State<PinCodeScreen> {
  TextEditingController textEditingController = TextEditingController();
  late StreamController<ErrorAnimationType> errorController;
  String currentText = "";
  int secondsRemaining = 60;
  bool enableResend = false;
  late Timer timer;
  bool isWrongCode = false;
  bool isFill = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (secondsRemaining != 0) {
        setState(() {
          secondsRemaining--;
        });
      } else {
        setState(() {
          enableResend = true;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    errorController.close();
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: formKey,
        child: Stack(
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
                      gap: 40,
                      firstWidget: SectionVerticalWidget(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          firstWidget: Text(
                            'Code',
                            style: context.textTheme.headline6?.copyWith(color: Style.textColor, fontWeight: FontWeight.w500),
                          ),
                          secondWidget: Text(
                            'We sent an  Email address with the login code to ${widget.email}',
                            style: context.textTheme.subtitle2?.copyWith(color: Style.textColor, fontWeight: FontWeight.normal),
                          )),
                      secondWidget: PinCodeTextField(
                        appContext: context,
                        validator: (input) {
                          return input != '1234' ? "" : null;
                        },
                        length: 4,
                        obscureText: false,
                        animationType: AnimationType.fade,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        cursorColor: Colors.transparent,
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.underline,
                          borderRadius: BorderRadius.circular(5),
                          activeFillColor: Colors.transparent,
                          selectedFillColor: Colors.transparent,
                          inactiveFillColor: Colors.transparent,
                          activeColor: isFill ? Colors.transparent : Style.textColor,
                          inactiveColor: isFill ? Colors.transparent : Style.textColor,
                          selectedColor: isFill ? Colors.transparent : Style.textColor,
                          errorBorderColor: Colors.transparent,
                          fieldHeight: 50,
                          fieldWidth: 30,
                        ),
                        animationDuration: const Duration(milliseconds: 300),
                        backgroundColor: Colors.transparent,
                        enableActiveFill: true,
                        errorAnimationController: errorController,
                        controller: textEditingController,
                        onChanged: (value) {
                          setState(() {
                            currentText = value;
                            isFill = currentText.length >= 4;
                          });
                        },
                      ),
                    ),
                    widget.dimens.k40.verticalBoxPadding(),
                    SectionVerticalWidget(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      gap: 0,
                      firstWidget: TextButton(
                        onPressed: null,
                        child: Text(
                          'Get the code again in 00:${secondsRemaining.toString().padLeft(2, '0')}',
                          style: context.textTheme.subtitle2?.copyWith(color: Style.textHintColor, fontWeight: FontWeight.normal),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      secondWidget: BigBtn(
                        onTap: () {
                          if (formKey.currentState!.validate()) {}
                        },
                        color: Style.primaryColor,
                        child: Text(
                          'Confirm',
                          style: context.textTheme.subtitle1
                              ?.copyWith(color: Style.scaffoldBackground, fontWeight: FontWeight.w600, fontSize: widget.dimens.k16),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      thirdWidget: TextButton(
                        onPressed: () {
                          if (enableResend) {
                            _resendCode();
                          } else {
                            widget.navigator.pop();
                          }
                        },
                        child: enableResend
                            ? Text(
                                'Retrieve Code',
                                style: context.textTheme.subtitle1
                                    ?.copyWith(fontFamily: 'Montserrat Alternates', color: Style.primaryColor, fontWeight: FontWeight.w600),
                                textAlign: TextAlign.center,
                              )
                            : Text(
                                'Another email',
                                style: context.textTheme.subtitle1
                                    ?.copyWith(fontFamily: 'Montserrat Alternates', color: Style.primaryColor, fontWeight: FontWeight.w600),
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
      ),
    ));
  }

  Future<void> _resendCode() async {
    setState(() {
      secondsRemaining = 30;
      enableResend = false;
    });
  }
}
