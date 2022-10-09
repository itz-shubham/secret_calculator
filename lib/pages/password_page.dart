import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:secret_calculator/pages/homepage.dart';

import '../ui/colors.dart';
import '../widgets/input_board.dart';
import 'gallery_page.dart';

class PasswordPage extends StatefulWidget {
  final bool? isPasswordChanging;
  const PasswordPage({super.key, this.isPasswordChanging});

  @override
  State<PasswordPage> createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  bool passwordEntered = false;
  String password = '', confirmPassword = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  !passwordEntered ? "Enter your password" : "Confirm password",
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                Text(
                  passwordText(),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32)
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            decoration: const BoxDecoration(
              color: mainColorDark,
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
            ),
            child: InputBoard(
              isPassword: true,
              onBackspace: onBackspace,
              onClear: onClear,
              onChange: onChange,
              onModuloPress: () => setState(() => password = '$password%'),
              onSubmit: onSubmit,
            ),
          ),
        ],
      ),
    );
  }

  String passwordText() {
    String s = "- - - - -";
    if (!passwordEntered && password.isNotEmpty) {
      s = " * " * password.length;
    }
    if (passwordEntered && confirmPassword.isNotEmpty) {
      s = " * " * confirmPassword.length;
    }
    return s;
  }

  void onBackspace() {
    if (passwordEntered && confirmPassword.isNotEmpty) {
      confirmPassword =
          confirmPassword.substring(0, confirmPassword.length - 1);
      setState(() {});
    }
    if (!passwordEntered && password.isNotEmpty) {
      setState(() => password = password.substring(0, password.length - 1));
    }
  }

  void onClear() {
    password = confirmPassword = '';
    passwordEntered = false;
    setState(() {});
  }

  void onChange(v) {
    if (!passwordEntered) {
      password = password + v;
    } else {
      confirmPassword = confirmPassword + v;
    }
    setState(() {});
  }

  void onSubmit() {
    if (password.length < 4) {
      Fluttertoast.showToast(msg: "Enter atleast 4 characters");
      return;
    }
    if (!passwordEntered) {
      setState(() => passwordEntered = true);
    } else {
      if (confirmPassword == password) {
        final box = Hive.box<String>('appPassword');
        box.put('password', password);
        onSuccess(context);
      } else {
        password = confirmPassword = '';
        passwordEntered = false;
        setState(() {});
        Fluttertoast.showToast(
          msg: "Password doesn't matched!",
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    }
  }

  void onSuccess(BuildContext context) {
    if (widget.isPasswordChanging != null && widget.isPasswordChanging!) {
      Navigator.pop(context);
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(appPassword: password),
        ),
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const GalleryPage()),
      );
    }
    Fluttertoast.showToast(
      msg: widget.isPasswordChanging != null && widget.isPasswordChanging!
          ? "Password Updated!"
          : "Password Created",
      backgroundColor: Colors.green,
    );
  }
}
