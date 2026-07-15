import 'package:flutter/material.dart';
import 'package:leli_edit/walure/core/app_color.dart';
import 'package:leli_edit/walure/core/app_routes.dart';
import 'package:leli_edit/walure/core/widgets/bottomSheet.dart';

class AuthProvider extends ChangeNotifier {
  bool _errorDetails = false;

  bool get errorDetails => _errorDetails;
  void login(context, String email, String password) {
    print('logging in');
    String userMail = 'aaa@gmail.com';
    String pwd = '12345678';

    if(email.isEmpty || password.isEmpty){
      _errorDetails = true;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Enter your login details to continue')));
    } else if (email == userMail && password == pwd) {
      Navigator.pushReplacementNamed(context, AppRoutes.pinScreen);
      print('Logged in');
    } else {
      _errorDetails = true;
      showMessageSheet(
        context,
        'Incorrect login details, try again.',
        icon: 'icons/cancel.png',
        iconColor: AppColors.errorLight,
        color: AppColors.error,
      );
    }
    notifyListeners();
  }

  void validatePin(context, String pin){
    String validPin = '2345';
    if(pin.length == 4){
      if(pin ==validPin){
        Navigator.pushReplacementNamed(context, AppRoutes.home);
      }else{
        showMessageSheet(context, 'Incorrect PIN, try again', icon: 'icons/cancel.png');
      }
    }
  }
}
