import 'package:flutter/material.dart';
import 'package:secret_calculator/pages/password_page.dart';

import '../ui/colors.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [mainColor, mainColorDark],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            const SizedBox(height: 32),
            Image.asset('assets/welcome_cats.png'),
            const SizedBox(height: 16),
            const Text(
              "Welcome",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              "Hide all your photos in a secret calculator!",
              style: TextStyle(color: Colors.white70),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            startButton(context),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: privacyPolicyText(),
            ),
          ],
        ),
      ),
    );
  }

  ElevatedButton startButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const PasswordPage(),
        ),
      ),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: secondaryColor,
        fixedSize: Size(MediaQuery.of(context).size.width - 64, 48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        elevation: 2,
      ),
      child: const Text('Create Password'),
    );
  }

  Text privacyPolicyText() {
    return const Text.rich(
      TextSpan(
        text: "By continuing, you agree to our ",
        children: [
          TextSpan(
            text: "Privacy Policy",
            style: TextStyle(
              color: secondaryColor,
              // underline
            ),
            // recognizer:
          ),
          TextSpan(text: " and \n"),
          TextSpan(
            text: "Terms of Service",
            style: TextStyle(
              color: secondaryColor,
              // underline
            ),
            // recognizer:
          ),
        ],
      ),
      style: TextStyle(
        fontSize: 12,
      ),
      textAlign: TextAlign.center,
    );
  }
}
