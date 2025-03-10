import 'package:flutter/material.dart';
import 'package:frontend/interface/screen/delivery/active_order.dart';
import 'package:frontend/interface/screen/delivery/delivery_history.dart';
import 'package:frontend/interface/screen/delivery/order_detail.dart';

import 'interface/screen/delivery/home_view.dart';
import 'interface/theme/theme.dart';
// import 'package:frontend/interface/screen/delivery/fill_in_profile_information.dart';
// import 'package:frontend/interface/screen/delivery/create_account.dart';
// import 'package:frontend/interface/screen/delivery/email_verification.dart';
// import 'package:frontend/interface/screen/delivery/forgot_password_page.dart';
// import 'package:frontend/interface/screen/delivery/login_page.dart';
// import 'package:frontend/interface/screen/delivery/my_home_page.dart';
// import 'package:frontend/interface/screen/delivery/registration_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: HomeView(),
      //home: MyHomePage(),
      //home: DeliveryHistory(),
      //home: ActiveOrder(),
      //home: OrderDetail(orderId: '#12345')
      
    );
  }
}

