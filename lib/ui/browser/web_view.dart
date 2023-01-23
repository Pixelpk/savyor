import 'dart:io';
import 'package:flutter/services.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as html;
import 'package:intl/intl.dart';
import 'package:savyor/application/core/extensions/extensions.dart';
import 'package:savyor/constant/Images/svgs.dart';
import 'package:savyor/constant/style.dart';
import 'package:savyor/data/remote_data_source/url_api.dart';
import 'package:savyor/di/di.dart';
import 'package:savyor/ui/browser/component/bottom_sheet.dart';
import 'package:savyor/ui/browser/model/data_parser.dart';
import 'package:savyor/ui/widget/big_btn.dart';
import 'package:savyor/ui/widget/section_horizontal_widget.dart';
import 'package:savyor/ui/widget/section_vertical_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:savyor/common/logger/log.dart';
import 'package:savyor/main.dart';
import 'package:savyor/ui/base/base_widget.dart';

class CustomWebView extends BaseStateFullWidget {
  final ChromeSafariBrowser browser = MyChromeSafariBrowser();

  CustomWebView({super.key});

  @override
  CustomWebViewState createState() => CustomWebViewState();
}

class CustomWebViewState extends State<CustomWebView> {
  @override
  void initState() {
    widget.browser.addMenuItem(ChromeSafariBrowserMenuItem(
        id: 1,
        label: 'Custom item menu 1',
        action: (url, title) {
          d('Custom item menu 1 clicked!');
        }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ChromeSafariBrowser Example'),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () async {
              await widget.browser.open(
                  url: Uri.parse("https://flutter.dev/"),
                  options: ChromeSafariBrowserClassOptions(
                      android: AndroidChromeCustomTabsOptions(shareState: CustomTabsShareState.SHARE_STATE_OFF),
                      ios: IOSSafariOptions(barCollapsingEnabled: true)));
            },
            child: const Text("Open Chrome Safari Browser")),
      ),
    );
  }
}

class CustomInAppWebView extends BaseStateFullWidget {
  CustomInAppWebView({super.key, required this.url});
  final String url;

  @override
  CustomInAppWebViewState createState() => CustomInAppWebViewState();
}

class CustomInAppWebViewState extends State<CustomInAppWebView> {
  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController? webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(useShouldOverrideUrlLoading: true, mediaPlaybackRequiresUserGesture: false, javaScriptEnabled: true,javaScriptCanOpenWindowsAutomatically: true),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  late PullToRefreshController pullToRefreshController;
  String url = "";
  double progress = 0;
  final urlController = TextEditingController();

  @override
  void initState() {
    super.initState();
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
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          InAppWebView(
            key: webViewKey,
            initialUrlRequest: URLRequest(
                url: Uri.parse(
                    "https://www.amazon.com/Stealth-Wireless-Gaming-Headset-PlayStation-Console/dp/B08D44WZTS/")),
            initialOptions: options,
            pullToRefreshController: pullToRefreshController,
            onWebViewCreated: (controller) {
              setState(() {
                webViewController = controller;
              });
            },
            onLoadStart: (controller, url) {
              setState(() {
                this.url = url.toString();
                urlController.text = this.url;

                // d('onLoadStart: ${url.toString()}');
              });
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
              setState(() {
                this.url = url.toString();
                urlController.text = this.url;
              });
              //'document.querySelector("input#ASIN, input[name=\'asin\']").value;'
              //document.querySelector(\"input#ASIN , input[name='asin']\").value;
              webViewController?.evaluateJavascript(source: 'document.querySelector("input#ASIN, input[name=\'asin\']").value;').then((value) {
                d(value);
              });
             // Parser document = await inject<UrlApi>().load(this.url);
             //  String? header = document.getElementsByClassName('a-offscreen')[0].text;
              // /  String? subscribeCount = document.title();
              //  String? img = document.querySelector('.imgTagWrapper img').src;
              // d(header!);
              // d(subscribeCount!);
              //  d(img!);
            },
            onLoadError: (controller, url, code, message) {
              pullToRefreshController.endRefreshing();
            },
            onProgressChanged: (controller, progress) {
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
            onConsoleMessage: (controller, consoleMessage) {
              d('onConsoleMessage: $consoleMessage');
            },
          ),
          progress < 1.0 ? LinearProgressIndicator(value: progress) : Container(),
        ],
      )),
      /*  TextField(
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search)
                ),
                controller: urlController,
                keyboardType: TextInputType.url,
                onSubmitted: (value) {
                  var url = Uri.parse(value);
                  if (url.scheme.isEmpty) {
                    url = Uri.parse("https://www.google.com/search?q=$value");
                  }
                  webViewController?.loadUrl(
                      urlRequest: URLRequest(url: url));
                },
              ),*/

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
                onPressed: () {
                  _handleFABPressed2();
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 16.0,
                ),
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
  void _handleFABPressed2() {
    showModalBottomSheet<int>(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, state) {
          return Popover(
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0, bottom: 10),
              child: SectionVerticalWidget(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  firstWidget: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 16.0,
                    ),
                    child: SectionVerticalWidget(
                      firstWidget: Text(
                        'Track price',
                        style: context.textTheme.headline6?.copyWith(fontWeight: FontWeight.normal, color: Style.textColor.withOpacity(0.5)),
                      ),
                      secondWidget: SectionHorizontalWidget(
                        firstWidget: Assets.minus(height: 30, isZero: price <= 0).onTap(() {
                          state(() {
                            if (price > 0) {
                              price -= 1.0;
                            }
                          });
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
                                '\$${oCcy.format(price)}',
                                style: context.textTheme.headline6?.copyWith(fontWeight: FontWeight.normal, color: Style.textColor),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        thirdWidget: Assets.plus(height: 30).onTap(() {
                          state(() {
                            price += 1.0;
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
                        style: context.textTheme.headline6?.copyWith(fontWeight: FontWeight.normal, color: Style.textColor.withOpacity(0.5)),
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
                                style: context.textTheme.headline6?.copyWith(fontWeight: FontWeight.normal, color: Style.textColor),
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
                          style: context.textTheme.headline6
                              ?.copyWith(fontSize: 16, fontFamily: 'Montserrat Alternates', fontWeight: FontWeight.w500, color: Style.primaryColor),
                        ),
                      ),
                      firstWidget: BigBtn(
                        radius: 30,
                        onTap: () {
                          widget.navigator.pop();
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
          );
        });
      },
    );
  }
}
