import 'package:demoappintern/core/app_color.dart';
import 'package:demoappintern/core/app_routes.dart';
import 'package:demoappintern/core/widgets/app_button.dart';
import 'package:demoappintern/core/widgets/form_field_widget.dart';
import 'package:demoappintern/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();

  final GlobalKey<FormFieldState> mailKey = GlobalKey();
  final GlobalKey<FormFieldState> passwordKey = GlobalKey();
  final GlobalKey<FormState> formKey = GlobalKey();
  bool nameFilled = false;
  bool pwdFilled = false;
  @override
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
    final provider = context.watch<AuthProvider>();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image(
                image: AssetImage('assets/splash.png',),
                height: 50,
                width: 50,
                errorBuilder: (_, __, ___) =>
                    Icon(Icons.image, color: AppColors.greyBorder, size: 40),
              ),
              formSection(),
              Spacer(),
              registerSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget formSection() {

    final provider = context.watch<AuthProvider>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 15),
          child: Text(
            'Welcome Back',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w500,
              fontFamily: 'inter',
            ),
          ),
        ),

        ///Form
        AppFormField(
          fieldKey: mailKey,
          validator: (val) {},
          label: 'Email Address',
          controller: emailCtrl,
          textInputType: TextInputType.emailAddress,
          filled: nameFilled,
          onError: provider.errorDetails,
        ),
        AppFormField(
          fieldKey: passwordKey,
          validator: (val) {},
          label: 'Password',
          controller: passwordCtrl,
          isObscure: true,
        ),

        ///Forget Button
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.resetPassword);
          },
          child: const Text(
            'Forget password?',
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.end,
          ),
        ),
        const SizedBox(height: 20),
        AppButton(
          label: 'Login',
          onPressed: () {
            context.read<AuthProvider>().login(context, emailCtrl.text, passwordCtrl.text);
          },
        ),
      ],
    );
  }


  Widget registerSection() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Text('Don`t have an account?'),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.primary),
              foregroundColor: AppColors.primary,
              textStyle: TextStyle(fontWeight: FontWeight.bold),
            ),
            child: Text('Register'),
          ),
        ),
      ],
    );
  }
}
