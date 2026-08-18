import 'package:demoappintern/features/onboarding/views/enter_phone_no_view.dart';
import 'package:demoappintern/features/onboarding/views/splash.dart';
import 'package:demoappintern/features/screens/authScreen/login_screen.dart';
import 'package:demoappintern/features/screens/authScreen/reset_password_screen.dart';
import 'package:demoappintern/features/screens/authScreen/transaction_pin/pin_screen.dart';
import 'package:demoappintern/features/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';

class AppRoutes{

  static const String initRoute = '/';
  static const String login = '/login';
  static const String resetPassword = '/resetPassword';
  static const String pinScreen = '/pinScreen';
  static const String resetPin = '/resetPin';
  static const String phoneScreen = '/enterPhoneNumber';

  static const String home = '/homeScreen';
}


Map<String, WidgetBuilder> routes = {
  AppRoutes.initRoute : (context) => const SplashScreen(),
  AppRoutes.login : (context) => const LoginScreen(),
  AppRoutes.resetPassword: (context) => const ResetPasswordScreen(),
  AppRoutes.pinScreen: (context) => const PinScreen(),
  AppRoutes.home: (context) => const HomeScreen(),
  AppRoutes.phoneScreen : (context) => const EnterPhoneNoView(),
};