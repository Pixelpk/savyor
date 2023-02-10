import 'package:flutter/material.dart';
import 'package:savyor/ui/base/base_widget.dart';
import 'package:savyor/ui/widget/section_vertical_widget.dart';

import '../../constant/Images/svgs.dart';
import '../../constant/style.dart';

class AboutPage extends BaseStateFullWidget {
  AboutPage({Key? key}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.8,
        backgroundColor: Colors.white,
        title: const Text(
          "About Savyor",
          style: TextStyle(color: Style.textColor,fontFamily: "DM Sans",fontSize: 14),
        ),
        leading: IconButton(onPressed: () {
          widget.navigator.pop();
        }, icon: const Icon(Icons.arrow_back, color: Style.textColor)),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(bottom: Radius.circular(18))),
      ),
      body: SingleChildScrollView (
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 20),
          child: Column(
            children: [
              SectionVerticalWidget(
                  firstWidget: Text("Who we are?",  style: TextStyle(color: Style.textColor,fontFamily: "DMSans-Bold",fontSize: 16,fontWeight: FontWeight.bold),),
                  secondWidget: Text(
                      "Where to start? Well let’s just say that we are a group of frugal minds! We come from many different places with different backgrounds: business operation, programmer, data scientist, corporate finance, coffee enthusiast…you name it; but being frugal is what all of us share regardless what we do for a living. Being frugal is in our blood, and we are darn proud of it!",   style: TextStyle(color: Style.textColor,fontFamily: "DM Sans",fontSize: 14,height: 1.4),)),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 14),
                child: SizedBox(
                    height: 130,
                    child: Assets.aboutPeople),
              ),

              SectionVerticalWidget(
                  firstWidget: Text("What we believe?",  style: TextStyle(color: Style.textColor,fontFamily: "DMSans-Bold",fontSize: 16,fontWeight: FontWeight.bold)),
                  secondWidget: Text(
                      "We believe that as an online shopper you should never pay full tag price. You simply give out your hard earned money if you buy something without a discount, and for frugal minds that is a big NO-NO. We believe that things should be kept as minimal as possible because minimalist goes well and a long way with frugality. One last thing we believe is data. We all know the phrase “number talks”, but it is the data behind that gives the proper vocabularies.",   style: TextStyle(color: Style.textColor,fontFamily: "DM Sans",fontSize: 14,height: 1.4),)),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 14),
                child: SizedBox(
                    height: 150,child: Assets.aboutPhone),
              ),
              SectionVerticalWidget(
                  firstWidget: Text("What we do?",  style: TextStyle(color: Style.textColor,fontFamily: "DMSans-Bold",fontSize: 16,fontWeight: FontWeight.bold) ),
                  secondWidget: Text(
                      "We are summoned and gather at Savyor because of who we are and what we all believe. We build product that is simple to use, collect the bare minimal information needed, and offer it to online shoppers so you can all achieve money saving with minimal effort. We analyze data and trend to give you insight so you can make informed and smart shopping decision. We provide easy-to-use gadget and tool so shopping and saving is done without sweat and tear. We know that frugalism (is that a word?) takes time to master, and not everyone has the bandwidth and leisure to spare. So we ask that you trust us and enjoy this save journey with us!",   style: TextStyle(color: Style.textColor,fontFamily: "DM Sans",fontSize: 14,height: 1.4),))
            ],
          ),
        ),
      ),
    );
  }
}
