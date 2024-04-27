import '../../../../libs.dart';

class HomeProvider extends BasedHttpRequests {
  Future<List<HistoricalCategoryModel>> getHistoricalEvent() async {
    const storage = FlutterSecureStorage();
    String? birthdate = await storage.read(key: prefBirthdate);
    DateTime? dateTime;
    if (birthdate != null) {
      int? data = int.tryParse(birthdate);
      if (data != null) {
        dateTime = DateTime.fromMillisecondsSinceEpoch(data);
      }
    }
    try {
      NetworkServiceResponse response = await getData(
          "https://history.muffinlabs.com/date/${dateTime?.month}/${dateTime?.day}");
      if (response.status == EnumStatus.complete) {

        Map categoryData = response.data["data"];

        storage.write(key: prefHistoricalEvent, value: jsonEncode(categoryData));
         return historicalEvent(categoryData);

      } else {
      String ?data=   await storage.read(key: prefHistoricalEvent);
      return data!=null?historicalEvent(jsonDecode(data)):[];
      }
    } catch (e) {
      String ?data=   await storage.read(key: prefHistoricalEvent);
      return data!=null?historicalEvent(jsonDecode(data)):[];
    }
  }

  List<HistoricalCategoryModel> historicalEvent(Map categoryData){
    List<HistoricalCategoryModel> historicalModel = [];
    categoryData.forEach((key, value) {
      historicalModel.add(HistoricalCategoryModel.fromJson(key, value));
    });
    return historicalModel;
  }
}
