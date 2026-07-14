import 'package:demoappintern/features/onboarding/views/enter_business_details_view.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class EnterOtpView extends StatefulWidget {
  const EnterOtpView({super.key});

  @override
  State<EnterOtpView> createState() => _EnterOtpViewState();
}

class _EnterOtpViewState extends State<EnterOtpView> {
  final TextEditingController _otpController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _otpController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 64,
      textStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: const Color(0xFFD4C4F5), width: 2),
      color: const Color(0xFFF9F6FF),
    );

    final submittedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Colors.grey.shade400),
    );

    final errorPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Colors.red.shade300),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const Text(
                "4-digit code",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              const Text(
                "Enter the 4-digit code we sent to your WhatsApp number",
                style: TextStyle(fontSize: 14, color: Colors.grey, height: 1.4),
              ),
              const SizedBox(height: 32),
              Pinput(
                length: 4,
                controller: _otpController,
                focusNode: _focusNode,
                autofocus: true,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: focusedPinTheme,
                submittedPinTheme: submittedPinTheme,
                errorPinTheme: errorPinTheme,
                cursor: Container(
                  width: 1.5,
                  height: 24,
                  color: Colors.black,
                ),
                validator: (value) {
                  if (value != '1234') {
                    return 'Incorrect OTP, hint: 1234';
                  }
                  return null;
                },
                onCompleted: (pin) {
                  if (_formKey.currentState!.validate()) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const EnterBusinessDetailsView()),
                    );
                  }
                },
              ),
              const SizedBox(height: 24),
              const Text(
                'Resend code in 3:00',
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () {},
                child: const Text(
                  'Already have an account? Log in',
                  style: TextStyle(color: Color(0xFF007A9E), fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
