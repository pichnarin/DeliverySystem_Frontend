import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:frontend/env/environment.dart';
import 'package:frontend/env/user_local_storage/secure_storage.dart';
import 'package:frontend/interface/screen/delivery/my_home_page.dart';
import 'package:frontend/testingfcm/customer_order.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/firebase_options.dart';

import 'change_role_request.dart';

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
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn(
    clientId: kIsWeb
        ? '412279854118-3mtqpa6434q452khva4m2hg5cbps7v01.apps.googleusercontent.com' // Web client ID
        : null, // Android client ID is automatically used from google-services.json
    scopes: <String>[
      'openid',
      'email',
      'profile',
    ],
  );

  GoogleSignInButton({super.key});

  Future<void> _handleSignIn() async {
    try {
      UserCredential userCredential;

      if (kIsWeb) {
        final GoogleAuthProvider googleProvider = GoogleAuthProvider();
        userCredential = await FirebaseAuth.instance.signInWithPopup(googleProvider);
      } else {
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
        if (googleUser == null) {
          print('User cancelled the login');
          return;
        }

        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      }

      final User? user = userCredential.user;
      if (user == null) {
        print('Error: No user found after sign-in');
        return;
      }

      final String? idToken = await user.getIdToken();
      if (idToken == null) {
        print('Failed to get Firebase ID Token');
        return;
      }

      print('Firebase ID Token: $idToken');
      await sendIdTokenToBackend(idToken);
    } catch (error) {
      print('Error signing in with Google: $error');
    }
  }


  Future<void> sendIdTokenToBackend(String? idToken) async {
    if (idToken == null || idToken.isEmpty) {
      print('Error: idToken is null or empty');
      return;
    }

    try {
      final url = Uri.parse('${Environment.endpointApi}/google-login');
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $idToken', // Some backends require this
        },
        body: jsonEncode(<String, String>{
          'idToken': idToken, // Check if your backend expects a different key
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final String jwtToken = data['jwtToken'] ?? 'No JWT received'; // Handle missing key

        //store the jwt_token of the user
        await secureLocalStorage.persistentToken(jwtToken);

        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(builder: (context) => const MyHomePage()),
        // );

        final String? storedToken = await secureLocalStorage.retrieveToken();

        print ('Stored token: $storedToken');

        print("User signup successful");
        print("Response body: ${response.body}");


        print('Placing order...');

        //place order
        await placeOrder(1, 1, [
          {
            "food_id": 1,
            "quantity": 2,
          },
          {
            "food_id": 2,
            "quantity": 1,
          }
        ], 'paid_out');

        print("change role request...");
        //change role request
        await changeRoleRequest('driver');

      } else {
        print('Failed to authenticate with backend. Status Code: ${response.statusCode}');
        print('Response body: ${response.body}'); // Print response for debugging
      }
    } catch (e) {
      print('Error sending idToken to backend: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return Container(
        width: 200,
        height: 50,
        child: GoogleSignInButtonWeb(
          onSignIn: _handleSignIn,
        ),
      );
    } else {
      return ElevatedButton(
        onPressed: _handleSignIn,
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
