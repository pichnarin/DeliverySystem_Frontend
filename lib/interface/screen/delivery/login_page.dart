import 'package:flutter/material.dart';
import 'package:frontend/interface/component/widgets/custom_text_button.dart';
import 'package:frontend/interface/component/widgets/divider.dart';
import 'package:frontend/interface/component/widgets/social_button.dart';
import 'package:frontend/interface/component/widgets/fill_in_profile_textfield.dart';
import 'package:frontend/interface/screen/delivery/create_account.dart';
import 'package:frontend/interface/screen/delivery/forgot_password_page.dart';
import 'package:frontend/interface/screen/delivery/registration_page.dart';

import '../../theme/theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                const Text(
                  'Login to your\nAccount',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold
                  ),
                ),
                const SizedBox(height: 30),
                ReusableTextField(
                  controller: _nameController,
                  hintText: "Name",
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 10),
                ReusableTextField(
                  controller: _passwordController,
                  hintText: "Password",
                  obscureText: true,
                ),
                const SizedBox(height: 50),
                Center(
                  child: Column(
                    children: [
                      CustomTextButton(
                        buttonText: 'Sign in', 
                        onPressed: () {
                          print("Button Clicked! Navigating...");
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const RegistrationPage()),
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const ForgotPasswordPage()),
                          );
                        },
                        child: const Text(
                          'Forgot the password?',
                          style: TextStyle(
                            color: AppPallete.signInUpText, 
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                const OrDivider(text: 'or continue with',),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SocialButton(
                      label: "Facebook",
                      iconPath: "assets/icons/facebook.png",
                      onPressed: () => print("Facebook Login"),
                      isCompact: true,
                      width: 70,
                      
                    ),
                    const SizedBox(width: 30),
                    SocialButton(
                      label: "Google",
                      iconPath: "assets/icons/google.png",
                      onPressed: () => print("Google Login"),
                      isCompact: true,
                      width: 70, 
                    ),
                    const SizedBox(width: 30),
                    SocialButton(
                      label: "Apple",
                      iconPath: "assets/icons/apple.png",
                      onPressed: () => print("Apple Login"),
                      isCompact: true,
                      width: 70,
                      
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Don\'t have an account?',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppPallete.secondaryText,
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CreateAccount()),
                    );
                      },
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          color: AppPallete.signInUpText, 
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
    );
    
  }
}