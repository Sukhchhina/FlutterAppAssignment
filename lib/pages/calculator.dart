import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// The CalculatorPage allows users to perform basic arithmetic operations.
class CalculatorPage extends StatefulWidget {
  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String _expression = '';
  String _result = '0';

  /// Adds a character to the current expression.
  void _addToExpression(String value) {
    setState(() {
      _expression += value;
    });
  }

  /// Evaluates the current expression and displays the result.
  void _calculateResult() {
    try {
      final double eval = double.parse(_expression);
      setState(() {
        _result = eval.toString();
      });
    } catch (e) {
      setState(() {
        _result = 'Error';
      });
    }
  }

  /// Clears the current expression.
  void _clearExpression() {
    setState(() {
      _expression = '';
      _result = '0';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Calculator')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Expression: $_expression', style: TextStyle(fontSize: 20)),
            Text('Result: $_result', style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            GridView.count(
              crossAxisCount: 4,
              shrinkWrap: true,
              children: [
                ...['7', '8', '9', '/'],
                ...['4', '5', '6', '*'],
                ...['1', '2', '3', '-'],
                ...['0', '.', '=', '+'],
              ].map((buttonText) {
                return ElevatedButton(
                  onPressed: () {
                    if (buttonText == '=') {
                      _calculateResult();
                    } else {
                      _addToExpression(buttonText);
                    }
                  },
                  child: Text(buttonText),
                );
              }).toList()
                ..add(
                  ElevatedButton(
                    onPressed: _clearExpression,
                    child: Text('C'),
                  ),
                ),
            ),
          ],
        ),
      ),
    );
  }
}
