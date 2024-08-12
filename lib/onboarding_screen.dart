import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: "(سەقا)",
          body: "مەنزڵگەیەک بۆ بینینی کەش و هەوای ناوچەکە و دەوروبەر",
          image: Center(child: Image.asset('assets/images/onboard.png', height: 175.0)),
          decoration: PageDecoration(
            titleTextStyle: TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'assets/fonts/kurdish.ttf',
              color: Color.fromARGB(249, 148, 79, 238),
            ),
            bodyTextStyle: TextStyle(
              fontSize: 19.0,
              fontFamily: 'assets/fonts/kurdish.ttf',
            ),
            contentMargin: EdgeInsets.all(16.0),
            pageColor: Color(0xFFFFF0F5),
            imagePadding: EdgeInsets.zero,
          ),
        ),
        PageViewModel(
          title: "",
          body: "گۆڕانکاری وەرزەکان لێرە ببینە ",
          image: Center(child: Image.asset('assets/images/on2.png', height: 700, width: 300)),
          decoration: PageDecoration(
            titleTextStyle: TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'assets/fonts/kurdish.ttf',
            ),
            bodyTextStyle: TextStyle(
              fontSize: 19.0,
              fontFamily: 'assets/fonts/kurdish.ttf',
            ),
            contentMargin: EdgeInsets.all(16.0),
            pageColor: Color.fromARGB(255, 252, 220, 207),
            imagePadding: EdgeInsets.zero,
          ),
        ),
        PageViewModel(
          title: "",
          body: "ئامادەکاری بکە بۆ گەشتەکانت لەگەڵ بینینی کەش و هەوای ڕۆژی گەشتەکەت",
          image: Center(child: Image.asset('assets/images/on3.png', height: 700, width: 300)),
          decoration: PageDecoration(
            titleTextStyle: TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'assets/fonts/kurdish.ttf',
            ),
            bodyTextStyle: TextStyle(
              fontSize: 19.0,
              fontFamily: 'assets/fonts/kurdish.ttf',
            ),
            contentMargin: EdgeInsets.all(16.0),
            pageColor: Color(0xFFFFF0F5),
            imagePadding: EdgeInsets.zero,
          ),
        ),
      ],
      onDone: () {
        Navigator.of(context).pushReplacementNamed('/home');
      },
      onSkip: () {
        Navigator.of(context).pushReplacementNamed('/home');
      },
      showSkipButton: true,
      skip: const Text(
        'تێپەڕاندن',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontFamily: 'assets/fonts/kurdish.ttf',
        ),
      ),
      next: const Icon(Icons.arrow_forward),
      done: const Text(
        "دەسپێکردن",
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontFamily: 'assets/fonts/kurdish.ttf',
        ),
      ),
      dotsDecorator: DotsDecorator(
        size: const Size.square(10.0),
        activeSize: const Size(20.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
    );
  }
}
