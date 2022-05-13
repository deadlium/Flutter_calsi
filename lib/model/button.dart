import 'package:flutter/material.dart';

class Button {
  final String value;
  final Color bgColor;
  final Color fgColor;

  Button(this.value, this.bgColor, this.fgColor);
}

List<Button> button = [
  Button('AC', Colors.grey, Colors.black),
  Button('+/-', Colors.grey, Colors.black),
  Button('%', Colors.grey, Colors.black),
  Button('÷', Colors.orange, Colors.white),
  Button('7', Colors.grey.shade800, Colors.white),
  Button('8', Colors.grey.shade800, Colors.white),
  Button('9', Colors.grey.shade800, Colors.white),
  Button('x', Colors.orange, Colors.white),
  Button('4', Colors.grey.shade800, Colors.white),
  Button('5', Colors.grey.shade800, Colors.white),
  Button('6', Colors.grey.shade800, Colors.white),
  Button('-', Colors.orange, Colors.white),
  Button('1', Colors.grey.shade800, Colors.white),
  Button('2', Colors.grey.shade800, Colors.white),
  Button('3', Colors.grey.shade800, Colors.white),
  Button('+', Colors.orange, Colors.white),
  Button('0', Colors.grey.shade800, Colors.white),
  Button('.', Colors.grey.shade800, Colors.white),
  Button('=', Colors.orange, Colors.white),
];