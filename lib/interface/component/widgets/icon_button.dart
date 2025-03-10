import 'package:flutter/material.dart';

class IconButton extends StatelessWidget {
  final IconData? icon;
  final VoidCallback? onPressed;
  const IconButton({super.key, this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onPressed,
        child: Icon(icon, size: 24)),
    );
  }
}