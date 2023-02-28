import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:savyor/application/core/extensions/extensions.dart';
import 'package:savyor/constant/Images/svgs.dart';
import 'package:savyor/constant/constants.dart';
import 'package:savyor/constant/style.dart';
import 'package:savyor/data/models/track_product.dart';
import 'package:savyor/ui/base/base_widget.dart';
import 'package:savyor/ui/widget/big_btn.dart';
import 'package:savyor/ui/widget/section_text_field.dart';
import 'package:savyor/ui/widget/section_vertical_widget.dart';
import 'package:savyor/ui/widget/ui_background.dart';

import '../../../application/core/failure/failure.dart';
import '../../../application/core/result.dart';
import '../../../application/main_config/routes/route_path.dart';
import '../../../application/network/error_handler/error_handler.dart';
import '../../widget/flutter_toast.dart';
import '../../widget/loading_overlay.dart';
import '../login_view_model.dart';

class ForgotPasswordScreen extends BaseStateFullWidget {
  ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  ForgotPasswordScreenState createState() => ForgotPasswordScreenState();
}

class ForgotPasswordScreenState extends State<ForgotPasswordScreen> implements Result<ServerResponse> {
  bool obscureText = true;
  TextEditingController controller = TextEditingController();
  late GlobalKey<FormState> validKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          UiBackground(),
          Consumer<LoginViewModel>(builder: (ctx, viewModel, c) {
            return LoadingOverLay(
              loadingState: viewModel.state,
              child: Padding(
                padding: EdgeInsets.only(left: widget.dimens.k25, right: widget.dimens.k25, top: widget.dimens.k80),
                child: SizedBox(
                  width: context.width,
                  height: context.height,
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
                      widget.dimens.k40.verticalBoxPadding(),
                      Form(
                        key: validKey,
                        child: SectionVerticalWidget(
                          gap: 15,
                          firstWidget: SectionVerticalWidget(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              firstWidget: Text(
                                'Password recovery',
                                style: context.textTheme.headline6
                                    ?.copyWith(color: Style.textColor, fontWeight: FontWeight.w500),
                              ),
                              secondWidget: Text(
                                'We will send an Email address with the login code',
                                style: context.textTheme.subtitle2
                                    ?.copyWith(color: Style.textColor, fontWeight: FontWeight.normal),
                              )),
                          secondWidget: SectionTextField(
                            hintText: 'Email Address',
                            prefixIcon: Assets.email,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.done,
                            prefixIconConstraints: const BoxConstraints(maxWidth: 30),
                            controller: controller,
                            validator: (e) {
                              if (e != null && e.trim().isNotEmpty && widget.utils.isEmail(e)) {
                                return null;
                              }
                              return "Please add valid email";
                            },
                          ),
                        ),
                      ),
                      widget.dimens.k80.verticalBoxPadding(),
                      BigBtn(
                        onTap: () {
                          if (validKey.currentState!.validate()) {
                            viewModel.forgotPassword(controller.text.trim(), this);
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
                    ],
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    ));
  }

  @override
  onError(Failure error) {
    SectionToast.show(ErrorMessage.fromError(error).message);
  }

  @override
  onSuccess(ServerResponse result) async {
    SectionToast.show(result.msg);
    widget.navigator.pop();
  }
}
