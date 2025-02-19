import 'package:flutter/material.dart';
import 'package:frontend/interface/theme/app_pallete.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({super.key, required this.imagePath, required this.title,});
  final String imagePath;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: AppPallete.cardBorder, width: 1)
      ),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                imagePath,
                width: 32,
                height: 32,
              ),
              const SizedBox(width: 10,),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold
                ),
              ),
            ],
          )
          
          
        ),
      ),
    );
  }
}