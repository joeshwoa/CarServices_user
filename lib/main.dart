import 'dart:developer';
import 'dart:io';

import 'package:autoflex/firebase_api.dart';
import 'package:autoflex/firebase_options.dart';
import 'package:autoflex/locale/translation.dart';
import 'package:autoflex/models/signUp.dart';
import 'package:autoflex/shared/shared_preference.dart';
import 'package:autoflex/styles/colors.dart';
import 'package:autoflex/views/Auth/otp-screen.dart';
import 'package:autoflex/views/Auth/signUp.dart';
import 'package:autoflex/views/Auth/sign-in.dart';
import 'package:autoflex/views/Auth/social-sign-up.dart';
import 'package:autoflex/views/Auth/success-screen.dart';
import 'package:autoflex/views/home_screen.dart';
import 'package:autoflex/views/locations/myLocations.dart';
import 'package:autoflex/views/splashScreen.dart';
import 'package:autoflex/views/welcome/chooseLang_screen.dart';
import 'package:autoflex/views/welcome/welcome_screen.dart';
import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

dynamic isLoggedIn = false;
dynamic token = "";
SignUp userData = SignUp();
dynamic localization = "en";
dynamic welcomed = false;

final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseApi().initNotifications();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  if (prefs.get('isLoggedIn') != null) {
    isLoggedIn = prefs.get('isLoggedIn');
    print(isLoggedIn);
  }
  if (prefs.get('welcomed') != null) {
    welcomed = prefs.get('welcomed');
    print(welcomed);
  }

  //debugPrint('is Loggend In $isLoggedIn');
  if (prefs.get('token') != null) {
    token = prefs.get('token');
    print(token);
  }

  if (prefs.get('localization') != null) {
    localization = prefs.get('localization');
    print("main lang $localization");
  }
  if (prefs.getString('userData') != null) {
    userData = signUpFromJson(prefs.getString('userData')!);
    inspect(userData.data);
  }

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  ChuckerFlutter.showOnRelease = true;
  ChuckerFlutter.showNotification = true;
  runApp(const MyApp()
      /*DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) =>
    const MyApp(),)*/
      );
  // await Future.delayed(const Duration(seconds: 3), FlutterNativeSplash.remove);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.putAsync<SharedPreferences>(() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs;
    }, tag: 'tagsAreEverywhere', permanent: true);

    final SharedPreferenceController pref = Get.put(
        SharedPreferenceController(),
        tag: 'tagsAreEverywhere',
        permanent: true);
//  Future.delayed(const Duration(seconds: 2), () {
    pref.userToken.value = token;
    pref.isLoggedIn.value = isLoggedIn;
    if (isLoggedIn) {
      pref.localization.value = localization;
      pref.userData.value = userData;
    }
    pref.welcomed.value = welcomed;
// print(localization);
// print(pref.localization.value);
    // Get.put(LangController(), permanent: true,);
    Future<String?> _getId() async {
      var deviceInfo = DeviceInfoPlugin();
      if (Platform.isIOS) {
        // import 'dart:io'
        var iosDeviceInfo = await deviceInfo.iosInfo;
        return iosDeviceInfo.identifierForVendor; // unique ID on iOS
      } else {
        var androidDeviceInfo = await deviceInfo.androidInfo;
        return androidDeviceInfo.id; // unique ID on Android
      }
    }

    Future.delayed(const Duration(milliseconds: 3000)).then((value) {
      _getId().then((value) {
        pref.uuid.value = value!;
        print('android identifier2 ${pref.uuid.value}');
        pref.setValue('uuid', value);
      });
    });
    Map<int, Color> colorCodes = {
      50: const Color.fromRGBO(0, 47, 108, .1),
      100: const Color.fromRGBO(0, 47, 108, .2),
      200: const Color.fromRGBO(0, 47, 108, .3),
      300: const Color.fromRGBO(0, 47, 108, .4),
      400: const Color.fromRGBO(0, 47, 108, .5),
      500: const Color.fromRGBO(0, 47, 108, .6),
      600: const Color.fromRGBO(0, 47, 108, .7),
      700: const Color.fromRGBO(0, 47, 108, .8),
      800: const Color.fromRGBO(0, 47, 108, .9),
      900: const Color.fromRGBO(0, 47, 108, 1),
    };
    MaterialColor colorCustom = MaterialColor(0xff002F6C, colorCodes);
    return Sizer(builder: (context, orientation, deviceType) {
      final pref =
          Get.find<SharedPreferenceController>(tag: 'tagsAreEverywhere');
      return GetMaterialApp(
          title: 'Auto Flex',
          theme: ThemeData(
              colorScheme: ColorScheme(
                  onSurface: const Color(0xfff2f2f2),
                  primary: colorCustom,
                  onSecondary: ConstantColors.secondaryColor,
                  surface: const Color.fromRGBO(118, 118, 128, .12),
                  secondary: ConstantColors.secondaryColor,
                  brightness: Brightness.light,
                  background: ConstantColors.backgroundColor,
                  onBackground: ConstantColors.backgroundColor,
                  error: ConstantColors.errorColor,
                  onError: ConstantColors.errorColor,
                  onPrimary: colorCustom),
              textTheme: TextTheme(
                displaySmall: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF959699),
                    fontFamily: localization == "en"
                        ? GoogleFonts.roboto().fontFamily
                        : 'DubaiFont'),
                displayLarge: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                    color: ConstantColors.primaryColor,
                    fontFamily: localization == "en"
                        ? GoogleFonts.roboto().fontFamily
                        : 'DubaiFont',
                    overflow: TextOverflow.ellipsis),
                displayMedium: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: ConstantColors.bodyColor,
                ),
                titleLarge: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w700,
                    color: ConstantColors.primaryColor,
                    fontFamily: localization == "en"
                        ? GoogleFonts.roboto().fontFamily
                        : 'DubaiFont'),
                titleMedium: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w900,
                    color: ConstantColors.primaryColor,
                    fontFamily: localization == "en"
                        ? GoogleFonts.roboto().fontFamily
                        : 'DubaiFont',
                    overflow: TextOverflow.ellipsis),
                titleSmall: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: ConstantColors.primaryColor,
                    overflow: TextOverflow.ellipsis,
                    fontFamily: localization == "en"
                        ? GoogleFonts.roboto().fontFamily
                        : 'DubaiFont'),
                labelSmall: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: ConstantColors.bodyColor3,
                    fontFamily: localization == "en"
                        ? GoogleFonts.roboto().fontFamily
                        : 'DubaiFont',
                    decoration: TextDecoration.underline),
                labelMedium: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: ConstantColors.bodyColor3,
                    fontFamily: localization == "en"
                        ? GoogleFonts.roboto().fontFamily
                        : 'DubaiFont'),
                labelLarge: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: ConstantColors.primaryColor,
                    fontFamily: localization == "en"
                        ? GoogleFonts.roboto().fontFamily
                        : 'DubaiFont'),
                headlineSmall: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: ConstantColors.primaryColor,
                    fontFamily: localization == "en"
                        ? GoogleFonts.roboto().fontFamily
                        : 'DubaiFont'),
                headlineMedium: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: ConstantColors.primaryColor,
                    fontFamily: localization == "en"
                        ? GoogleFonts.roboto().fontFamily
                        : 'DubaiFont'),
                headlineLarge: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: ConstantColors.secondaryColor,
                    fontFamily: localization == "en"
                        ? GoogleFonts.roboto().fontFamily
                        : 'DubaiFont'),
                bodyLarge: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: ConstantColors.bodyColor2,
                    overflow: TextOverflow.ellipsis,
                    fontFamily: localization == "en"
                        ? GoogleFonts.roboto().fontFamily
                        : 'DubaiFont'),
                bodyMedium: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: ConstantColors.bodyColor,
                    overflow: TextOverflow.ellipsis,
                    fontFamily: localization == "en"
                        ? GoogleFonts.roboto().fontFamily
                        : 'DubaiFont'),
                bodySmall: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: ConstantColors.primaryColor,
                    fontFamily: localization == "en"
                        ? GoogleFonts.roboto().fontFamily
                        : 'DubaiFont',
                    overflow: TextOverflow.ellipsis),
              ),
              fontFamily: localization == "en"
                  ? GoogleFonts.roboto().fontFamily
                  : 'DubaiFont',
              primaryColor: ConstantColors.primaryColor,
              hintColor: ConstantColors.hintColor,
              scaffoldBackgroundColor: ConstantColors.backgroundColor),
          /* home: isLoggedIn ? const AppNavigation() : const WelcomeScreen(), */
          home:
              // splash
              // ?
              SplashScreen(),
          // :SplashNavigator(),
          // :
          // isLoggedIn
          //     ? HomeScreen()
          //     : !pref.welcomed.value
          //         ? ChooseLangScreen()
          //         : SignInScreen(),
          debugShowCheckedModeBanner: false,
          translations: Translation(),
          locale: Locale(localization),
          fallbackLocale: const Locale('en'),
          navigatorKey: navKey,
          routes: {
            HomeScreen.route: (context) => HomeScreen()
          },
          navigatorObservers: [ChuckerFlutter.navigatorObserver]);
    });
  }
}

class SplashNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return isLoggedIn
        ? HomeScreen()
        : !welcomed
            ? ChooseLangScreen()
            : SignInScreen();
  }
}
