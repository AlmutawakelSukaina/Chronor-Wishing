import '../../libs.dart';

class AppModel extends ChangeNotifier {
  String local = 'en';

  bool darkTheme = false;



  void changeLanguage(
      {
        required String languageCode }) {

    local = languageCode;

    notifyListeners();
  }}
