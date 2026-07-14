import 'package:flutter/material.dart';

class EnterPasswordView extends StatefulWidget {
  const EnterPasswordView({super.key});

  @override
  State<EnterPasswordView> createState() => _EnterPasswordViewState();
}

class _EnterPasswordViewState extends State<EnterPasswordView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24, top: 8, bottom: 8),
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 40,
                  height: 40,
                  child: CircularProgressIndicator(
                    value: 1.0,
                    strokeWidth: 3,
                    backgroundColor: Colors.grey.shade200,
                    valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF2B88D8)),
                  ),
                ),
                const Text('2/2', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              ],
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            const Text(
              "Let’s secure your\naccount",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600, height: 1.2),
            ),
            const SizedBox(height: 8),
            const Text(
              "Choose a password",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 32),
            TextField(
              obscureText: true,
              controller: TextEditingController(text: '123456789012'), // fake dots
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(color: Colors.grey.shade600),
                suffixIcon: Icon(Icons.visibility_outlined, color: Colors.grey.shade500),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFF2B88D8)),
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              "Password requirement",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            _buildRequirement(true, 'Must be at least 8 characters'),
            _buildRequirement(true, 'Must contain one special character'),
            _buildRequirement(false, 'Must have at least one lowercase'),
            _buildRequirement(true, 'Must have at least one uppercase'),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2B88D8),
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                ),
                child: const Text(
                  'Register',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildRequirement(bool isMet, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isMet ? Colors.greenAccent.shade100 : Colors.grey.shade200,
            ),
            child: Icon(
              Icons.check,
              size: 14,
              color: isMet ? Colors.green : Colors.grey.shade400,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            text,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }
}
