import 'package:flutter/material.dart';
import 'package:frontend/domain/provider/user_provider.dart';
import 'package:frontend/interface/screen/delivery/login_screen.dart';
import 'package:frontend/interface/screen/delivery/welcome_screen.dart';
import 'package:provider/provider.dart';

import 'interface/theme/theme.dart';


void main(){
  WidgetsFlutterBinding.ensureInitialized();
  //
  // //initialize firebase
  //
  // await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => UserProvider(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: appTheme,
          home: WelcomeScreen(),
        )
    );
  }
}



