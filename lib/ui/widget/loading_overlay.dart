import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:savyor/application/core/extensions/extensions.dart';
import 'package:savyor/ui/base/base_state.dart';

class LoadingOverLay extends StatelessWidget {
  const LoadingOverLay({Key? key,required this.loadingState,required this.child}) : super(key: key);
  final BaseLoadingState loadingState ;
  final Widget child ;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if(loadingState== BaseLoadingState.loading)     AbsorbPointer(
          absorbing: true,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),

            child: SizedBox(height: context.height,width: context.width,),
          ),
        ),
        if(loadingState == BaseLoadingState.loading)  const Center(child: CircularProgressIndicator.adaptive()),
      ],
    );
  }
}
