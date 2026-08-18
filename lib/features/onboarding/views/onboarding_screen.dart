import 'package:demoappintern/core/app_routes.dart';
import 'package:demoappintern/features/onboarding/views/enter_phone_no_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 36),
                  Text(
                    "Inventory management",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF298DBE),
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Track inventory, get low-stock alerts, and simplify restocking - all in one place.",
                    style: TextStyle(
                      fontSize: 16,
                      color: const Color(0xFF344054),
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: Stack(
                children: [
                  // Handcart illustration positioned on the left-center
                  Positioned(
                    left: -0,
                    right: 90,
                    top: 0,
                    bottom: 0,
                    child: SvgPicture.asset(
                      'assets/svgs/cart.svg',
                      fit: BoxFit.contain,
                    ),
                  ),
                  // Floating inventory cards positioned on the right
                  Positioned(
                    right: 20,
                    top: 0,
                    bottom: 100,
                    width: 145,
                    child: SvgPicture.asset(
                      'assets/svgs/inventory.svg',
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Button Section
            Padding(
              padding: const EdgeInsets.only(
                left: 24.0,
                right: 24.0,
                bottom: 32.0,
                top: 12.0,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {Navigator.pushNamed(context, AppRoutes.login);},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2A3447),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                        minimumSize: const Size(double.infinity, 54),
                        elevation: 0,
                      ),
                      child: const Text(
                        "Log in",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const EnterPhoneNoView()),
                      ),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF298DBE),
                        side: const BorderSide(
                          color: Color(0xFFB3D9EC),
                          width: 1.5,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                        minimumSize: const Size(double.infinity, 54),
                        elevation: 0,
                      ),
                      child: const Text(
                        "Register",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
