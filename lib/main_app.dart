

import 'dart:ui';


import 'libs.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  Widget materialApp() => ChangeNotifierProvider.value(
      value: sl<AppModel>(),
      child: Consumer<AppModel>(
        builder: (context, model, child) {


          return MultiProvider(
            providers: [

              ChangeNotifierProvider(
                create: (context) => sl<AppModel>(),
              ),
              ChangeNotifierProvider(
                create: (context) => sl<SignUpProvider>(),
              ),
            ],
            child:  MaterialApp(

          navigatorKey: AppRouter.navigatorKey,
              title: "Chrono Wishing",
              theme: theme,
              scrollBehavior: const MaterialScrollBehavior().copyWith(
                dragDevices: {PointerDeviceKind.mouse, PointerDeviceKind.touch, PointerDeviceKind.stylus, PointerDeviceKind.unknown},
              ),
              debugShowCheckedModeBanner: false,


              onGenerateRoute: AppRouterGenerator.generateRoute,
              locale: Locale(
                Provider.of<AppModel>(context).local,
              ),

            ),
          );
        },
      ));

  @override
  Widget build(BuildContext context) {
    return materialApp();
  }
}
bool initialize=false;
class AppRouter {
  //route with out context logout
  static final navigatorKey = GlobalKey<NavigatorState>();


}