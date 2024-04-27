

import '../../../../libs.dart';

class HistoricalList extends StatelessWidget {
  final List<HistoricalModel> historicalModel;
  final ValueNotifier<String?> searchText;
  const HistoricalList({
    super.key,
    required this.historicalModel,
    required this.searchText,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: searchText,
        builder: (BuildContext context, String? value, _) {
          List<HistoricalModel> event = [];
          globalPrint("value inside $value");
          if (value != null && value.trim().isNotEmpty) {
            for (HistoricalModel data in historicalModel) {
              if (data.text!.toLowerCase().contains(value.toLowerCase())) {
                event.add(data);
              }
            }
          } else {
            event = historicalModel;
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
                      context.pushPage(HistoricalDetails(
                         historicalModel: event[index],

                      ));
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
