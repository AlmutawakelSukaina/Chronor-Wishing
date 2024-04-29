


import '../../../../libs.dart';

class HistoricalList extends StatelessWidget {
  final List<HistoricalModel>? historicalModel;
  final List<HistoricalCategoryModel>? alternative;
  final ValueNotifier<String?> searchText;
  const HistoricalList({
    super.key,
      this.historicalModel,
    required this.searchText, this.alternative,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: searchText,
        builder: (BuildContext context, String? value, _) {
          List  event = [];
          globalPrint("value inside historicalModel$historicalModel");
          globalPrint("value inside alternative$alternative");
          if (value != null && value.trim().isNotEmpty) {
            if(historicalModel!=null&&historicalModel!.isNotEmpty) {
              for (HistoricalModel data in historicalModel!) {
                if (data.text!.toLowerCase().contains(value.toLowerCase())) {
                  event.add(data);
                }
              }
            } else
              {
                for (HistoricalCategoryModel data in alternative!) {
                  if (data.text!.toLowerCase().contains(value.toLowerCase())) {
                    event.add(data);
                  }
                }
              }
          } else {
            event = historicalModel  ?? (alternative as List<HistoricalCategoryModel>);
            globalPrint("alternative  inside ${alternative}");

          }
          return CustomScrollView(slivers: <Widget>[
            if (event.isEmpty)
                SliverToBoxAdapter(
                child: Center(
                  child: const CustomTextApp(
                    text: "No Data",
                    size: 6,
                    italic: true,
                    font: FontWeight.normal,
                  ).symmetricPadding(2, 0),
                ),
              )
            else
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextApp(
                          text: event[index].text!,
                          size: 5,
                          italic: true,
                          maxLines: 3,
                          minLines: 3,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                        ),
                        const Align(
                          alignment: AlignmentDirectional.centerEnd,
                          child: Icon(
                            CupertinoIcons.forward,
                            color: Colors.grey,
                          ),
                        )
                      ],
                    ).containerWithBorderSide(
                        AppColors.colorsEvent[index % 5]).symmetricPadding(2, 4).onTap((){

                     if(alternative==null) {
                       context.pushPage(HistoricalDetails(
                         historicalModel: event[index],

                      ));
                     }else
                       {

                         context.pushPage(HistoricalBackUpDetails(
                           pages: event[index].pages ,
                         year: event[index].year,
                         ));
                       }
                    });
                  },
                  childCount: event.length, // Number of items in the list
                ),
              ),
            SliverToBoxAdapter(
              child: 20.ph,
            )
          ]);
        });
  }
}
