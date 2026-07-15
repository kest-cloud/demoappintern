import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Shows the enable-notifications bottom sheet.
/// Call this once when [EnterOtpView] is first displayed.
void showEnableNotifsSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isDismissible: false,
    enableDrag: false,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (_) => const _EnableNotifsSheet(),
  );
}

class _EnableNotifsSheet extends StatefulWidget {
  const _EnableNotifsSheet();

  @override
  State<_EnableNotifsSheet> createState() => _EnableNotifsSheetState();
}

class _EnableNotifsSheetState extends State<_EnableNotifsSheet> {
  bool _enabled = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 36),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // drag handle
          Container(
            width: 48,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.grey.shade400,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          const SizedBox(height: 28),

          // bell icon
          SvgPicture.asset(
            'assets/svgs/notifs.svg',
            width: 96,
            height: 96,
          ),
          const SizedBox(height: 24),

          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: _enabled ? _buildEnabledState() : _buildPromptState(),
          ),
        ],
      ),
    );
  }

  Widget _buildPromptState() {
    return Column(
      key: const ValueKey('prompt'),
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          "Don't miss a notice",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Get real-time notifications on inventory, invoices, sales and more, '
          'keeping you in complete control.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 28),

        // Enable button
        SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            onPressed: () => setState(() => _enabled = true),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2E86C1),
              shape: const StadiumBorder(),
              elevation: 0,
            ),
            child: const Text(
              'Enable push notification',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),

        // Not now button
        SizedBox(
          width: double.infinity,
          height: 52,
          child: OutlinedButton(
            onPressed: () => Navigator.of(context).pop(),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Color(0xFF2E86C1)),
              shape: const StadiumBorder(),
            ),
            child: const Text(
              'Not now',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2E86C1),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEnabledState() {
    Future.delayed(const Duration(milliseconds: 1800), () {
      if (mounted) Navigator.of(context).pop();
    });

    return Column(
      key: const ValueKey('enabled'),
      mainAxisSize: MainAxisSize.max,
      children: const [
        SizedBox(height: 8),
        Text(
          'Push notification enabled!',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
