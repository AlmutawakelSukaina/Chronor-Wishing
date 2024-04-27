import '../../../../libs.dart';

class HistoricalDetails extends StatelessWidget {
  final HistoricalModel historicalModel;

  const HistoricalDetails({
    super.key,
    required this.historicalModel,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: customAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomDetailsTitle(text: "Year: ${historicalModel.year}"),
            2.ph,
            CustomTextApp(
              text: historicalModel.text,
              size: 4.5,
              italic: true,
            ).fullSizeWidth().containerWithBorderSide(AppColors.colorsEvent[0]),
            2.ph,
            CustomHtml(
              data: historicalModel.html!,
              color: AppColors.colorsEvent[2],
            ),
            2.ph,
            CustomHtml(
              data: historicalModel.noYearHtml!,
              color: AppColors.colorsEvent[3],
            ),
            4.ph,
            const CustomDetailsTitle(text: "links"),
            2.ph,
            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: historicalModel.historicalLink!.length,
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextApp(
                        text:
                            "${index + 1}- ${historicalModel.historicalLink![index].title}",
                        size: 5,
                        italic: true,
                      ).fullSizeWidth(),
                      CustomTextApp(
                        text: historicalModel.historicalLink![index].link,
                        size: 4,
                        colors: Colors.blue,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.blue,
                        thickness: 1,
                      ).onTap(() {
                        launchUrl(Uri.parse(
                            historicalModel.historicalLink![index].link!));
                      })
                    ],
                  ).symmetricPadding(2, 2);
                })
          ],
        ).symmetricPadding(4, 4),
      ),
    ));
  }
}

class CustomDetailsTitle extends StatelessWidget {
  final String text;

  const CustomDetailsTitle({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return CustomTextApp(
      text: text,
      italic: true,
      size: 6,
      backgroundColor: Colors.orange[50],
    ).fullSizeWidth();
  }
}
