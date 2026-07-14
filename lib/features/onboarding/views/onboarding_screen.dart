import 'package:demoappintern/features/onboarding/views/enter_phone_no_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Inventory Management",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF298DBE),
                  ),
                ),
                Text(
                  "Track inventory, get low-stock alerts, and simplify restocking - all in one place.",
                  style: TextStyle(fontSize: 19),
                ),
              ],
            ),
          ),

          Stack(
            children: [
              // Positioned(
              //   child: SvgPicture.asset(
              //     'assets/svgs/cart.svg',
              //     ) 
              //   ),
              // Positioned(
              //   child: SvgPicture.asset(
              //   'assets/svgs/inventory.svg',
              //   ) 
              // ),

            ],
          ),
          
          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
            child: Row(
              spacing: 12,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      
                      backgroundColor: const Color(0xFF344054),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      minimumSize: Size(double.infinity, 50)
                    ),
                    child: const Text("Log in", style: TextStyle(fontSize: 16),),
                  ),
                ),
            
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => 
                      Navigator.push(context, MaterialPageRoute(builder: (_) => EnterPhoneNoView())),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      minimumSize: Size(double.infinity, 50)
                    ),
                    child: const Text("Register", style: TextStyle(fontSize: 16),),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
