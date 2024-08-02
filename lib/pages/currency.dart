import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// The CurrencyPage allows users to convert currencies.
class CurrencyPage extends StatefulWidget {
  @override
  _CurrencyPageState createState() => _CurrencyPageState();
}

class _CurrencyPageState extends State<CurrencyPage> {
  final TextEditingController _amountController = TextEditingController();
  double _conversionResult = 0.0;
  double _conversionRate = 1.18; // Example conversion rate from USD to EUR

  /// Converts the entered amount using a fixed conversion rate.
  void _convertCurrency() {
    setState(() {
      double amount = double.tryParse(_amountController.text) ?? 0.0;
      _conversionResult = amount * _conversionRate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Currency Converter'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate back to the GreetingPage using GoRouter
            context.go('/greeting');
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Amount in USD'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _convertCurrency,
              child: Text('Convert to EUR'),
            ),
            SizedBox(height: 20),
            Text(
              'Converted Amount: €$_conversionResult',
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
