import 'package:flutter/material.dart';

import '../../component/widgets/custom_bottom_navigation_bar.dart';
import '../../component/widgets/orders/order_card.dart';


class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentIndex = 0;

  // Method to handle tab changes
  void _onTab(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomePage', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: [
          // Map Placeholder (Replace with actual map widget)
          Container(
            color: Colors.grey[300], // Placeholder for map
          ),
          // Ride Request Card
          Positioned(
            bottom: 80,
            left: 20,
            right: 20,
            child: OrderCard(
              name: 'Steve Brown', 
              avatar: 'assets/images/user1.png',
              paymentMethod: 'ABA',
              price: '1.75', 
              distance: '5.1', 
              pickupLocation: 'Street360', 
              dropoffLocation: '234 ToulKork St, PhnomPenh', 
              onAccept: (){}, 
              onIgnore: (){}
            ),
            
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar( 
        currentIndex: _currentIndex,
        onTap: _onTab,
      )
    );
  }
}
