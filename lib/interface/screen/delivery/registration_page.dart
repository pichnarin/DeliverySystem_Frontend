import 'package:flutter/material.dart';
import 'package:frontend/interface/component/widgets/custom_button.dart';
import 'package:frontend/interface/component/widgets/social_button.dart';
import 'package:frontend/interface/component/widgets/divider.dart';
import 'package:frontend/interface/screen/delivery/create_account.dart';
import 'package:frontend/interface/screen/delivery/login_page.dart';
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
              SocialButton(
                iconPath: 'assets/icons/facebook.png', 
                label: 'Continue with Facebook',
                onPressed: () => print("Facebook Login"),
              ),
              const SizedBox(height: 10),
              SocialButton(
                iconPath: 'assets/icons/google.png', 
                label: 'Continue with Google',
                onPressed: () => print("Google Login"),
              ),
              const SizedBox(height: 10),
              SocialButton(
                iconPath: 'assets/icons/apple.png', 
                label: 'Continue with Apple',
                onPressed: () => print("Apple Login"),
              ),
              const SizedBox(height: 30),
              const OrDivider(),
              const SizedBox(height: 20),
              CustomButton(
                buttonText: 'Sign in with password', 
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
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