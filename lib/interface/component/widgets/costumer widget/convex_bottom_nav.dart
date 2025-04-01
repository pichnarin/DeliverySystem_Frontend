// // convex_bottom_nav.dart
// import 'package:convex_bottom_bar/convex_bottom_bar.dart';
// import 'package:flutter/material.dart';

// class ReactStyleConvexAppBar extends StatelessWidget {
//   final ValueChanged<int> onItemTapped;
//   final int currentIndex;

//   const ReactStyleConvexAppBar({
//     super.key,
//     required this.onItemTapped,
//     required this.currentIndex,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ConvexAppBar(
//       style: TabStyle.react,
//       backgroundColor: const Color.fromARGB(255, 235, 132, 64),
//       color: Colors.white70,
//       activeColor: Colors.white,
//       items: const [
//         TabItem(icon: Icons.local_pizza, title: "Menu"),
//         TabItem(icon: Icons.shopping_bag, title: "Cart"),
//         TabItem(icon: Icons.person, title: "Profile"),
//       ],
//       initialActiveIndex: currentIndex,
//       onTap: onItemTapped,
//     );
//   }
// }