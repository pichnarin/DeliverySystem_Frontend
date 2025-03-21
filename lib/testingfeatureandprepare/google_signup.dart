import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:frontend/domain/provider/address_provider.dart';
import 'package:frontend/domain/service/food_service.dart';
import 'package:frontend/env/environment.dart';
import 'package:frontend/env/user_local_storage/secure_storage.dart';
import 'package:frontend/interface/screen/customer/foods_list_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/firebase_options.dart';
import 'package:frontend/domain/service/order_service.dart';
import 'package:provider/provider.dart';

import '../domain/provider/cart_provider.dart';
import '../domain/service/location_service.dart';


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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => AddressProvider()),
        // Add other providers here
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(title: const Text("Google Sign-In")),
          body: Center(child: GoogleSignInButton()),
        ),
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

  Future<void> _handleSignIn(BuildContext context) async {
    try {
      UserCredential userCredential;

      if (kIsWeb) {
        final GoogleAuthProvider googleProvider = GoogleAuthProvider();
        userCredential = await FirebaseAuth.instance.signInWithPopup(googleProvider);
      } else {
        final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
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
      await sendIdTokenToBackend(idToken, context);
    } catch (error) {
      print('Error signing in with Google: $error');
    }
  }

  Future<void> sendIdTokenToBackend(String? idToken, BuildContext context) async {
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

        // Store the jwt_token of the user
        await secureLocalStorage.persistentToken(jwtToken);

        final String? storedToken = await secureLocalStorage.retrieveToken();

        print('Stored token: $storedToken');
        print("User signup successful");
        print("Response body: ${response.body}");

        // Navigate to FoodScreen after successful login
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const FoodListScreen()),
        );

        // createAddress();

        // placeOrder();



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
      return SizedBox(
        width: 200,
        height: 50,
        child: GoogleSignInButtonWeb(
          onSignIn: () => _handleSignIn(context),
        ),
      );
    } else {
      return ElevatedButton(
        onPressed: () => _handleSignIn(context),
        child: const Text('Sign in with Google'),
      );
    }
  }
}

class GoogleSignInButtonWeb extends StatelessWidget {
  final Future<void> Function() onSignIn;

  const GoogleSignInButtonWeb({required this.onSignIn, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSignIn,
      child: Container(
        color: Colors.blue,
        child: const Center(
          child: Text(
            'Sign in with Google',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
