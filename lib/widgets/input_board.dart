import 'package:flutter/material.dart';

import '../ui/colors.dart';
import 'calculator_button.dart';

class InputBoard extends StatelessWidget {
  final bool? isPassword;
  final Function(String) onChange;
  final Function onClear, onBackspace, onModuloPress, onSubmit;
  const InputBoard({
    super.key,
    this.isPassword = false,
    required this.onChange,
    required this.onSubmit,
    required this.onClear,
    required this.onBackspace,
    required this.onModuloPress,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CalculatorButton(
              onTap: () => onClear(),
              child: const Text(
                "AC",
                style: TextStyle(color: Color(0xFFFF0000)),
              ),
            ),
            CalculatorButton(
              onTap: () => onBackspace(),
              child: const Icon(Icons.backspace_rounded),
            ),
            CalculatorButton(
              color: const Color(0xFF95ABDC),
              onTap: () => onModuloPress(),
              child: const Text('%'),
            ),
            CalculatorButton(
              color: const Color(0xFF95ABDC),
              onTap: () => onChange('/'),
              // child: const Text("/"),
              child: const Text("÷", style: TextStyle(fontSize: 36)),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CalculatorButton(
              onTap: () => onChange('7'),
              child: const Text("7"),
            ),
            CalculatorButton(
              onTap: () => onChange('8'),
              child: const Text("8"),
            ),
            CalculatorButton(
              onTap: () => onChange('9'),
              child: const Text("9"),
            ),
            CalculatorButton(
              onTap: () => onChange("*"),
              child: const Icon(Icons.clear),
              // child: const Icon(Icons.clear_rounded),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CalculatorButton(
              onTap: () => onChange('4'),
              child: const Text("4"),
            ),
            CalculatorButton(
              onTap: () => onChange('5'),
              child: const Text("5"),
            ),
            CalculatorButton(
              onTap: () => onChange('6'),
              child: const Text("6"),
            ),
            CalculatorButton(
              onTap: () => onChange('-'),
              child: const Icon(Icons.remove),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CalculatorButton(
              onTap: () => onChange('1'),
              child: const Text("1"),
            ),
            CalculatorButton(
              onTap: () => onChange('2'),
              child: const Text("2"),
            ),
            CalculatorButton(
              onTap: () => onChange('3'),
              child: const Text("3"),
            ),
            CalculatorButton(
              onTap: () => onChange('+'),
              child: const Icon(Icons.add),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CalculatorButton(
              onTap: () => onChange('0'),
              wide: true,
              child: const Text("0"),
            ),
            CalculatorButton(
              onTap: () => onChange('.'),
              child: const Text("."),
            ),
            CalculatorButton(
              onTap: () => onSubmit(),
              backgroundColor: secondaryColor,
              child: isPassword != null && isPassword!
                  ? const Icon(Icons.check, color: Colors.white)
                  : const Text("="),
            ),
          ],
        ),
      ],
    );
  }
}
