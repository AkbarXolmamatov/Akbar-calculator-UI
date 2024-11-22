import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _display = '0'; // Kalkulyator ekrani uchun matn
  double _num1 = 0; // Birinchi raqam
  double _num2 = 0; // Ikkinchi raqam
  String _operator = ''; // Operatorni saqlash

  void _buttonPressed(String value) {
    setState(() {
      if (value == 'C') {
        _display = '0';
        _num1 = 0;
        _num2 = 0;
        _operator = '';
      } else if (value == 'CE') {
        _display = _display.length > 1
            ? _display.substring(0, _display.length - 1)
            : '0';
      } else if (['+', '-', '×', '÷'].contains(value)) {
        _num1 = double.tryParse(_display) ?? 0;
        _operator = value;
        _display = '0';
      } else if (value == '=') {
        _num2 = double.tryParse(_display) ?? 0;
        if (_operator == '+') {
          _display = (_num1 + _num2).toString();
        } else if (_operator == '-') {
          _display = (_num1 - _num2).toString();
        } else if (_operator == '×') {
          _display = (_num1 * _num2).toString();
        } else if (_operator == '÷') {
          _display = _num2 != 0 ? (_num1 / _num2).toString() : 'Error';
        }
        _num1 = 0;
        _num2 = 0;
        _operator = '';
      } else {
        _display = _display == '0' ? value : _display + value;
      }
    });
  }

  Widget _buildButton(String text, Color bgColor, Color textColor) {
    return GestureDetector(
      onTap: () => _buttonPressed(text),
      child: Container(
        height: 75,
        width: 75,
        decoration: BoxDecoration(
          color: bgColor,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(fontSize: 22, color: textColor),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Kalkulyator ekrani
            Container(
              height: 60,
              width: 300,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(60),
              ),
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20),
              child: Text(
                _display,
                style: const TextStyle(
                    fontSize: 40,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            // Tugmalar joylashuvi
            Wrap(
              spacing: 20,
              runSpacing: 20,
              children: [
                _buildButton('%', Colors.grey[300]!, Colors.black),
                _buildButton('√', Colors.grey[300]!, Colors.black),
                _buildButton('CE', Colors.grey[300]!, Colors.black),
                _buildButton('C', Colors.black, Colors.white),
                _buildButton('7', Colors.grey[400]!, Colors.black),
                _buildButton('8', Colors.grey[400]!, Colors.black),
                _buildButton('9', Colors.grey[400]!, Colors.black),
                _buildButton('-', Colors.red, Colors.white),
                _buildButton('4', Colors.grey[400]!, Colors.black),
                _buildButton('5', Colors.grey[400]!, Colors.black),
                _buildButton('6', Colors.grey[400]!, Colors.black),
                _buildButton('÷', Colors.blue, Colors.white),
                _buildButton('1', Colors.grey[400]!, Colors.black),
                _buildButton('2', Colors.grey[400]!, Colors.black),
                _buildButton('3', Colors.grey[400]!, Colors.black),
                _buildButton('×', Colors.amber, Colors.white),
                _buildButton('.', Colors.grey[400]!, Colors.black),
                _buildButton('0', Colors.grey[400]!, Colors.black),
                _buildButton('=', Colors.white, Colors.black),
                _buildButton('+', Colors.green, Colors.white),
              ],
            ),
          ],
        ),
      ),
    );
  }
}