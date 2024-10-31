import 'package:code202/colors/custom_colors.dart';
import 'package:code202/pages/challenges_page.dart';
import 'package:code202/pages/home_page.dart';
import 'package:code202/pages/main_page.dart';
import 'package:code202/pages/profile_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'firebase_options.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

bool isNotificationHandled = false; // Flag to prevent duplicate navigation
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await setupInteractedMessage();
  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await initializeFirebaseMessaging();
  runApp(const MyApp());
}

Future<void> initializeFirebaseMessaging() async {
  await FirebaseMessaging.instance.subscribeToTopic('tabung');

  flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.requestNotificationsPermission();

  final fcmToken = await FirebaseMessaging.instance.getToken();
  print("FCM Token: $fcmToken");

  if (fcmToken == null) {
    print("Failed to retrieve FCM token");
  }

  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
      const AndroidNotificationDetails androidNotificationDetails =
          AndroidNotificationDetails(
        '1',
        'tabung1',
        channelDescription: 'your_channel_description',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
      );

      const NotificationDetails notificationDetails =
          NotificationDetails(android: androidNotificationDetails);

      await flutterLocalNotificationsPlugin.show(
        0,
        message.notification?.title ?? 'Title',
        message.notification?.body ?? 'Body',
        notificationDetails,
        payload: 'item x',
      );
    }
  });

  await setupInteractedMessage();
}

Future<void> setupInteractedMessage() async {
  RemoteMessage? initialMessage =
      await FirebaseMessaging.instance.getInitialMessage();
  WidgetsFlutterBinding.ensureInitialized();
  if (initialMessage != null) {
    print("App opened from terminated state via notification");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!isNotificationHandled) {
        isNotificationHandled = true;
        _handleNotification(initialMessage);
      }
    });
  }

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    if (!isNotificationHandled) {
      isNotificationHandled = true;
      _handleNotification(message);
    }
  });
}

void _handleNotification(RemoteMessage message) {
  print("Notification tapped");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Greenr',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        scaffoldBackgroundColor: CustomColors().snow_white,
        useMaterial3: true,
      ),
      home: MainPage(),
    );
  }
}
