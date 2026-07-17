import 'package:demoappintern/core/app_color.dart';
import 'package:demoappintern/core/app_routes.dart';
import 'package:demoappintern/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class PinScreen extends StatefulWidget {
  const PinScreen({super.key});

  @override
  State<PinScreen> createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {
  final TextEditingController pinCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [pinSection()],
          ),
        ),
      ),
    );
  }

  Widget pinSection() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Timed Out', style: TextStyle(fontSize: 30)),
          const SizedBox(height: 10),
          Text('Enter your 4 digit PIN to continue', style: Theme.of(context).textTheme.bodySmall,),
          const SizedBox(height: 30),
          Pinput(
            controller: pinCtrl,
            length: 4,
            autofocus: true,
            onCompleted: (pin) {
              context.read<AuthProvider>().validatePin(context, pin);
            },
            defaultPinTheme: PinTheme(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: AppColors.greyBorder),
              ),
            ),
            focusedPinTheme: PinTheme(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: AppColors.primary),
              ),
            ),
            errorPinTheme: PinTheme(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.error),
              ),
            ),
          ),

          const SizedBox(height: 15),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.resetPin);
            },
            child: Text(
              'Forget PIN?',
              style: TextStyle(
                color: AppColors.primary,
                // fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
