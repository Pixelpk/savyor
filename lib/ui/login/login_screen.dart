import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:savyor/application/core/extensions/extensions.dart';
import 'package:savyor/application/main_config/routes/route_path.dart';
import 'package:savyor/constant/Images/svgs.dart';
import 'package:savyor/constant/constants.dart';
import 'package:savyor/constant/style.dart';
import 'package:savyor/ui/account/user_view_model.dart';
import 'package:savyor/ui/base/base_widget.dart';
import 'package:savyor/ui/login/login_view_model.dart';
import 'package:savyor/ui/widget/big_btn.dart';
import 'package:savyor/ui/widget/section_text_field.dart';
import 'package:savyor/ui/widget/section_vertical_widget.dart';
import 'package:savyor/ui/widget/ui_background.dart';

import '../../application/core/failure/failure.dart';
import '../../application/core/result.dart';
import '../../application/network/error_handler/error_handler.dart';
import '../../data/models/user.dart';
import '../../domain/entities/login_entity/login_enityt.dart';
import '../splash/splash_screen.dart';
import '../widget/flutter_toast.dart';
import '../widget/loading_overlay.dart';
import 'mixin/login_mixin.dart';

class LoginScreen extends BaseStateFullWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> with LoginMixin implements Result<User> {
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
              child: Consumer<LoginViewModel>(builder: (ctx, viewModel, c) {
                return LoadingOverLay(
                  loadingState: viewModel.state,
                  child: Form(
                    key: validKey,
                    child: Column(
                      children: [
                        SectionVerticalWidget(
                          firstWidget: Assets.logo1_5x,
                          secondWidget: Text.rich(TextSpan(
                              style: context.textTheme.subtitle1
                                  ?.copyWith(color: Style.textColor, fontWeight: FontWeight.w500),
                              text: 'The only smart way to\n',
                              children: const [TextSpan(text: '      '), TextSpan(text: 'shop online and save')])),
                        ),
                        widget.dimens.k30.verticalBoxPadding(),
                        SectionTextField(
                          hintText: 'Email Address',
                          controller: name,
                          prefixIcon: Assets.email,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          validator: (e) {
                            if (e != null && e.trim().isNotEmpty && utils.isEmail(e)) {
                              return null;
                            }
                            return "Invalid Email";
                          },
                          prefixIconConstraints: const BoxConstraints(maxWidth: 30),
                        ),
                        widget.dimens.k10.verticalBoxPadding(),
                        SectionVerticalWidget(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          gap: 0,
                          firstWidget: SectionTextField(
                            hintText: 'Password',
                            prefixIcon: Assets.lock,
                            suffixIcon: Assets.eye(!obscureText ? Style.primaryColor : null).onTap(() {
                              setState(() {
                                obscureText = !obscureText;
                              });
                            }),
                            validator: (e) {
                              if (e != null && e.trim().isNotEmpty) {
                                return null;
                              }
                              return "Field required";
                            },
                            controller: password,
                            obscureText: obscureText,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            prefixIconConstraints: const BoxConstraints(maxWidth: 32),
                            suffixIconConstraints: const BoxConstraints(maxWidth: 25),
                          ),
                          secondWidget: TextButton(
                            onPressed: () {
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
                              if (validated) {
                                viewModel.login(
                                    LoginEntity(userName: name.text.trim(), password: password.text.trim()), this);
                              }
                            },
                            color: Style.primaryColor,
                            child: Text(
                              'Log in',
                              style: context.textTheme.subtitle1?.copyWith(
                                  fontFamily: 'Raleway',
                                  color: Style.scaffoldBackground,
                                  fontWeight: FontWeight.w600,
                                  fontSize: widget.dimens.k16),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          secondWidget: TextButton(
                            onPressed: () {
                              widget.navigator.pushNamedAndRemoveUntil(RoutePath.signup);
                            },
                            child: Text(
                              'Sign up',
                              style: context.textTheme.subtitle1
                                  ?.copyWith(color: Style.primaryColor, fontWeight: FontWeight.w700),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    ));
  }

  @override
  onError(Failure error) {
    SectionToast.show(ErrorMessage.fromError(error).message);
  }

  @override
  onSuccess(User result) async {
    await loadAppData(context);
    context.read<AccountViewModel>().loadUser();
    widget.navigator.pushNamedAndRemoveUntil(RoutePath.home);
  }
}
