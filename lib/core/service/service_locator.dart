






import '../../libs.dart';

final sl = GetIt.instance;

class ServiceLocator {
  void init() {
    sl.registerLazySingleton(() => AppModel());
    sl.registerLazySingleton(() => SignUpProvider());
    sl.registerLazySingleton(() => SignInProvider());
    sl.registerLazySingleton(() => HomeProvider());
    sl.registerLazySingleton(() => UserProfile());


  }
}
