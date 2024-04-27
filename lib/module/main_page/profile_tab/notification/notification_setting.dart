import 'package:timezone/timezone.dart' as tz;

import '../../../../libs.dart';

class NotificationAlarm extends StatefulWidget {
  const NotificationAlarm({
    super.key,
  });

  @override
  State<NotificationAlarm> createState() => _NotificationAlarmState();
}

class _NotificationAlarmState extends State<NotificationAlarm> {
  Future? userData;
  final storage = const FlutterSecureStorage();
  final selectedIndex = ValueNotifier<int>(1);
  String? location, birthDay, name,userId;
   void setSelectedIndex()async
   {
     userId= await storage.read(key: prefUserId) ;
    String index= await storage.read(key: prefNotificationSetting) ??"1";
     selectedIndex.value=int.parse(index);
   }
  void getUserData()   {

    userData = Future.wait([
      storage.read(key: prefUserName),
      storage.read(key: prefBirthdate),

    ]);
  }

  Future<String> timeZone() async {
    final String currentTimeZone =
        await FlutterNativeTimezone.getLocalTimezone();
    location = currentTimeZone;
    tz.TZDateTime.now(tz.getLocation(location!));
    return location!;
  }

  @override
  void initState() {
    timeZone();
    getUserData();setSelectedIndex();

    super.initState();
  }

  @override
  void dispose() {
    selectedIndex.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: customAppBar(),
        body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
                vertical: Responsive.height(context) * 4,
                horizontal: Responsive.width(context) * 4),
            child: FutureBuilder(
                future: userData,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    name = snapshot.data[0];
                    birthDay = snapshot.data[1];


                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomTextApp(
                          text: "🎉 Celebration Reminder! 🎉",
                          size: 6,
                          backgroundColor: Colors.orange[50],
                          italic: true,
                        ),
                        7.ph,
                        CustomFilterChips(
                          text: 'None',
                          index: 0,
                          currentIndex: selectedIndex,
                          setAlarm: confirmFun,
                        ),
                        8.ph,
                        CustomFilterChips(
                          text: 'On your birthday (9AM)',
                          index: 1,
                          currentIndex: selectedIndex,
                          setAlarm: confirmFun,
                        ),
                        CustomFilterChips(
                          text: 'Two days before your birthday (9AM)',
                          index: 2,
                          currentIndex: selectedIndex,
                          setAlarm: confirmFun,
                        ),
                        CustomFilterChips(
                          text: 'One week before your birthday (9AM)',
                          index: 3,
                          currentIndex: selectedIndex,
                          setAlarm: confirmFun,
                        ),
                      ],
                    );
                  } else {
                    return const LoadingIndicator();
                  }
                })),
      ),
    );
  }

  void confirmFun(int index) async {
    if (await Permission.notification.request().isGranted) {
      int userBirthDay=int.parse(birthDay??"0");
      if (index == 0) {
        NotificationService().cancelNotification(1);
      } else if (index == 1) {
        setAlarm( DateTime.fromMillisecondsSinceEpoch(userBirthDay),name,userId);
      } else if (index == 2) {
        setAlarm( DateTime.fromMillisecondsSinceEpoch(userBirthDay).subtract(const
        Duration(days: 2)),name,userId);
      } else if (index == 3) {

        setAlarm( DateTime.fromMillisecondsSinceEpoch(userBirthDay).subtract(const
        Duration(days: 7)),name,userId);

      }
    }
  }


}
void setAlarm(DateTime dataTime,String? name,String ?id) async {

  await NotificationService().scheduleNotification(
   int.tryParse(id??"0")??0,
    "🎉 Happy Birthday ${name??""}! 🎉",
    "Wishing you a day filled with love, laughter,"
        " and unforgettable moments! May this special day bring you all the joy and happiness you deserve."
        " Enjoy every moment and cherish every smile."
        " Have a fantastic birthday celebration!Best wishes,",
    dataTime,
  );
}