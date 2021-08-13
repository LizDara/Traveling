// SHA-1: F7:0D:61:36:C8:46:84:EE:97:3E:1D:89:59:A0:68:30:1A:12:B9:3C

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;

  static Future<dynamic> _backgroundHandler(RemoteMessage message) async {
    print('backgroud: ${message.messageId}');
  }

  static Future<dynamic> _onMessageHandler(RemoteMessage message) async {
    print('message handler: ${message.messageId}');
  }

  static Future<dynamic> _onMessageOpenApp(RemoteMessage message) async {
    print('message open app: ${message.messageId}');
  }

  static Future initializeApp() async {
    await Firebase.initializeApp();
    token = await messaging.getToken();
    print(token);

    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);
  }
}
