import 'package:flutter/material.dart';
import 'package:savyor/ui/base/base_widget.dart';
import 'package:savyor/ui/widget/section_vertical_widget.dart';

import '../../constant/style.dart';

class Privacy extends BaseStateFullWidget {
  Privacy({Key? key}) : super(key: key);

  @override
  State<Privacy> createState() => _AboutPageState();
}

class _AboutPageState extends State<Privacy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          elevation: 0.8,
          backgroundColor: Colors.white,
          title: const Text("Privacy policy",
              style: TextStyle(color: Style.textColor, fontFamily: "DM Sans", fontSize: 14)),
          leading: IconButton(
              onPressed: () {
                widget.navigator.pop();
              },
              icon: const Icon(Icons.arrow_back, color: Style.textColor)),
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(bottom: Radius.circular(18)))),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
          child: Column(
            children: [
              const Text(
                "At Savyor, we take the privacy of our user seriously. In fact, we take it so seriously that we only obtain the bare minimum to keep the service running and to offer the service we say we offer. Most importantly, the information is disclosed to us only when you make it available to us.",
                style: TextStyle(color: Style.textColor, fontFamily: "DM Sans", fontSize: 14, height: 1.4),
              ),
              SizedBox(height: 22),
              SectionVerticalWidget(
                  firstWidget: const Text(
                    "Our Browser Extension",
                    style: TextStyle(
                        color: Style.textColor, fontFamily: "DMSans-Bold", fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  secondWidget: const Text(
                    "Our Savyor browser extension (“the extension”; “the plug-in”) is the key interface for us to obtain necessary information to perform our service to you. The information we collect through the extension is outlined in the “Information We Collect” section with explanation of how we handle the information. By using our browser extension, you agree to this Privacy Policy.",
                    style: TextStyle(color: Style.textColor, fontFamily: "DM Sans", fontSize: 14, height: 1.4),
                  )),
              SizedBox(height: 22),
              SectionVerticalWidget(
                  firstWidget: const Text("Analytical Use",
                      style: TextStyle(
                          color: Style.textColor,
                          fontFamily: "DMSans-Bold",
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                  secondWidget: const Text(
                    "At Savyor, we aim to use the most advanced technology and available data to offer insight for you to make the best shopping decision and achieve saving you deserve. Therefore, we preserve the right to perform analytical activities to the information we collect.",
                    style: TextStyle(color: Style.textColor, fontFamily: "DM Sans", fontSize: 14, height: 1.4),
                  )),
              SizedBox(height: 22),
              SectionVerticalWidget(
                  firstWidget: const Text("Your Right",
                      style: TextStyle(
                          color: Style.textColor,
                          fontFamily: "DMSans-Bold",
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                  secondWidget: const Text(
                    "At any time, you have the right to access, port, or delete the information we collect from you. Should you feel the need to exercise your right, please send your inquiry to us at support@savyor.co, and we will ensure to work with you to satisfy the request.",
                    style: TextStyle(color: Style.textColor, fontFamily: "DM Sans", fontSize: 14, height: 1.4),
                  )),
              const SizedBox(height: 22),
              SectionVerticalWidget(
                  firstWidget: const Text("Affiliate Programm",
                      style: TextStyle(
                          color: Style.textColor,
                          fontFamily: "DMSans-Bold",
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                  secondWidget: const Text(
                    "Not all retailers that we provide our service for offer affiliate program. When they do, we would try to be part of it. When we are part of the program, the link you click through to the product page using our product (e.g. extension, or notification we send) would earn us commission if you end up purchasing the product.",
                    style: TextStyle(color: Style.textColor, fontFamily: "DM Sans", fontSize: 14, height: 1.4),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
