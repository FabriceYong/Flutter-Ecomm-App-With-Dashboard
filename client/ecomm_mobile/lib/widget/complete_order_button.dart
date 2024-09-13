import 'package:flutter/material.dart';

class CompleteOrderButton extends StatelessWidget {
  const CompleteOrderButton({super.key, this.labelText, this.onPressed});

  final String? labelText;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 2,
          foregroundColor: Colors.white,
          backgroundColor: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),
        child: Text(
          labelText ?? 'Complete Order',
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
