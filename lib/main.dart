import 'package:firebase_core/firebase_core.dart';
import 'package:timezone/data/latest_all.dart' as tz;

import 'firebase_options.dart';
import 'libs.dart';



void main() async {

  ServiceLocator().init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,


  );

  // try {
  //   await SharedPrefsHelper.init();
  //
  // }catch(e)
  // {
  //  }



    NotificationService().initNotification();

  // await initializeTimeZone();
  tz.initializeTimeZones();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor:AppColors.orange,
    statusBarBrightness: Brightness.dark,
  ));

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(
      const MainApp(),
    );
  });
}


