import '../../../../libs.dart';

class HistoricalCategoryModel {
  String? categoryName;

  List<HistoricalModel>? historicalModel;
  String? text;
  String? year;
  bool? isAlternative;
  List<PagesModel>? pages;

  HistoricalCategoryModel.fromJson(
    String category,
    List  events,
  ) {
    try {
      categoryName = category;
      historicalModel ??= [];
      events
          .map((e) =>
              historicalModel!.add(HistoricalModel.fromJson(e, category)))
          .toList();
      globalPrint("model inside ${historicalModel!.length}");
    } catch (e, s) {
      globalPrint("error inside alternativeModel$e $s");
    }
  }

  HistoricalCategoryModel.fromJson2(Map json) {
    text = json['text'];
    year = json['year'].toString();
    pages ??= [];
    isAlternative = true;

    json["pages"].map((e) => pages!.add(PagesModel.fromJson(e))).toList();
    globalPrint("pages length ${pages!.length}");
  }
}

class HistoricalModel {
  String? year;
  String? text;
  String? html;
  String? categoryName;
  String? noYearHtml;
  List<HistoricalLinkModel>? historicalLink;

  HistoricalModel.fromJson(Map json, String? category) {
    try {
      year = json["year"];
      text = json["text"];
      html = json["html"];
      noYearHtml = json["no_year_html"];
      historicalLink ??= [];
      categoryName = category;
      json["links"]
          .map((e) => historicalLink!.add(HistoricalLinkModel.fromJson(e)))
          .toList();
    } catch (e, s) {
      globalPrint("error $e $s");
    }
  }
}

class HistoricalLinkModel {
  String? title;
  String? link;

  HistoricalLinkModel.fromJson(Map json) {
    globalPrint("title isnide HistoricalLinkModel$json");
    title = json['title'];
    link = json['link'];
  }
}

class PagesModel {
  String? type;
  String? displayTitle;
  String? imagePath;
String?description;
  String? extractHtml;
  String? url;
 double ?height;
  double ?width;
  PagesModel.fromJson(Map json) {
    type = json['type'];
    displayTitle = json['displaytitle'];

    if (json['thumbnail'] != null) {
      imagePath = json['thumbnail']['source'];
      if(json['thumbnail']['height']!=null) {
        height = double.parse(json['thumbnail']['height'].toString());
      }
      if(json['thumbnail']['width']!=null) {
        width =double.parse( json['thumbnail']['width'].toString());
      }
    }
    description=json['description'];
    extractHtml = json['extract_html'];
    if (json["content_urls"] != null &&
        json["content_urls"]['mobile'] != null) {
      url = json["content_urls"]['mobile']['page'];
    }
  }
}
