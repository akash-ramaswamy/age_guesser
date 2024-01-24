import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ActionButton extends StatelessWidget {
  final String label;
  final void Function() onPressed;
  final Color backgroundColor;
  final Color foregroundColor;
  final bool isBold;

  const ActionButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.backgroundColor = Colors.black,
    this.foregroundColor = Colors.white,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      // change border radius
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(18),
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(
        label.toUpperCase(),
        style: GoogleFonts.notoSans(
          fontSize: isBold ? 12 : 10,
          letterSpacing: 1.5,
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}
