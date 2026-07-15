import 'package:flutter/material.dart';
import 'package:leli_edit/walure/core/app_color.dart';
import 'package:leli_edit/walure/core/app_routes.dart';
import 'package:leli_edit/walure/providers/auth_provider.dart';
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
      body: SafeArea(child: Column(children: [
          pinSection()
      ],)),
    );
  }

  Widget pinSection(){
    return Column(
      children: [
        Text('Timed Out', style: TextStyle(fontSize: 30),),
        Text('Enter your 4 digit PIN to continue'),
        Pinput(
          controller: pinCtrl,
          length: 4,
          autofocus: true,
          onCompleted: (pin){context.read<AuthProvider>().validatePin(context, pin);},
          defaultPinTheme: PinTheme(height: 40, width: 50, decoration: BoxDecoration(border: Border.all(color: AppColors.greyBorder))),
          focusedPinTheme: PinTheme(height: 40, width: 50, decoration: BoxDecoration(border: Border.all(color: AppColors.primary))),
          errorPinTheme: PinTheme(height: 40, width: 50, decoration: BoxDecoration(border: Border.all(color: AppColors.error))),
        ),
        InkWell(onTap:  (){Navigator.pushNamed(context, AppRoutes.resetPin);}, child: Text('Forget PIN?'))
      ],
    );
  }
}
