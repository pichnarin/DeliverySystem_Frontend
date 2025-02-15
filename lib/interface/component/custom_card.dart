import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({super.key, required this.imagePath, required this.title,});
  final String imagePath;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 4,
      child: ListTile(
        leading: Image.asset(
          imagePath,
          width: 40,
          height: 40,
        ),
        title: Text(title),
      ),
    );
  }
}