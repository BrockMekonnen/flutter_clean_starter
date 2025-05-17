// import 'package:flutter/foundation.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:remote_sera/_core/container.dart';
// import 'package:universal_html/html.dart' as html;

// int id = 0;

// class LocalNotification {
//   @pragma('vm:entry-point')
//   void notificationTapBackground(NotificationResponse notificationResponse) {
//     // ignore: avoid_print
//     print('notification(${notificationResponse.id}) action tapped: '
//         '${notificationResponse.actionId} with'
//         ' payload: ${notificationResponse.payload}');
//     if (notificationResponse.input?.isNotEmpty ?? false) {
//       // ignore: avoid_print
//       print('notification action tapped with input: ${notificationResponse.input}');
//     }
//   }

//   static void init() {
//     final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//         FlutterLocalNotificationsPlugin();
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('@mipmap/ic_launcher');

//     InitializationSettings initializationSettings = const InitializationSettings(
//       android: initializationSettingsAndroid,
//     );

//     flutterLocalNotificationsPlugin.initialize(initializationSettings);
//     di.registerLazySingleton(() => flutterLocalNotificationsPlugin);
//   }
// }

// Future<bool> isNotificationPermissionGranted() async {
//   if (defaultTargetPlatform == TargetPlatform.android) {
//     final bool granted = await di<FlutterLocalNotificationsPlugin>()
//             .resolvePlatformSpecificImplementation<
//                 AndroidFlutterLocalNotificationsPlugin>()
//             ?.areNotificationsEnabled() ??
//         false;
//     return granted;
//   } else if (kIsWeb) {
//     if (html.Notification.permission == 'granted') {
//       return true;
//     } else {
//       return false;
//     }
//   } else {
//     return false;
//   }
// }

// Future<void> requestNotificationPermissions() async {
//   if (defaultTargetPlatform == TargetPlatform.iOS) {
//     await di<FlutterLocalNotificationsPlugin>()
//         .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
//         ?.requestPermissions(alert: true, badge: true, sound: true);
//   } else if (defaultTargetPlatform == TargetPlatform.android) {
//     final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
//         di<FlutterLocalNotificationsPlugin>().resolvePlatformSpecificImplementation<
//             AndroidFlutterLocalNotificationsPlugin>();

//     await androidImplementation?.requestPermission();
//   } else if (kIsWeb) {
//     await html.Notification.requestPermission();
//   }
// }

// Future<void> showNotification(String title, String body) async {
//   if (kIsWeb) {
//     html.Notification(title, body: body);
//   } else {
//     const AndroidNotificationDetails androidNotificationDetails =
//         AndroidNotificationDetails('your channel id', 'your channel name',
//             importance: Importance.max, priority: Priority.high, ticker: 'ticker');
//     const NotificationDetails notificationDetails =
//         NotificationDetails(android: androidNotificationDetails);
//     await di<FlutterLocalNotificationsPlugin>()
//         .show(id++, title, body, notificationDetails);
//   }
// }
