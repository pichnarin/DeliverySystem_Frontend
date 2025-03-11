import 'package:flutter/material.dart';
import 'package:frontend/interface/screen/delivery/active_order.dart';
import 'package:frontend/interface/screen/delivery/delivery_history.dart';
import 'package:frontend/interface/screen/delivery/profile_setting.dart';
import '../../component/widgets/custom_bottom_navigation_bar.dart';
import '../../component/widgets/orders/order_card.dart';


class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentIndex = 0;

  // List of widgets to display for each tab
  late List<Widget> _screens;
  @override
  void initState() {
    super.initState();
    _screens = [
      HomeViewContent(), 
      ActiveOrder(),
      DeliveryHistory(),
      ProfileSetting(),
    ];
  }

  // Method to handle tab changes
  void _onTab(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTab,
      ),
    );
  }
}

class HomeViewContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold( // Add a Scaffold here.
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
          Container(
            color: Colors.grey[300],
          ),
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
              onAccept: () {},
              onIgnore: () {},
            ),
          ),
        ],
      ),
    );
  }
}