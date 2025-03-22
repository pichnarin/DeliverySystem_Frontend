import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:frontend/firebase_options.dart';
// import '../../service/google_sign_in_service.dart';
import '../domain/service-customer/google_sign_in_service.dart';
// import '../domain/service/google_sign_in_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    if (e.toString().contains('A Firebase App named "[DEFAULT]" already exists')) {
      // If the default app already exists, do nothing
    } else {
      rethrow;
    }
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text("Google Sign-In")),
        body: Center(child: GoogleSignInButton()),
      ),
    );
  }
}

class GoogleSignInButton extends StatelessWidget {
  final GoogleSignInService _googleSignInService = GoogleSignInService();

  GoogleSignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return Container(
        width: 200,
        height: 50,
        child: GoogleSignInButtonWeb(
          onSignIn: _googleSignInService.signInWithGoogle,
        ),
      );
    } else {
      return ElevatedButton(
        onPressed: _googleSignInService.signInWithGoogle,
        child: const Text('Sign in with Google'),
      );
    }
  }
}

class GoogleSignInButtonWeb extends StatelessWidget {
  final Future<void> Function() onSignIn;

  const GoogleSignInButtonWeb({required this.onSignIn, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSignIn,
      child: Container(
        color: Colors.blue,
        child: Center(
          child: Text(
            'Sign in with Google',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}