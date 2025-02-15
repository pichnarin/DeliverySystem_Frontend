import 'package:flutter/material.dart';
import 'package:frontend/interface/theme/app_pallete.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.buttonText, required this.onPressed});
  final String buttonText;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return 
    GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7)
        ),
        child: ElevatedButton(
          onPressed: (){}, 
          style: ElevatedButton.styleFrom(
            fixedSize: Size(200, 50),
            backgroundColor: AppPallete.button,
            shadowColor: AppPallete.button,
          ),
          child: Text(
            buttonText,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}