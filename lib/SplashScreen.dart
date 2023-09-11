import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:route_salesman_system/LoginPage.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: AnimatedSplashScreen(
          splashIconSize: width,
            duration:3000,
            splash: Container(
              width: width,
              height: height,
              /*decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xffFF5F6D),
                      Color(0xffFFC371),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
              ),*/
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset("lib/assets/R-Logo.png",width: width*0.35,),
                  Text("Welcome to Route",style: TextStyle(fontSize: width*0.04,)),
                  Text("The best salesman system",style: TextStyle(fontSize: width*0.02,)),
                ],
              ),
            ),
            nextScreen: const LoginPage(),
            splashTransition: SplashTransition.fadeTransition,
            pageTransitionType: PageTransitionType.fade,
            animationDuration: const Duration(milliseconds: 2000),
            backgroundColor: Colors.grey,
        )
    );
  }
}
