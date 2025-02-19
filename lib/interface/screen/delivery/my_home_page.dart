import 'package:flutter/material.dart';
import 'package:frontend/interface/component/widgets/custom_button.dart';
import 'package:frontend/interface/screen/delivery/registration_page.dart';
import 'package:frontend/interface/theme/app_pallete.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.background,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Image.asset('assets/images/logo_locat.png', width: 200, height: 200,),
              const SizedBox(height: 10, ),
              const Text(
                'Pizza Sprint',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: AppPallete.title,
                ),
              ),
              const Text(
                'Drive. Deliver. Delight',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20,),
              Image.asset(
                'assets/images/delivery-guy.png',
                width: 400, height: 400
              ),
              const SizedBox(height: 10,),
              CustomButton(
                buttonText: 'Get Started!', 
                onPressed: () {
                  print("Button Clicked! Navigating...");
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const RegistrationPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
       
  }
}