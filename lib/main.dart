import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skitmaker/constants/colors.dart';
import 'package:skitmaker/provider/internet_provider.dart';
import 'package:skitmaker/provider/social_signin_provider.dart';
import 'package:skitmaker/views/splash/boarding_splash.dart';
import 'package:skitmaker/views/splash/home_splash.dart';

int? initScreen;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  initScreen = preferences.getInt('initScreen');
  await preferences.setInt('initScreen', 1);

  await Firebase.initializeApp();
  // await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: ((context) => SignInProvider()),
        ),
        ChangeNotifierProvider(
          create: ((context) => InternetProvideer()),
        )
      ],
      child: GetMaterialApp(
        title: 'Skitmaker',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          backgroundColor: mainBlack,

          textTheme: GoogleFonts.varelaRoundTextTheme(),
          // useMaterial3: true,
          primarySwatch: Colors.red,
        ),
        initialRoute:
            initScreen == 0 || initScreen == null ? 'onboard' : 'home',
        routes: {
          'onboard': (context) => const BoardingSplash(),
          'home': (context) => const HomeSplash(),
        },
      ),
    );
  }
}
