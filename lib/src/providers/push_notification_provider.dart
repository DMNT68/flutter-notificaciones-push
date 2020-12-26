import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';

/*  
d3EwGWpoQvm5rFlCrJLr_n:APA91bGW9WqNQs6AZVa49EY7ZznlY-0S1BgO8izP_MVsIJV8kc_0sWShOjZBHtOcQX9x51xDbinU4l3MWlTzAT9cjoWemgjccCRuudH296YibvOYZQwknrvPxISzU6MOBUESLCaW2gbS

*/

class PushNotificationProvider {

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final _mensajesStreamController = new StreamController<String>.broadcast();
  
  Stream<String> get mensajesStream => _mensajesStreamController.stream;

  static Future<dynamic> onBackgroundMessage(Map<String, dynamic> message) async {
    if (message.containsKey('data')) {
      // Handle data message
      final dynamic data = message['data'];
    }

    if (message.containsKey('notification')) {
      // Handle notification message
      final dynamic notification = message['notification'];
    }

    // Or do other work.
  }

  initNotifications() async {

    await _firebaseMessaging.requestNotificationPermissions();
    final token = await _firebaseMessaging.getToken();

    print('======= FCM TOKEN ==========');
    print(token);


    _firebaseMessaging.configure(
      onMessage: onMessage,
      onBackgroundMessage: onBackgroundMessage,
      onLaunch: onLaunch,
      onResume: onResume,
    );

  }


  Future<dynamic> onMessage(Map<String, dynamic> message) async {
    print('======onMessage=======');
    // print(message);
    // print('argumento: $argumento');
    final argumento = message['data']['Comida'] ?? 'No Data';
    _mensajesStreamController.sink.add(argumento);
  }

  Future<dynamic> onLaunch(Map<String, dynamic> message) async {
    print('======onLaunch=======');
    // print(message);
    // print('argumento: $argumento');
    final argumento = message['data']['Comida'] ?? 'No Data';
    _mensajesStreamController.sink.add(argumento);

  }

  Future<dynamic> onResume(Map<String, dynamic> message) async {
    print('======onResume=======');
    // print(message);
    // print('argumento: $argumento');
    final argumento = message['data']['Comida'] ?? 'No Data';
    _mensajesStreamController.sink.add(argumento);

  }

  dispose() {
    _mensajesStreamController?.close();
  }

}