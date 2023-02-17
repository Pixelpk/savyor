import 'package:fluttertoast/fluttertoast.dart';

class SectionToast {
  static show(String? msg) {
    return Fluttertoast.showToast(
        msg: msg ?? 'Something went wrong',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        // backgroundColor: Style.darkBorderColor,
        // textColor: Style.scaffoldBackground,
        fontSize: 16.0);
  }
}
