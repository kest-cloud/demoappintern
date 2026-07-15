import 'package:demoappintern/features/onboarding/views/enter_otp_view.dart';
import 'package:flutter/material.dart';

class EnterPhoneNoView extends StatefulWidget {
  const EnterPhoneNoView({super.key});

  @override
  State<EnterPhoneNoView> createState() => _EnterPhoneNoViewState();
}

class _EnterPhoneNoViewState extends State<EnterPhoneNoView> {
  late TextEditingController _phoneController;
  final _formKey = GlobalKey<FormState>();
  bool _agreed = false;
  
  @override 
  void initState() {
    super.initState();
    _phoneController = TextEditingController();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                "Let's get started",
                style: TextStyle(fontSize: 28),
              ),
              const SizedBox(height: 8),
              const Text(
                "Please use enter your number registered with WhatsApp. We will send you a confirmation code",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 32),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const Text('🇬🇧', style: TextStyle(fontSize: 20)),
                        const SizedBox(width: 8),
                        Icon(Icons.keyboard_arrow_down, color: Colors.grey.shade600),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your mobile number';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Mobile number',
                        hintStyle: const TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Color(0xFF007A9E)),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.red),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.red),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              GestureDetector(
                onTap: () {},
                child: const Text(
                  'Already have an account? Log in',
                  style: TextStyle(color: Color(0xFF007A9E), fontWeight: FontWeight.w600),
                ),
              ),
              const Spacer(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 24,
                    width: 24,
                    child: Checkbox(
                      value: _agreed,
                      onChanged: (value) {
                        setState(() {
                          _agreed = value ?? false;
                        });
                      },
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                      activeColor: const Color(0xFF007A9E),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: RichText(
                      text: const TextSpan(
                        style: TextStyle(color: Colors.grey, fontSize: 13, height: 1.4),
                        children: [
                          TextSpan(text: 'By tapping on the "Continue" button, you agree to the '),
                          TextSpan(text: 'Terms & Conditions', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, decoration: TextDecoration.underline)),
                          TextSpan(text: ' and '),
                          TextSpan(text: 'Privacy Policy', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, decoration: TextDecoration.underline)),
                          TextSpan(text: ' of iPOS'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _agreed 
                  ? () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const EnterOtpView()));
                      }
                  }
                  : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF007A9E),
                    disabledBackgroundColor: const Color(0xFFF0F1F3),
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                  ),
                  child: Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 16,
                      color: _agreed ? Colors.white : Colors.grey.shade400,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
