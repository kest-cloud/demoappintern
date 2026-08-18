import 'package:demoappintern/features/onboarding/views/splash.dart';
import 'package:demoappintern/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'core/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: .fromSeed(seedColor: Color(0xFF298DBE)),
        ),
        initialRoute: '/',
        routes: routes
      ),
    );
  }
}


List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: ((context) => AuthProvider())),
];