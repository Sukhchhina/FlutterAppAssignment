import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'services/auth_service.dart';
import 'pages/greeting.dart';
import 'pages/login.dart';
import 'pages/signup.dart';
import 'pages/weather.dart';
import 'pages/currency.dart';
import 'pages/calculator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

/// Main application widget with authentication service.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthService(),
      child: Consumer<AuthService>(
        builder: (context, authService, child) {
          return MaterialApp.router(
            title: 'Flutter App',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            routerConfig: GoRouter(
              initialLocation: '/login',
              routes: [
                GoRoute(
                  path: '/',
                  redirect: (context, state) {
                    // Redirect based on authentication state
                    return authService.isAuthenticated ? '/greeting' : '/login';
                  },
                ),
                GoRoute(
                  path: '/login',
                  builder: (context, state) => LoginPage(),
                ),
                GoRoute(
                  path: '/signup',
                  builder: (context, state) => SignupPage(),
                ),
                GoRoute(
                  path: '/greeting',
                  builder: (context, state) => GreetingPage(),
                ),
                GoRoute(
                  path: '/calculator',
                  builder: (context, state) => CalculatorPage(),
                ),
                GoRoute(
                  path: '/weather',
                  builder: (context, state) => WeatherPage(),
                ),
                GoRoute(
                  path: '/currency',
                  builder: (context, state) => CurrencyPage(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
