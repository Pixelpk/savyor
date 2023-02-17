import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Assets {
  static final logo2x = Image.asset('assets/savyor-logo-x2.png');
  static final logo1x = Image.asset('assets/savyor-logo-x1.png');
  static final logo1_5x = Image.asset('assets/savyor-logo-x1_5.png');
  static final email = Image.asset('assets/email.png');
  static final lock = Image.asset('assets/lock.png');
  static final edit = Image.asset(
    'assets/edit.png',
    height: 20,
  );
  static final search = Image.asset(
    'assets/search.png',
    height: 16,
  );
  static final arrowLeft = Image.asset(
    'assets/arrowLeft.png',
    height: 16,
  );

  static Widget eye(Color? color) => Image.asset(
        'assets/eye.png',
        color: color,
      );
  static final union = SvgPicture.asset('assets/union.svg');
  static final savyorLogo = SvgPicture.asset('assets/icons/savyorLogo.svg');

  static final unionBottom = SvgPicture.asset('assets/unionBottom.svg');
  static final union2 = Image.asset('assets/union2.png');
  static final union3 = Image.asset('assets/union3.png');
  static final unionBottom2 = Image.asset('assets/unionBottom2.png');
  static final unionBottom3 = Image.asset('assets/unionBottom3.png');

  static final aboutPeople = Image.asset('assets/peoples.png');
  static final aboutPhone = Image.asset('assets/phone.png');

  static Widget arrowUp(Color? color) => Image.asset(
        'assets/arrowUp.png',
        color: color,
        height: 16,
      );

  static Widget arrowDown(Color? color) => Image.asset(
        'assets/arrowDown.png',
        color: color,
        height: 16,
      );

  static Widget browser(Color? color) => Padding(
        padding: const EdgeInsets.only(bottom: 4.0, top: 2.0),
        child: Image.asset(
          'assets/browser.png',
          color: color,
          height: 20,
        ),
      );

  static Widget list(Color? color) => Padding(
        padding: const EdgeInsets.only(bottom: 4.0, top: 2.0),
        child: Image.asset(
          'assets/list.png',
          color: color,
          height: 20,
        ),
      );

  static Widget user(Color? color) => Padding(
        padding: const EdgeInsets.only(bottom: 4.0, top: 2.0),
        child: Image.asset(
          'assets/user.png',
          color: color,
          height: 20,
        ),
      );

  static Widget minus({double? height, required bool isZero}) => Image.asset(
        isZero ? 'assets/minus_light.png' : 'assets/minus.png',
        height: height ?? 20,
      );

  static Widget plus({double? height}) => Image.asset(
        'assets/plus.png',
        height: height ?? 20,
      );
  static final defaultProfile = Image.asset('assets/default_profile.png');
  static final progress = Image.asset('assets/progress.png');
  static final editProfile = Image.asset(
    'assets/edit_profile.png',
    height: 45,
  );
  static final frwd = Image.asset(
    'assets/frwd.png',
  );
  static final exit = Image.asset(
    'assets/exit.png',
    height: 20,
  );

  static final backArrow = Image.asset(
    'assets/back_arrow.png',
    height: 25,
  );

  static final cross = Image.asset(
    'assets/cross.png',
    height: 22,
  );

  static final smallLogo = Image.asset(
    'assets/small_logo.png',
    height: 25,
  );

  static final reload = Image.asset(
    'assets/reload.png',
    height: 25,
  );

  static final horizontalMenu = Image.asset(
    'assets/horizontal_menu.png',
    height: 25,
  );

  static final openBrowser = Image.asset(
    'assets/open_browser.png',
    height: 30,
  );
  static final copyLink = Image.asset(
    'assets/copy_link.png',
    height: 25,
  );
  static final exitBrowser = Image.asset(
    'assets/exit_browser.png',
    height: 25,
  );
}
