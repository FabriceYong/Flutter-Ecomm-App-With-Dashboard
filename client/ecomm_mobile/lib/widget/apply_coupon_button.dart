import 'package:flutter/material.dart';

class ApplyCouponButton extends StatelessWidget {
  const ApplyCouponButton({super.key, required this.onPressed});
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8)),
      onPressed: onPressed,
      child: const Text('Apply'),
    );
  }
}
