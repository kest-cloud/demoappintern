import 'package:demoappintern/features/onboarding/views/onboarding_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const OnboardingScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TweenAnimationBuilder<Offset>(
          tween: Tween(
            begin: const Offset(0, 3),
            end: Offset.zero,
          ),
          duration: const Duration(milliseconds: 1200),
          curve: Curves.easeInOutBack,
          builder: (context, offset, child) {
            return FractionalTranslation(
              translation: offset,
              child: child,
            );
          },
          child: Image.asset(
            'assets/splash.png',
          ),
        ),
      ),
    );
  }
}