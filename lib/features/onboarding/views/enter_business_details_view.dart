import 'package:demoappintern/features/onboarding/views/enter_password_view.dart';
import 'package:demoappintern/features/onboarding/widgets/custom_dropdown.dart';
import 'package:demoappintern/features/onboarding/widgets/selection_bottom_sheet.dart';
import 'package:flutter/material.dart';

class EnterBusinessDetailsView extends StatefulWidget {
  const EnterBusinessDetailsView({super.key});

  @override
  State<EnterBusinessDetailsView> createState() => _EnterBusinessDetailsViewState();
}

class _EnterBusinessDetailsViewState extends State<EnterBusinessDetailsView> {
  late TextEditingController _businessNameController;
  late TextEditingController _businessEmailController;
  late TextEditingController _businessTypeController;

  @override
  void initState() {
    super.initState();
    _businessNameController = TextEditingController(text: 'Adebade ACME');
    _businessEmailController = TextEditingController(text: 'adebade.ola@domain.go');
    _businessTypeController = TextEditingController(text: 'Select');
  }

  @override
  void dispose() {
    _businessNameController.dispose();
    _businessEmailController.dispose();
    _businessTypeController.dispose();
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
                    value: 0.5,
                    strokeWidth: 3,
                    backgroundColor: Colors.grey.shade200,
                    valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF2B88D8)),
                  ),
                ),
                const Text('1/2', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              ],
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            const Text(
              "Business details",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            const Text(
              "Name as in your official documents",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            CustomDropdown(label: 'Business name', value: '', controller: _businessNameController),
            CustomDropdown(label: 'Business email', value: '', controller: _businessEmailController),
            CustomDropdown(
              label: 'Business type',
              value: '',
              isDropdown: true,
              controller: _businessTypeController,
              onTap: () {
                showSelectionBottomSheet(
                  context: context,
                  title: 'Business Type',
                  items: [
                    'Retail',
                    'Pharmacy',
                    'Food & Beverage',
                    'Spa & Beauty',
                    'Laundry',
                    'Others'
                  ],
                  onItemSelected: (selectedItem) {
                    setState(() {
                      _businessTypeController.text = selectedItem;
                    });
                  },
                );
              },
            ),
            CustomDropdown(label: 'Country', value: 'Select', isDropdown: true, onTap: () {}),
            CustomDropdown(label: 'State', value: 'Select', isDropdown: true, onTap: () {}),
            CustomDropdown(label: 'Address', value: 'Select'),
            SizedBox(height: 16),
            Text(
              "Referral code",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            const Text(
              "Enter the code from agent",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
             SizedBox(height: 16),
             CustomDropdown(label: 'Enter code', value: '2462898'),
             SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const EnterPasswordView())),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2B88D8),
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                ),
                child: const Text(
                  'Next',
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
}
