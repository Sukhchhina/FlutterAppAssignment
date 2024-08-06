import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// The GreetingPage displays a welcome message and an image.
class GreetingPage extends StatelessWidget {
  final String email;

  // Constructor to receive the email
  const GreetingPage({Key? key, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userEmail = FirebaseAuth.instance.currentUser?.email ?? 'Unknown';

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
            Image.asset(
              'lib/assets/performance.jpg',
              height: 200,
            ),
            SizedBox(height: 20),
            Text(
              'Greetings: $userEmail',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.go('/currency'),
              child: Text('Check USD to EUR'),
            ),
            ElevatedButton(
              onPressed: () => context.go('/weather'),
              child: Text('Check Weather'),
            ),
            ElevatedButton(
              onPressed: () => context.go('/news_list_page'),
              child: Text('Latest News'),
            ),
            ElevatedButton(
              onPressed: () async {
                // Sign out from Firebase Auth
                await FirebaseAuth.instance.signOut();

                // Navigate back to the login page after signing out
                context.go('/login');
              },
              child: Text('Log out'),
            ),
          ],
        ),
      ),
    );
  }
}
