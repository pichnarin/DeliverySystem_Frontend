import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../env/environment.dart';
import '../../../env/user_local_storage/secure_storage.dart';
import 'package:http/http.dart' as http;

import '../../component/widgets/delivery_social_button.dart';
import '../../theme/theme.dart';

class GoogleSignInScreen extends StatefulWidget {
  const GoogleSignInScreen({super.key});

  @override
  State<GoogleSignInScreen> createState() => _GoogleSignInState();
}

class _GoogleSignInState extends State<GoogleSignInScreen> {

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

  bool _isChecked = false;

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

        final String? storedToken = await secureLocalStorage.retrieveToken();

        print ('Stored token: $storedToken');

        print("User signup successful");
        print("Response body: ${response.body}");

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
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/images/pickoff-guy.png', width: 300, height: 300,),
            const SizedBox(height: 20, ),
            const Text(
              'Let\'s you in',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: AppPallete.title,
              ),
            ),
            const SizedBox(height: 20, ),
            const SizedBox(height: 10),
            SocialButton(
              iconPath: 'assets/icons/google.png', 
              label: 'Sign in with Google',
              onPressed: _handleSignIn,
            ),
            const SizedBox(height: 10),
            const SizedBox(height: 30),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center, 
              children: [
                SizedBox(
                  height: 24, 
                    child: Checkbox(
                      value: _isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          _isChecked = value ?? false;
                        });
                      },
                    ),
                  ),
                    Expanded(
                      child: RichText(
                        text: const TextSpan(
                          text: "I agree to the ",
                          style: TextStyle(color: Colors.black, fontSize: 14),
                          children: [
                            TextSpan(
                              text: "Terms & Conditions",
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: " and acknowledge the Privacy Policy.",
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
          ],
        ),
      ),
    );
    



  }
}