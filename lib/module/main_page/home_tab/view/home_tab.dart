import 'package:flutter/cupertino.dart';

import '../../../../libs.dart';

class HomePage extends StatefulWidget {
  final Future<List<HistoricalCategoryModel>>? responseHistoricalEvent;

  const HomePage({
    super.key,
    this.responseHistoricalEvent,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin<HomePage> {
  final searchText = ValueNotifier<String?>(null);

  @override
  void dispose() {
    searchText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Material(
      color: Colors.grey[50],
      child: FutureBuilder<List<HistoricalCategoryModel>?>(
        future: widget.responseHistoricalEvent,
        builder: (context, snapshot) {
          globalPrint("inside responseHistoricalEvent ${snapshot.data}");
          if (snapshot.connectionState == ConnectionState.waiting ||
              !snapshot.hasData) {
            return const LoadingIndicator();
          } else if (snapshot.data == null || snapshot.data!.isEmpty) {
            return const CustomTextApp(
              text: "No Data",
            );
          } else {
            int length = snapshot.data!.length;
            bool? isAlternative = snapshot.data?[0].isAlternative;
            return !(isAlternative ?? false)
                ? DefaultTabController(
                    length: length,
                    child: Column(
                      children: [
                        customSearch(),
                        Container(
                          color: AppColors.white,
                          child: TabBar(
                            labelColor: AppColors.white,
                            unselectedLabelColor: Colors.grey,
                            dividerColor: AppColors.white,
                            labelStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: appFont,
                                color: AppColors.white),
                            indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.orange[50],
                            ),
                            tabs: [
                              for (HistoricalCategoryModel category
                                  in snapshot.data!)
                                Tab(
                                  child: CustomTextApp(
                                    text: category.categoryName,
                                    size: 5,
                                  ).symmetricPadding(0, 5),
                                ),
                            ],
                          ),
                        ),
                        2.ph,
                        Expanded(
                          child: TabBarView(
                            children: [
                              for (HistoricalCategoryModel category
                                  in snapshot.data!)
                                HistoricalList(
                                  historicalModel:
                                      category.historicalModel ?? [],
                                  searchText: searchText,
                                ),
                            ],
                          ),
                        ),
                      ],
                    ))
                : Column(
                    children: [
                      customSearch(),
                      Expanded(
                        child: HistoricalList(
                          alternative: snapshot.data,
                          searchText: searchText,
                        ),
                      ),
                    ],
                  );
          }
        },
      ),
    );
  }

  Widget customSearch() {
    return CustomTextField(
      hint: "Search",
      fillColor: Colors.white,
      suffixIcon: Icon(
        Icons.search,
        color: AppColors.orange,
      ),
      onChange: (String? value) {
        searchText.value = value;
      },
    ).symmetricPadding(2, 4);
  }

  @override
  bool get wantKeepAlive => true;
}
