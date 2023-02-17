import 'dart:io';
import 'package:flutter/services.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as html;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:savyor/application/core/extensions/extensions.dart';
import 'package:savyor/application/core/failure/failure.dart';
import 'package:savyor/constant/Images/svgs.dart';
import 'package:savyor/constant/style.dart';
import 'package:savyor/data/remote_data_source/url_api.dart';
import 'package:savyor/di/di.dart';
import 'package:savyor/ui/account/user_view_model.dart';
import 'package:savyor/ui/browser/component/bottom_sheet.dart';
import 'package:savyor/ui/browser/model/data_parser.dart';
import 'package:savyor/ui/home/home_view_model.dart';
import 'package:savyor/ui/widget/big_btn.dart';
import 'package:savyor/ui/widget/flutter_toast.dart';
import 'package:savyor/ui/widget/rounded_text_field.dart';
import 'package:savyor/ui/widget/section_horizontal_widget.dart';
import 'package:savyor/ui/widget/section_vertical_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:savyor/common/logger/log.dart';
import 'package:savyor/main.dart';
import 'package:savyor/ui/base/base_widget.dart';

import '../../application/core/result.dart';
import '../../application/network/error_handler/error_handler.dart';
import '../../data/models/user.dart';
import '../../domain/entities/track_product_entity/track_product_entity.dart';

class CustomInAppWebView extends BaseStateFullWidget {
  CustomInAppWebView({super.key, required this.url});

  final String url;

  @override
  CustomInAppWebViewState createState() => CustomInAppWebViewState();
}

class CustomInAppWebViewState extends State<CustomInAppWebView> implements Result {
  final GlobalKey webViewKey = GlobalKey();

  late TextEditingController trackPriceController;

  InAppWebViewController? webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
          useShouldOverrideUrlLoading: true,
          mediaPlaybackRequiresUserGesture: false,
          javaScriptEnabled: true,
          javaScriptCanOpenWindowsAutomatically: true),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  late PullToRefreshController pullToRefreshController;
  late String url = '';
  double progress = 0;
  final urlController = TextEditingController();
  late final User? _user;

  @override
  void initState() {
    super.initState();
    _user = context.read<AccountViewModel>().user;
    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: Colors.blue,
      ),
      onRefresh: () async {
        if (Platform.isAndroid) {
          webViewController?.reload();
        } else if (Platform.isIOS) {
          webViewController?.loadUrl(urlRequest: URLRequest(url: await webViewController?.getUrl()));
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (await webViewController?.canGoBack() ?? false) {
          await webViewController?.goBack();
          return Future.value(false);
        } else {
          return true;
        }
      },
      child: Scaffold(
        body: SafeArea(
            child: Stack(
          children: [
            InAppWebView(
              key: webViewKey,
              initialUrlRequest: URLRequest(url: Uri.parse(widget.url)),
              initialOptions: options,
              pullToRefreshController: pullToRefreshController,
              onWebViewCreated: (controller) {
                setState(() {
                  webViewController = controller;
                });
              },
              onLoadStart: (controller, url) async {
                d("LOADING PAGE ${url}");
                this.url = url.toString();
                urlController.text = this.url;
              },
              androidOnPermissionRequest: (controller, origin, resources) async {
                return PermissionRequestResponse(resources: resources, action: PermissionRequestResponseAction.GRANT);
              },
              shouldOverrideUrlLoading: (controller, navigationAction) async {
                //  d('shouldOverrideUrlLoading: ${navigationAction.toString()}');
                var uri = navigationAction.request.url!;
                if (!["http", "https", "file", "chrome", "data", "javascript", "about"].contains(uri.scheme)) {
                  if (await canLaunchUrl(Uri.parse(url))) {
                    // Launch the App
                    await launchUrl(
                      Uri.parse(url),
                    );
                    // and cancel the request
                    return NavigationActionPolicy.CANCEL;
                  }
                }

                return NavigationActionPolicy.ALLOW;
              },
              onLoadStop: (controller, url) async {
                pullToRefreshController.endRefreshing();
                d("PAGE LOADED");

                this.url = url.toString();
                urlController.text = this.url;
              },
              onLoadError: (controller, url, code, message) {
                pullToRefreshController.endRefreshing();
              },
              onProgressChanged: (controller, progress) async {
                if (progress == 100) {
                  pullToRefreshController.endRefreshing();
                }

                setState(() {
                  this.progress = progress / 100;
                  urlController.text = url;
                });
              },
              onUpdateVisitedHistory: (controller, url, androidIsReload) {
                setState(() {
                  this.url = url.toString();
                  urlController.text = this.url;
                });
              },
              onConsoleMessage: (controller, consoleMessage) {},
            ),
            progress < 1.0 ? LinearProgressIndicator(value: progress) : Container(),
          ],
        )),
        // floatingActionButton: FloatingActionButton(onPressed: () async {
        //   final priceScript = context.read<HomeViewModel>().scrapInstruction.first.priceScript;
        //   openNav();
        //   // String? _price = await webViewController?.evaluateJavascript(
        //   //     source:  "(function () {`$priceScript`})();");
        //   // d(_price??"dfg");
        //   try {
        //     String? da = await webViewController?.evaluateJavascript(source: "(function () {  $priceScript   })();");
        //     d(da ?? "sdsdsd");
        //     if (da != null) {
        //       da.replaceAll("\$", '').replaceAll("£", '');
        //       price = double.tryParse(da) ?? 0.0;
        //     }
        //   } catch (e) {
        //     d(e);
        //   }
        // }),
        bottomNavigationBar: BottomNavigationBar(
          selectedLabelStyle: const TextStyle(fontSize: 0.0, height: 0.0),
          unselectedLabelStyle: const TextStyle(fontSize: 0.0, height: 0.0),
          unselectedFontSize: 0.0,
          selectedFontSize: 0.0,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: TextButton(
                  child: Assets.backArrow,
                  onPressed: () {
                    webViewController?.goBack();
                  },
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: TextButton(
                  child: Assets.cross,
                  onPressed: () {
                    // webViewController?.goForward();
                    widget.navigator.pop();
                  },
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: TextButton(
                  child: Assets.smallLogo,
                  onPressed: () async {
                    if (_user != null) {
                      webViewController?.getUrl().then((value) async {
                        final productLink = "${value?.origin}${value?.path}";
                        TrackProductEntity trackProductEntity =
                            TrackProductEntity(productLink: productLink, userName: _user?.username, auth: _user?.token);
                        final priceScript = context.read<HomeViewModel>().scrapInstruction.first.priceScript;

                        try {
                          String? da = await webViewController?.evaluateJavascript(
                              source: "(function () {  $priceScript   })();");
                          d(da ?? "OON");
                          if (da != null) {
                            final diluted = da.replaceAll("\$", '').replaceAll("£", '');
                            price = double.tryParse(diluted) ?? 0.0;
                            setState(() {});
                          }
                        } catch (e) {
                          d(e);
                        }
                        _handleFABPressed2(this, trackProductEntity);
                        d("PARAMS ${trackProductEntity.toJson()}");
                      });
                    }
                  },
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: TextButton(
                  child: Assets.reload,
                  onPressed: () {
                    webViewController?.reload();
                  },
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: TextButton(
                  child: Assets.horizontalMenu,
                  onPressed: () {
                    _handleFABPressed();
                  },
                ),
                label: ''),
          ],
          type: BottomNavigationBarType.fixed,
          backgroundColor: Style.scaffoldBackground,
        ),
      ),
    );
  }

  void _handleFABPressed() {
    showModalBottomSheet<int>(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Popover(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: SectionVerticalWidget(
              crossAxisAlignment: CrossAxisAlignment.start,
              firstWidget: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                child: SectionHorizontalWidget(
                  firstWidget: Assets.openBrowser,
                  secondWidget: Text(
                    'Open in Browser',
                    style: context.textTheme.headline6?.copyWith(
                      color: Style.textColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ).onTap(() async {
                widget.navigator.pop();
                if (await canLaunchUrl(Uri.parse(url))) {
                  await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
                }
              }),
              secondWidget: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 16.0,
                ),
                child: SectionHorizontalWidget(
                  firstWidget: Assets.copyLink,
                  secondWidget: Text(
                    'Copy link',
                    style: context.textTheme.headline6?.copyWith(
                      color: Style.textColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ).onTap(() async {
                await Clipboard.setData(ClipboardData(text: url));
                widget.navigator.pop();
              }),
              thirdWidget: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 16.0,
                ),
                child: SectionHorizontalWidget(
                  firstWidget: Assets.exitBrowser,
                  secondWidget: Text(
                    'Cancel',
                    style: context.textTheme.headline6?.copyWith(
                      color: Style.textColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ).onTap(() {
                widget.navigator.pop();
              }),
            ),
          ),
        );
      },
    );
  }

  final oCcy = NumberFormat("#,##0.00", "en_US");
  double price = 0;
  int period = 1;

  void _handleFABPressed2(Result result, TrackProductEntity params) {
    trackPriceController = TextEditingController(text: "\$${oCcy.format(price)}");
    showModalBottomSheet<int>(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, state) {
          return Popover(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0, bottom: 10),
                child: SectionVerticalWidget(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    firstWidget: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                      child: SectionVerticalWidget(
                        firstWidget: Text('Track price',
                            style: context.textTheme.headline6
                                ?.copyWith(fontWeight: FontWeight.normal, color: Style.textColor.withOpacity(0.5))),
                        secondWidget: SectionHorizontalWidget(
                          firstWidget: Assets.minus(height: 30, isZero: price <= 0).onTap(() {
                            state(() {
                              if (double.parse(trackPriceController.text.replaceAll('\$', '')) > 0) {
                                trackPriceController.text =
                                    (double.parse(trackPriceController.text.replaceAll('\$', '')) - 1.0).toString();
                                trackPriceController.text = "\$${trackPriceController.text}";
                              }
                            });
                          }),
                          secondWidget: Expanded(
                              child: RoundedTextField(
                                  keyboardType: TextInputType.number,
                                  controller: trackPriceController,
                                  hintText: 'Track Price')

                              // Container(
                              //     constraints: const BoxConstraints(minWidth: 100),
                              //     decoration: BoxDecoration(
                              //         border: Border.all(color: Style.unSelectedColor),
                              //         borderRadius: BorderR[adius.circular(999)),
                              //     child: Padding(
                              //         padding: const EdgeInsets.all(8),
                              //         child: Text('\$${oCcy.format(price)}',
                              //             style: context.textTheme.headline6
                              //                 ?.copyWith(fontWeight: FontWeight.normal, color: Style.textColor),
                              //             textAlign: TextAlign.center))),
                              ),
                          thirdWidget: Assets.plus(height: 30).onTap(() {
                            state(() => {
                                  trackPriceController.text =
                                      (double.parse(trackPriceController.text.replaceAll('\$', '')) + 1.0).toString(),
                                  trackPriceController.text = "\$${trackPriceController.text}"
                                });
                          }),
                        ),
                      ),
                    ),
                    secondWidget: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24.0,
                        vertical: 16.0,
                      ),
                      child: SectionVerticalWidget(
                        firstWidget: Text(
                          'Track period',
                          style: context.textTheme.headline6
                              ?.copyWith(fontWeight: FontWeight.normal, color: Style.textColor.withOpacity(0.5)),
                        ),
                        secondWidget: SectionHorizontalWidget(
                          firstWidget: Assets.minus(height: 30, isZero: period <= 0).onTap(() {
                            if (period > 0) {
                              state(() {
                                period -= 1;
                              });
                            }
                          }),
                          secondWidget: Expanded(
                            child: Container(
                              constraints: const BoxConstraints(minWidth: 100),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Style.unSelectedColor,
                                  ),
                                  borderRadius: BorderRadius.circular(999)),
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Text(
                                  '$period',
                                  style: context.textTheme.headline6
                                      ?.copyWith(fontWeight: FontWeight.normal, color: Style.textColor),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                          thirdWidget: Assets.plus(height: 30).onTap(() {
                            state(() {
                              period += 1;
                            });
                          }),
                        ),
                      ),
                    ),
                    thirdWidget: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24.0,
                        vertical: 16.0,
                      ),
                      child: SectionVerticalWidget(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        secondWidget: TextButton(
                          onPressed: () {
                            widget.navigator.pop();
                          },
                          child: Text(
                            'Cancel',
                            style: context.textTheme.headline6?.copyWith(
                                fontSize: 16,
                                fontFamily: 'Montserrat Alternates',
                                fontWeight: FontWeight.w500,
                                color: Style.primaryColor),
                          ),
                        ),
                        firstWidget: BigBtn(
                          radius: 30,
                          onTap: () {
                            if (price == 0.0) {
                              SectionToast.show("Price cannot be zero");
                            }
                            if (price != 0.0) {
                              params.targetPeriod = period.toString();
                              params.targetPrice = price.toString();
                              context.read<HomeViewModel>().trackProduct(params, result);
                              widget.navigator.pop();
                            }
                          },
                          color: Style.primaryColor,
                          child: Text(
                            'Confirm',
                            style: context.textTheme.subtitle1?.copyWith(
                                fontFamily: 'Montserrat Alternates',
                                color: Style.scaffoldBackground,
                                fontWeight: FontWeight.w600,
                                fontSize: widget.dimens.k16),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    )),
              ),
            ),
          );
        });
      },
    );
  }

  @override
  onError(Failure error) {
    final errorM = ErrorMessage.fromError(error);
    if (errorM.code != null && errorM.code == "001") {
      openNav();
    } else {
      SectionToast.show(errorM.message);
    }
  }

  openNav() {
    showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          content: Container(
            height: 150,
            width: context.width * 0.8,
            child: Column(
              children: [
                Expanded(
                    child: Text(
                  "Sorry you’ve reached maximum tracking limit. Please untrack item in your list before adding more items.",
                  style: context.textTheme.subtitle1?.copyWith(color: Style.textColor),
                )),
                BigBtn(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  color: Style.primaryColor,
                  child: Text(
                    'Ok',
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
        );
      },
    );
  }

  @override
  onSuccess(result) {
    return;
  }
}
