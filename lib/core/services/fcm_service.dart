import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dio/dio.dart' as dio;

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}

class FCMService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final _storage = const FlutterSecureStorage();
  final String _apiUrl = 'https://neura-be.onrender.com/auth/fcm-token';

  Future<void> initNotifications() async {
    NotificationSettings settings = await _firebaseMessaging
        .requestPermission();

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("✅ FCM: User granted permission");

      final fcmToken = await _firebaseMessaging.getToken();

      print("🔑 YOUR FCM TOKEN: $fcmToken");
      print("🔗 Full Token: ${fcmToken ?? 'Null - Check Firebase setup'}");
      await _sendTokenToServer(fcmToken);

      _firebaseMessaging.onTokenRefresh.listen(_sendTokenToServer);
      const AndroidInitializationSettings initializationSettingsAndroid =
          AndroidInitializationSettings('@mipmap/ic_launcher');
      const DarwinInitializationSettings initializationSettingsIOS =
          DarwinInitializationSettings();
      const InitializationSettings initializationSettings =
          InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS,
          );
      await flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: _onNotificationTapped,
      );

      _setupMessageListeners();
    } else {
      print("❌ FCM: User declined or has not accepted permission");
    }
  }

  void _setupMessageListeners() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('📱 FCM: Got a message whilst in the foreground!');
      if (message.notification != null) {
        _showLocalNotification(message);
      }
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('📱 FCM: Got a message whilst in the foreground!');
      if (message.notification != null) {
        print(
          'Message also contained a notification: ${message.notification!.title}',
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('👉 FCM: User tapped notification from background');
      _handleNotificationNavigation(message.data);
    });
  }

  Future<void> _showLocalNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
          'high_importance_channel', // Channel ID
          'High Importance Notifications', // Title
          channelDescription:
              'This channel is used for important notifications.',
          importance: Importance.max,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher',
        );
    const DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails();
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      0, // ID
      message.notification?.title ?? 'New Message',
      message.notification?.body ?? '',
      platformChannelSpecifics,
      payload: jsonEncode(message.data),
    );
  }

  void _handleNotificationNavigation(Map<String, dynamic> data) {
    final conversationId = data['conversationId'];
    if (conversationId != null) {
      print('Navigating to conversation: $conversationId');

      // navigatorKey.currentState?.pushNamed('/chat', arguments: conversationId);
    }
  }

  void _onNotificationTapped(NotificationResponse notificationResponse) {
    final data = jsonDecode(notificationResponse.payload ?? '{}');
    _handleNotificationNavigation(data);
  }

  /// Gửi FCM token lên backend server.
  Future<void> _sendTokenToServer(String? token) async {
    if (token == null) {
      print('FCM Token is null, not sending to server.');
      return;
    }

    final userAuthToken = await _storage.read(key: 'token');
    if (userAuthToken == null) {
      print('User is not logged in. Cannot send FCM token.');
      return;
    }

    print('Sending FCM token to server using Dio...');
    try {
      final client = dio.Dio();
      await client.post(
        _apiUrl,
        data: {'fcmToken': token},
        options: dio.Options(
          headers: {
            'Authorization': 'Bearer $userAuthToken',
            'Content-Type': 'application/json',
          },
        ),
      );
      print('✅ FCM Token sent to server successfully.');
    } on dio.DioException catch (e) {
      print('❌ Error sending FCM token to server: $e');
      if (e.response != null) {
        print('Response data: ${e.response?.data}');
      }
    }
  }
}
