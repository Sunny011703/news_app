import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtomViewAll extends StatelessWidget {
  const ButtomViewAll({
    super.key, 
    required this.title, 
    required this.onPressed,
  });

  final String title; // Yeh title show karega (jo bhi category ya section ka naam hoga)
  final VoidCallback onPressed; // Jab "View all" button dabayenge to kya hoga

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // Yeh title ko display karega jo hum pass karenge
      title: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w600, // Thoda bold text dikhane ke liye
        ),
      ),
      // "View all" button jo kisi action ko trigger karega
      trailing: TextButton(
        onPressed: onPressed, // Jab button click hoga to yeh function chalega
        child: Text(
          "",
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w400, // Normal weight ka text
          ),
        ),
      ),
    );
  }
}
