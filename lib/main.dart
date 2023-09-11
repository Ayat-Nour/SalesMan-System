import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:route_salesman_system/HomeTabs/ChangePasswordPage.dart';
import 'package:route_salesman_system/HomeTabs/NavigationBarPage.dart';
import 'package:route_salesman_system/SplashScreen.dart';
import 'package:devicelocale/devicelocale.dart';

void main() async  {
  WidgetsFlutterBinding.ensureInitialized();
   Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(child: const MyApp(), supportedLocales:const  [Locale('en'),Locale('ar')], path: 'Lang',saveLocale: true,));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      localeResolutionCallback: (deviceLocale , supportedLocales){
        for(var locale in supportedLocales){
          if(deviceLocale!=null && deviceLocale.languageCode == locale.languageCode) return deviceLocale;
        }
        return supportedLocales.first;
      },
      theme: ThemeData(
        primarySwatch:Colors.pink,
        primaryColor: const Color(0xffFF5F6D),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/navigationBarPage': (context) => const NavigationBarPage(),
        '/changePasswordPage': (context) => const ChangePasswordPage(),
      },
    );
  }
}
