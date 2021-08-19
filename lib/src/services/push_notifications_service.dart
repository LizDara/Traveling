// SHA-1: F7:0D:61:36:C8:46:84:EE:97:3E:1D:89:59:A0:68:30:1A:12:B9:3C

import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;
  static StreamController<Map<String, dynamic>> _messageStream =
      new StreamController.broadcast();
  static Stream<Map<String, dynamic>> get messageStream =>
      _messageStream.stream;

  static Future<dynamic> _backgroundHandler(RemoteMessage message) async {
    _messageStream.add(message.data);
  }

  static Future<dynamic> _onMessageHandler(RemoteMessage message) async {
    _messageStream.add(message.data);
  }

  static Future<dynamic> _onMessageOpenApp(RemoteMessage message) async {
    _messageStream.add(message.data);
  }

  static Future initializeApp() async {
    await Firebase.initializeApp();
    token = await messaging.getToken();

    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);
  }

  static closeStreams() {
    _messageStream.close();
  }
}
