// import 'package:flutter/material.dart';
// import '../../service/google_sign_in_service.dart';
// import '../../theme/theme.dart';

// class SignInScreen extends StatelessWidget {
//   final GoogleSignInService googleSignInService = GoogleSignInService();

//   SignInScreen({super.key});

//   Future<void> _signInWithGoogle(BuildContext context) async {
//     final userCredential = await googleSignInService.signInWithGoogle();
    
//     if (userCredential == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Google Sign-In failed or cancelled.')),
//       );
//       return;
//     }

//     final user = userCredential.user;
//     if (user != null) {
//       final idToken = await user.getIdToken();
//       if (idToken != null) {
//         await googleSignInService.sendIdTokenToBackend(idToken);
//         Navigator.pushReplacementNamed(context, '/home');
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Sign In", style: PizzaTextStyles.heading),
//         backgroundColor: PizzaColors.primary,
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(PizzaSpacings.m),
//           child: ElevatedButton(
//             onPressed: () => _signInWithGoogle(context),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: PizzaColors.secondary,
//             ),
//             child: const Text('Sign in with Google'),
//           ),
//         ),
//       ),
//     );
//   }
// }
