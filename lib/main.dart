
import 'package:flutter/material.dart';
import 'package:leli_edit/walure/core/app_routes.dart';
import 'package:leli_edit/walure/providers/auth_provider.dart';

import 'package:leli_edit/walure/screens/authScreen/login_screen.dart';
import 'package:leli_edit/walure/screens/authScreen/reset_password_screen.dart';
import 'package:leli_edit/walure/screens/authScreen/transaction_pin/pin_screen.dart';
import 'package:leli_edit/walure/screens/authScreen/transaction_pin/reset_number_screen.dart';
import 'package:leli_edit/walure/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'walure/core/app_color.dart';

void main() {
  runApp(MultiProvider(
    providers: providers,
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.lightBg,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary)
      ),
      initialRoute: AppRoutes.login,

      routes: {
        AppRoutes.login: (context) => const LoginScreen(),
        AppRoutes.resetPassword : (context) =>  ResetPasswordScreen(),
        AppRoutes.pinScreen : (context) => const PinScreen(),
        AppRoutes.resetPin : (context) => const ResetNumberScreen(),
        AppRoutes.home : (context) => const HomeScreen(),
      },
    ),
  ));
}


List<SingleChildWidget> providers =[
  ChangeNotifierProvider(create: (context) => AuthProvider())
];
