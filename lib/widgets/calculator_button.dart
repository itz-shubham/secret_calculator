import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CalculatorButton extends StatelessWidget {
  final Function() onTap;
  final bool? wide;
  final Color? color, backgroundColor;
  final Widget child;
  const CalculatorButton({
    Key? key,
    this.wide,
    this.color,
    this.backgroundColor,
    required this.child,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final borderRadius = BorderRadius.circular(10);
    return SizedBox(
      width: ((wide != null && wide!) ? deviceWidth / 2 : deviceWidth / 4) - 8,
      height: (deviceWidth / 4) - 8,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
          color: backgroundColor ?? Colors.transparent,
          borderRadius: borderRadius,
          child: InkWell(
            borderRadius: borderRadius,
            onTap: () {
              HapticFeedback.mediumImpact();
              onTap();
            },
            child: Center(
              child: Theme(
                data: ThemeData.dark().copyWith(
                  iconTheme: IconThemeData(
                    color: color ?? const Color(0xFF95ABDC),
                    size: 32,
                  ),
                ),
                child: DefaultTextStyle(
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: color ?? Colors.white,
                  ),
                  child: child,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Widget child(BuildContext context) {
  //   if (lable != null) {
  //     return DefaultTextStyle(
  //       style: TextStyle(color: Colors.green),
  //       child: Text(
  //         lable!,
  //       ),
  //     );
  //   } else {
  //     return icon!;
  //   }
  // }
}

// Color whichColor(String keyValue) {
//   if (keyValue == 'AC') {
//     return const Color(0xFFED6666);
//   } else if (RegExp(r'[\+\-\x\÷\%]').hasMatch(keyValue)) {
//     return const Color(0xFF4B5EFC);
//   } else {
//     return const Color(0xFFFFFFFF);
//   }
// }
