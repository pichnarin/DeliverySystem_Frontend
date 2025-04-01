import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:frontend/firebase_options.dart';
import 'package:provider/provider.dart';

import 'domain/providers-customer/cart_provider.dart';
import 'domain/providers-customer/category_provider.dart';
import 'domain/providers-customer/food_provider.dart';
import 'interface/component/widgets/costumer widget/main_wrapper.dart';
import 'interface/screen/costumer/homescreen/home_screen.dart';
import 'interface/screen/costumer/login/signup_screen.dart';
import 'interface/screen/costumer/sign_up/google_signup.dart';
// import 'interface/main_wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    if (!e.toString().contains('A Firebase App named "[DEFAULT]" already exists')) {
      debugPrint("Firebase Initialization Error: $e");
    }
  }
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => FoodProvider()),
        ChangeNotifierProvider(create: (context) => CategoryProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(), // Start with HomeScreen
      routes: {
        '/menu': (context) => const MainWrapper(), // Add route for MainWrapper
        '/signIn': (context) => const SignInScreen(),
        '/signUp': (context) => const CreateAccount(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}