import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyAbctx-1rArQxLRxih2oZgnC_5v0wdPhqQ',
        appId: '1:412279854118:android:a40f18e02f5443142202e7',
        messagingSenderId: '412279854118',
        projectId: 'pizzasprintnotification',
      ),
    );
  runApp(const FirebaseCloudMessage());
}

class FirebaseCloudMessage extends StatefulWidget {
  const FirebaseCloudMessage({super.key});

  @override
  State<FirebaseCloudMessage> createState() => _FirebaseCloudMessageState();
}

class _FirebaseCloudMessageState extends State<FirebaseCloudMessage> {
  String? fcmToken;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    requestPermission();
    getToken();
    initInfo();

    // 🔥 Listen for token changes and update
    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
      setState(() {
        fcmToken = newToken;
      });
      saveToken(newToken);
    });
  }

  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('✅ User granted permission');
    } else {
      print('❌ User declined or has not accepted permission');
    }
  }

  void getToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    if (token != null) {
      setState(() {
        fcmToken = token;
      });
      print("✅ FCM Token: $fcmToken");

      // 🔥 Automatically send token to backend (if user is logged in)
      String jwtToken = "YOUR_JWT_TOKEN_HERE"; // Replace with actual JWT Token
      sendFCMTokenToBackend(jwtToken);
    }
  }

  void saveToken(String token) async {
    var url = Uri.parse(
        'https://pizzanotification-2bcd3-default-rtdb.asia-southeast1.firebasedatabase.app/tokens.json');

    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'token': token}),
    );

    if (response.statusCode == 200) {
      print('✅ Token saved successfully: ${response.statusCode}');
    } else {
      print('❌ Failed to save token: ${response.statusCode} - ${response.body}');
    }
  }

  void initInfo() {
    var androidInit = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initSettings = InitializationSettings(android: androidInit);
    flutterLocalNotificationsPlugin.initialize(initSettings);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("📩 Received a message in foreground: ${message.notification?.title}");
      if (message.notification != null) {
        showNotification(message.notification!);
      }
    });
  }

  void showNotification(RemoteNotification notification) async {
    var androidDetails = const AndroidNotificationDetails(
      'channelId',
      'channelName',
      importance: Importance.max,
      priority: Priority.high,
    );

    var notificationDetails = NotificationDetails(android: androidDetails);
    await flutterLocalNotificationsPlugin.show(
      0, // Notification ID
      notification.title,
      notification.body,
      notificationDetails,
    );
  }

  void sendFCMTokenToBackend(String jwtToken) async {
    String? fcmToken = await FirebaseMessaging.instance.getToken();

    if (fcmToken == null) {
      print("❌ No FCM Token found.");
      return;
    }

    var response = await http.post(
      Uri.parse("http://127.0.0.1:8000/api/receivefcmtoken"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwtToken', // Attach JWT Token
      },
      body: jsonEncode({'fcm_token': fcmToken}),
    );

    if (response.statusCode == 200) {
      print("✅ FCM Token Sent Successfully!");
    } else {
      print("❌ Error Sending FCM Token: ${response.body}");
    }
  }

  void getUserToken() async {
    var url = Uri.parse('http://127.0.0.1:8000/api/users');

    var response = await http.get(url);

    if (response.statusCode == 200) {
      print('✅ User data received: ${response.body}');
    } else {
      print('❌ Failed to get user data: ${response.statusCode} - ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Firebase Cloud Messaging'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text('FCM Token: $fcmToken'),

              ElevatedButton(onPressed: getUserToken, child: const Text('Get User')),
              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: fcmToken == null ? null : () {
                  String jwtToken = "YOUR_JWT_TOKEN_HERE"; // Replace with actual JWT Token
                  sendFCMTokenToBackend(jwtToken);
                },
                child: const Text('Send FCM Token to Backend'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
