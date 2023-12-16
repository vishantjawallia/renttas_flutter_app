import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnBoardScreen extends StatefulWidget {
  const OnBoardScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardScreen> createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: IntroductionScreen(
          pages: [
            PageViewModel(
              title: 'Title of 1st Page',
              body: 'Body of 1st Page',
              image: buildImage("images/image_1.png"),
              //getPageDecoration, a method to customise the page style
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'Title of 2nd Page',
              body: 'Body of 2nd Page',
              image: buildImage("images/image_2.png"),
              //getPageDecoration, a method to customise the page style
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'Title of 3rd Page',
              body: 'Body of 3rd Page',
              image: buildImage("images/image_3.png"),
              //getPageDecoration, a method to customise the page style
              decoration: getPageDecoration(),
            ),
          ],
          onDone: () {
            if (kDebugMode) {
              print("Done clicked");
            }
          },
          //ClampingScrollPhysics prevent the scroll offset from exceeding the bounds of the content.
          scrollPhysics: const ClampingScrollPhysics(),
          showDoneButton: true,
          showNextButton: true,
          showSkipButton: true,
         // isBottomSafeArea: true,
          skip:
          const Text("Skip", style: TextStyle(fontWeight: FontWeight.w600)),
          next: const Icon(Icons.forward),
          done:
          const Text("Done", style: TextStyle(fontWeight: FontWeight.w600)),
          dotsDecorator: getDotsDecorator()),
    );













    
   //  var introScreen = IntroductionScreen(
   //    globalBackgroundColor: Colors.white,
   //    scrollPhysics: const BouncingScrollPhysics(),
   //    pages: [
   //      PageViewModel(
   //        title:
   //          "Manage Properties",
   //        //   style: TextStyle(
   //        //     fontSize: 30,
   //        //     fontWeight: FontWeight.bold,
   //        //
   //        // ),
   //        body: "Keep track of rent & tenants living in multiple properties",
   //        image: const Center(child: Icon(Icons.android)),
   //      ),
   //      PageViewModel(
   //        titleWidget: const Text(
   //          "Manage Expenses",
   //          style: TextStyle(
   //            fontSize: 30,
   //            fontWeight: FontWeight.bold,
   //          ),
   //        ),
   //        body: "Keep track of all the expenses occurred property wise",
   //        image:Image.asset('assets/images/expenseslq.png'),
   //      ),
   //      PageViewModel(
   //        titleWidget: const Text(
   //          "On Time Payment",
   //          style: TextStyle(
   //            fontSize: 30,
   //            fontWeight: FontWeight.bold,
   //          ),
   //        ),
   //        body: "Send rent payment reminders to tenants automatically or manually",
   //        image:  Image.asset('assets/images/businessman.png'),
   //      ),
   //    ],
   //    onDone: () {
   //      Navigator.of(context).pushReplacement(MaterialPageRoute(
   //          builder: (context) => LandlordLogin()));
   //    },
   //    onSkip: () {
   //      Navigator.of(context).pushReplacement(MaterialPageRoute(
   //          builder: (context) => LandlordLogin()));
   //    },
   //    showSkipButton: true,
   //    skip: Icon(FontAwesomeIcons.forward,
   //        color: Colors.purple),
   //    next: const Icon(
   //      FontAwesomeIcons.caretRight ,
   //      color: Colors.blue,
   //      size: 40,
   //    ),
   //    done:Image.asset("assets/images/arrowslead.png",width: 40,),
   //    dotsDecorator: DotsDecorator(
   //        size: const Size.square(10.0),
   //        activeSize: const Size(20.0, 10.0),
   //        color: Colors.black,
   //        activeColor: const Color(0xff6C63FF),
   //        spacing: const EdgeInsets.symmetric(horizontal: 3.0),
   //        activeShape: RoundedRectangleBorder(
   //          borderRadius: BorderRadius.circular(25.0),
   //        )),
   //  );
   //  final screenSize = MediaQuery.of(context);
   //  final screenWidth = screenSize.size.width;
   //  final screenHeight = screenSize.size.height;
   //  return SafeArea(
   // child:  Padding(
   //        padding: const EdgeInsets.all(15),
   //        child: Expanded(child: introScreen),
   //
   //  ));
  }
  Widget buildImage(String imagePath) {
    return Center(
        child: Image.asset(
          imagePath,
          width: 450,
          height: 200,
        ));
  }

  //method to customise the page style
  PageDecoration getPageDecoration() {
    return const PageDecoration(
      imagePadding: EdgeInsets.only(top: 120),
      pageColor: Colors.white,
      bodyPadding: EdgeInsets.only(top: 8, left: 20, right: 20),
      titlePadding: EdgeInsets.only(top: 50),
      bodyTextStyle: TextStyle(color: Colors.black54, fontSize: 15),
    );
  }
  DotsDecorator getDotsDecorator() {
    return const DotsDecorator(
      spacing: EdgeInsets.symmetric(horizontal: 2),
      activeColor: Colors.indigo,
      color: Colors.grey,
      activeSize: Size(12, 5),
      activeShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
      ),
    );
  }
}
