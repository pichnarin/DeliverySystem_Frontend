
import 'package:flutter/material.dart';
import 'package:frontend/interface/component/widgets/text_button.dart';
import 'package:frontend/interface/component/widgets/textfield.dart';
import 'package:frontend/interface/screen/delivery/email_verification.dart';
import 'package:frontend/interface/screen/delivery/registration_page.dart';
import 'package:frontend/interface/theme/theme.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              const Text(
                'Forgot Password',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold
                ),
              ),
              const Text(
                'Enter your email address to receive a reset link',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500
                ),
              ),
              const SizedBox(height: 50),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Email Address",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ReusableTextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                  ),
                ],
              ),
              const SizedBox(height: 50),
              Center(
                child: Column(
                  children: [
                    CustomButton(
                      buttonText: 'Continue', 
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const EmailVerification()),
                        );
                      },
                    ),
                  ],
                ),
              ),       
            ],
          ),
        ),
      );
  }
}
