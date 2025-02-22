import 'package:flutter/material.dart';
import 'package:frontend/interface/component/widgets/custom_button.dart';
import 'package:frontend/interface/component/widgets/textfield.dart';
import 'package:frontend/interface/screen/delivery/login_page.dart';
import 'package:frontend/interface/screen/delivery/registration_page.dart';
import 'package:frontend/interface/theme/app_pallete.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  
  bool _isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.background,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              const Text(
                'Create your\nAccount',
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
                controller: _phoneNumberController,
                hintText: "Phone number",
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              ReusableTextField(
                controller: _passwordController,
                hintText: "Password",
              ),
              const SizedBox(height: 10),
              ReusableTextField(
                controller: _confirmPasswordController,
                hintText: "Confirm Password",
                obscureText: true, 
              ),
              const SizedBox(height: 20), 
              Row(
                crossAxisAlignment: CrossAxisAlignment.center, // Align checkbox with text
                children: [
                  SizedBox(
                    height: 24, // Ensures checkbox height is fixed
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
              const SizedBox(height: 30),
              Center(
                child: CustomButton(
                  buttonText: 'Create Account', 
                  onPressed: () {
                    print("Button Clicked! Navigating...");
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const RegistrationPage()),
                    );
                  },
                ),
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
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                    },
                    child: const Text(
                      'Sign in',
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