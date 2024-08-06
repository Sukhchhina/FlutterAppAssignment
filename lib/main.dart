import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'services/auth_service.dart';
import 'pages/greeting.dart';
import 'pages/login.dart';
import 'pages/signup.dart';
import 'pages/weather.dart';
import 'pages/currency.dart';
import 'pages/news_list_page.dart';
import 'services/news_service.dart';
import 'providers/news_provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (_) => AuthService(),
        ),
        ChangeNotifierProvider<NewsProvider>(
          create: (_) => NewsProvider(newsService : NewsService()), // Pass NewsService to NewsProvider
        ),
      ],
      child: MyApp(),
    ),
  );
}

/// Main application widget with authentication service.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthService>(
      builder: (context, authService, child) {
        return StreamBuilder<User?>(
          stream: authService.authStateChanges,
          builder: (context, snapshot) {
            // Determine if the user is authenticated
            final isAuthenticated = snapshot.data != null;

            // Create and configure the GoRouter
            final GoRouter router = GoRouter(
              initialLocation: '/',
              routes: [
                // Default route with redirection based on auth state
                GoRoute(
                  path: '/',
                  redirect: (context, state) => isAuthenticated ? '/greeting' : '/login',
                ),
                // Login page
                GoRoute(
                  path: '/login',
                  builder: (context, state) => LoginPage(),
                  redirect: (context, state) => isAuthenticated ? '/greeting' : null,
                ),
                // Signup page
                GoRoute(
                  path: '/signup',
                  builder: (context, state) => SignupPage(),
                  redirect: (context, state) => isAuthenticated ? '/greeting' : null,
                ),
                // Greeting page (protected route)
                GoRoute(
                  path: '/greeting',
                  builder: (context, state) {
            final email = state.extra as String?;
            return GreetingPage(email: email ?? 'Unknown');
            },
                  redirect: (context, state) => isAuthenticated ? null : '/login',
                ),
                // Calculator page (protected route)
                GoRoute(
                  path: '/news_list_page',
                  builder: (context, state) => NewsListPage(),
                  redirect: (context, state) => isAuthenticated ? null : '/news_list_page',
                ),
                // Weather page (protected route)
                GoRoute(
                  path: '/weather',
                  builder: (context, state) => WeatherPage(),
                  redirect: (context, state) => isAuthenticated ? null : '/login',
                ),
                // Currency page (protected route)
                GoRoute(
                  path: '/currency',
                  builder: (context, state) => CurrencyPage(),
                  redirect: (context, state) => isAuthenticated ? null : '/login',
                ),
              ],
              errorBuilder: (context, state) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found: ${state.error}'),
                  ),
                );
              },
            );

            return MaterialApp.router(
              title: 'Flutter App',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              routerConfig: router,
            );
          },
        );
      },
    );
  }
}
