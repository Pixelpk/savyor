import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:savyor/application/core/extensions/extensions.dart';
import 'package:savyor/application/main_config/routes/route_path.dart';
import 'package:savyor/constant/Images/svgs.dart';
import 'package:savyor/constant/constants.dart';
import 'package:savyor/constant/style.dart';
import 'package:savyor/data/models/track_product.dart';
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
import '../../domain/entities/password_entity/password_entity.dart';
import '../login/mixin/login_mixin.dart';
import '../widget/flutter_toast.dart';
import '../widget/loading_overlay.dart';

class Password extends BaseStateFullWidget {
  Password({Key? key}) : super(key: key);

  @override
  PasswordState createState() => PasswordState();
}

class PasswordState extends State<Password> with LoginMixin implements Result<ServerResponse> {
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
              child: Consumer<AccountViewModel>(builder: (ctx, viewModel, c) {
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
                        SectionVerticalWidget(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          gap: 0,
                          firstWidget: SectionTextField(
                            hintText: 'New Password',
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
                            controller: name,
                            obscureText: obscureText,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            prefixIconConstraints: const BoxConstraints(maxWidth: 32),
                            suffixIconConstraints: const BoxConstraints(maxWidth: 25),
                          ),
                          secondWidget: SectionTextField(
                            hintText: 'Confirm New Password',
                            prefixIcon: Assets.lock,
                            suffixIcon: Assets.eye(!confirmObscureText ? Style.primaryColor : null).onTap(() {
                              setState(() {
                                confirmObscureText = !confirmObscureText;
                              });
                            }),
                            validator: (e) {
                              if (e != null && e.trim().isNotEmpty && password.text.trim() == name.text.trim()) {
                                return null;
                              }
                              if (password.text.trim() != name.text.trim()) {
                                return "Password not matched";
                              }
                              return "Field required";
                            },
                            controller: password,
                            obscureText: confirmObscureText,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            prefixIconConstraints: const BoxConstraints(maxWidth: 32),
                            suffixIconConstraints: const BoxConstraints(maxWidth: 25),
                          ),
                        ),
                        widget.dimens.k10.verticalBoxPadding(),
                        widget.dimens.k40.verticalBoxPadding(),
                        SectionVerticalWidget(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          gap: 0,
                          firstWidget: BigBtn(
                            onTap: () {
                              if (validated) {
                                final PasswordEntity params =
                                    PasswordEntity(password: password.text.trim(), confirmPassword: name.text.trim());
                                viewModel.changePassword(params, this);
                              }
                            },
                            color: Style.primaryColor,
                            child: Text(
                              'Confirm',
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
                              widget.navigator.pop();
                            },
                            child: Text(
                              'Back',
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
  onSuccess(ServerResponse result) {
    if (mounted) {
      SectionToast.show(result.msg);
      widget.navigator.pop();
    }
  }
}
