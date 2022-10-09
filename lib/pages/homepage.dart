import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:secret_calculator/pages/gallery_page.dart';
import 'package:secret_calculator/widgets/input_board.dart';

import '../ui/colors.dart';

class HomePage extends StatefulWidget {
  final String appPassword;
  const HomePage({super.key, required this.appPassword});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Parser parser = Parser();
  final ContextModel contextModel = ContextModel();
  String calculationString = "", resultString = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
              reverse: true,
              children: [
                Text(
                  resultString,
                  style: const TextStyle(
                    fontSize: 24,
                    color: Colors.white70,
                  ),
                  textAlign: TextAlign.right,
                ),
                Text(
                  formatString(calculationString),
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.right,
                ),
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
              onBackspace: onBackspace,
              onClear: () => setState(() {
                calculationString = resultString = "";
              }),
              onChange: (v) {
                setState(() => calculationString = calculationString + v);
                final result = calculate();
                if (result != null) {
                  setState(() => resultString = result);
                }
              },
              onModuloPress: () {
                try {
                  double number = double.parse(resultString);
                  resultString = (number / 100).toString();
                  setState(() {});
                } catch (e) {
                  // print(e);
                }
              },
              onSubmit: () {
                if (calculationString == widget.appPassword) {
                  return Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const GalleryPage(),
                    ),
                  );
                }
                if (resultString.isNotEmpty) {
                  setState(() {
                    calculationString = resultString;
                    resultString = "";
                  });
                }
              },
            ),
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(onPressed: () async {
      //   final box = await Hive.openBox<String>('gallery');
      //   box.deleteAll(box.keys);
      // }),
    );
  }

  String? calculate() {
    try {
      Expression expression = parser.parse(calculationString);
      var result = expression.evaluate(EvaluationType.REAL, contextModel);
      String string = result.toString();
      return string.endsWith('.0')
          ? string.substring(0, string.length - 2)
          : string;
    } catch (e) {
      // print(e);
      return null;
    }
  }

  void onBackspace() {
    if (calculationString.isNotEmpty) {
      calculationString =
          calculationString.substring(0, calculationString.length - 1);
      resultString = calculate() ?? '';
      setState(() {});
    } else {
      setState(() => calculationString = resultString = '');
    }
  }
}

String formatString(String string) {
  if (string.isEmpty) {
    return '0';
  } else {
    string = string.replaceAll('*', 'x').replaceAll('/', '÷');
    return string;
  }
}
