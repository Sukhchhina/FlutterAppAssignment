import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import 'package:go_router/go_router.dart';

/// Login page with email and password fields.
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
              onPressed: () async {
                setState(() {
                  _isLoading = true;
                });
                try {
                  final authService = Provider.of<AuthService>(context, listen: false);
                  final user = await authService.signInWithEmailAndPassword(
                    _emailController.text.trim(),
                    _passwordController.text.trim(),
                  );
                  if (user != null) {
                    // Pass the user's email to the GreetingPage
                    context.go('/greeting', extra: user.email);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Login failed. Please check your credentials.')),
                    );
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('An error occurred. Please try again.')),
                  );
                } finally {
                  setState(() {
                    _isLoading = false;
                  });
                }
              },
              child: Text('Login'),
            ),
            TextButton(
              onPressed: () => context.go('/signup'),
              child: Text('Don\'t have an account? Sign up'),
            ),
          ],
        ),
      ),
    );
  }
}
