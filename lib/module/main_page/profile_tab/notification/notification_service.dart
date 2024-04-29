

import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../../../../libs.dart';
import '../../../../main.dart';


class NotificationService {
  static final NotificationService _notificationService =
  NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  NotificationService._internal();

  Future<void> initNotification() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@drawable/notification');
    final  DarwinInitializationSettings initializationSettingsDarwin=DarwinInitializationSettings(
        onDidReceiveLocalNotification:onDidReceiveLocalNotification
    );
    InitializationSettings initializationSettings =
    InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,

    );

    if(Platform.isAndroid) {
      flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();
    }
    await flutterLocalNotificationsPlugin.initialize(initializationSettings
     );
  }
  void onDidReceiveLocalNotification(int id, String?title,String ?body,String? payload)
  {
    NotificationService().showNotification(
        id,
        title!,
        body!, 5);
  }
  Future<void> showNotification(
      int id, String title, String body, int seconds) async {
    await flutterLocalNotificationsPlugin.show(
        id,
        title,
        body,
        const NotificationDetails(
          android: AndroidNotificationDetails('main_channel', 'Main Channel',
              importance: Importance.max,
              priority: Priority.max,
              icon: '@drawable/notification'),
        ));

  }

  Future<tz.TZDateTime> _convertTime(DateTime date) async {
    final String timeZone = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZone));
    globalPrint("start ${date.year}");
    globalPrint("start ${date.month}");
    globalPrint("start ${date.day}");
    globalPrint("start ${date.hour}");
    globalPrint("start ${date.minute}  ${timeZone}");
    DateTime currentTime=DateTime.now();
     int year=currentTime.year;
    if((date.month>currentTime.month)&&(date.day>currentTime.day))
      {
        year=currentTime.year;
      }else
        {
          year=currentTime.year+1;
        }

    tz.TZDateTime scheduleTime2 = tz.TZDateTime(tz.getLocation(timeZone),
      year, date.month, date.day,9,  );
    return scheduleTime2;
  }



  Future<void> scheduleNotification(int id, String title, String body,
      DateTime startDate, ) async {
    globalPrint(" inside start date $startDate");
    tz.initializeTimeZones();
    final timeZone = await _convertTime(startDate);
    globalPrint("timeZone  $timeZone");

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      "🎉🥳HAPPY BIRTHDAY🥳🎉",
      body,
      timeZone,
      const NotificationDetails(
        android: AndroidNotificationDetails('main_channel', 'Main Channel',
            importance: Importance.max,
            priority: Priority.max,
            icon: '@drawable/notification'),
      ),
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
    );
  }



  Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }
}
