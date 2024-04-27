import '../../../../libs.dart';

class HistoricalCategoryModel
{
  String? categoryName;

  List<HistoricalModel>?historicalModel;
  HistoricalCategoryModel.fromJson(String category,List events)
  {

    categoryName=category;
    historicalModel ??= [];
    events.map((e) => historicalModel!.add(HistoricalModel.fromJson(e,category))).toList();
    globalPrint("model inside ${historicalModel!.length}");
  }
}
class HistoricalModel
{

  String ?year;
  String?text;
  String ?html;
  String?categoryName;
  String? noYearHtml;
  List<HistoricalLinkModel> ? historicalLink;
  HistoricalModel.fromJson(Map json,String ?category)
  {
    try{
      year = json["year"];
      text = json["text"] ;
      html = json["html"];
      noYearHtml = json["no_year_html"];
      historicalLink ??= [];
      categoryName=category;
      json["links"]
          .map((e) => historicalLink!.add(HistoricalLinkModel.fromJson(e))).toList();
    }catch(e,s)
    {
      globalPrint("error $e $s");
    }
  }

}
class HistoricalLinkModel
{
  String?title;
  String?link;
  HistoricalLinkModel.fromJson(Map json)
  {
    globalPrint("title isnide HistoricalLinkModel$json");
    title=json['title'];
    link=json['link'];
  }
}