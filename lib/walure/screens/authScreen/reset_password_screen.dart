import 'package:flutter/material.dart';
import 'package:leli_edit/walure/core/widgets/app_button.dart';
import 'package:leli_edit/walure/core/widgets/bottomSheet.dart';
import 'package:leli_edit/walure/core/widgets/form_field_widget.dart';

import '../../core/app_color.dart' show AppColors;

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController emailCtrl = TextEditingController();

  final GlobalKey<FormFieldState> resetKey = GlobalKey();
  final GlobalKey<FormState> formKey = GlobalKey();
  bool nameFilled = false;
  bool err = false;

  void initState() {
    // TODO: implement initState
    emailCtrl.addListener((){setState(() => nameFilled = true);});
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    emailCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(child: resetSection(context)),
            const Spacer(),
            registerSection(),
          ],
        ),
      ),
    );
  }

  Widget resetSection(BuildContext context) {
    return Form(
      key: formKey,
      child: ListView(
        children: [
          Text('Password reset', style: TextStyle(fontSize: 30)),
          const SizedBox(height: 30),
          AppFormField(
            fieldKey: resetKey,
            validator: (val){if(val == null){return 'Enter your email address';} return '';},
            controller: emailCtrl,
            label: 'Email Address',
            textInputType: TextInputType.emailAddress,
            onChanged: (val) => resetKey.currentState!.validate(),
            onError: err,
            filled: nameFilled,
          ),
          const SizedBox(height: 20),
          AppButton(label: 'Send reset link', onPressed: () {
            if(!formKey.currentState!.validate()){
              showMessageSheet(context, 'Reset link sent', icon: 'icons/done.png');
            }else{
              setState(() {
                err = true;
              });
            }
          }),
        ],
      ),
    );
  }

  Widget registerSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Center(child: Text('Don`t have an account?')),
        ),
        OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: AppColors.primary),
            foregroundColor: AppColors.primary,
            textStyle: TextStyle(fontWeight: FontWeight.bold),
          ),
          child: Text('Register'),
        ),
      ],
    );
  }
}
