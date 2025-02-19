import 'package:flutter/material.dart';
import 'package:frontend/interface/component/widgets/custom_button.dart';
import 'package:frontend/interface/component/widgets/custom_card.dart';
import 'package:frontend/interface/component/widgets/divider.dart';
import 'package:frontend/interface/theme/app_pallete.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.background,
      body: SingleChildScrollView(
        child: Padding(
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
              const CustomCard(
                imagePath: 'assets/icons/facebook.png', 
                title: 'Continue with Facebook'
              ),
              const CustomCard(
                imagePath: 'assets/icons/google.png', 
                title: 'Continue with Google'
              ),
              const CustomCard(
                imagePath: 'assets/icons/apple.png', 
                title: 'Continue with Apple'
              ),
              const SizedBox(height: 30),
              OrDivider(),
              const SizedBox(height: 20),
              CustomButton(
                buttonText: 'Sign in with password', 
                onPressed: (){},
              ),
              const SizedBox(height: 10),
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
                    onTap: (){},
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