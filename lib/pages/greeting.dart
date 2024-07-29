import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// The GreetingPage displays a welcome message and an image.
class GreetingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Welcome')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to My Flutter App!',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Image.network(
              'https://example.com/welcome_image.png', // Replace with a valid URL or a local asset
              height: 200,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.go('/login'),
              child: Text('Get Started'),
            ),
          ],
        ),
      ),
    );
  }
}
