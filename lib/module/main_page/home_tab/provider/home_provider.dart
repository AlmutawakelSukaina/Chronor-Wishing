import '../../../../libs.dart';

class HomeProvider extends BasedHttpRequests {
  Future<List<HistoricalCategoryModel>> getHistoricalEvent({
    bool? backup,
  }) async {
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
      NetworkServiceResponse response = await getData(backup == true
          ? "https://en.wikipedia.org/api/rest_v1/feed/onthisday/events/${dateTime?.month}/${dateTime?.day}"
          : "https://history.muffinlabs.com/date/${dateTime?.month}/${dateTime?.day}");
      if (response.status == EnumStatus.complete) {
        dynamic categoryData =
            response.data[backup == true ? "events" : "data"];

        storage.write(
            key: prefHistoricalEvent, value: jsonEncode(categoryData));
        return backup == true
            ? alternativeHistoricalEvent(categoryData)
            : historicalEvent(categoryData);
      } else {
        if (backup == null) {
          return await getHistoricalEvent(backup: true);
        } else {
          String? data = await storage.read(key: prefHistoricalEvent);
          return data != null ? historicalEvent(jsonDecode(data)) : [];
        }
      }
    } catch (e, s) {
      globalPrint("error inside $e $s");
      if (backup == null) {
        return await getHistoricalEvent(backup: true);
      } else {
        String? data = await storage.read(key: prefHistoricalEvent);
        return data != null ? historicalEvent(jsonDecode(data)) : [];
      }
    }
  }

  List<HistoricalCategoryModel> historicalEvent(Map categoryData) {
    List<HistoricalCategoryModel> historicalModel = [];
    categoryData.forEach((key, value) {
      historicalModel.add(HistoricalCategoryModel.fromJson(key, value));
    });
    return historicalModel;
  }

  List<HistoricalCategoryModel> alternativeHistoricalEvent(List categoryData) {
     List<HistoricalCategoryModel> alternativeEvent = [];
    for (Map data in categoryData) {
      alternativeEvent.add(HistoricalCategoryModel.fromJson2(data));
    }
     return alternativeEvent;
  }
}
