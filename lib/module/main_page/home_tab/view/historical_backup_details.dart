 import '../../../../libs.dart';

class HistoricalBackUpDetails extends StatefulWidget {
  final List<PagesModel> pages;
  final String year;
  const HistoricalBackUpDetails({
    super.key,
    required this.pages, required this.year,
  });

  @override
  State<HistoricalBackUpDetails> createState() =>
      _HistoricalBackUpDetailsState();
}

class _HistoricalBackUpDetailsState extends State<HistoricalBackUpDetails> {
  late PageController pageController;
  double pageOffset = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController(viewportFraction: 0.8);
    pageController.addListener(() {
      setState(() => pageOffset = pageController.page!);
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: customAppBar(),
        body: PageView.builder(
            controller: pageController,
            itemCount: widget.pages.length,
            itemBuilder: (BuildContext context, int index) {
              return HistoricalData(
                pagesModel: widget.pages[index],
                year:widget.year,
              );
            }),
      ),
    );
  }
}

class HistoricalData extends StatelessWidget {
  final PagesModel pagesModel;
  final String year;
  const HistoricalData({
    super.key,
    required this.pagesModel, required this.year,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CustomDetailsTitle(text: "Year: $year"),

          1.ph,
          if (pagesModel.imagePath != null)
            CachedNetworkImage(
              imageUrl: pagesModel.imagePath!,

              width:pagesModel.width ??Responsive.fullWidth(context),
              height:pagesModel.height ?? Responsive.height(context)*30,
                fit:BoxFit.fitHeight,

              progressIndicatorBuilder: (context, url, downloadProgress) =>
              const LoadingIndicator(),
              errorWidget: (context, url, error) => const LoadingIndicator(),
            ),

           if(pagesModel.displayTitle!=null)
          CustomHtml(
            data: pagesModel.displayTitle!,
            isCard: false,
            fontWeight: FontWeight.bold,
          ),
           CustomTextApp(text: pagesModel.description,
          size: 4,italic: true,
          ).fullSizeWidth(),
           if(pagesModel.extractHtml!=null)

            CustomHtml(
            data: pagesModel.extractHtml!,

            isCard: false,
          ),

          if(pagesModel.url!=null)
          CustomTextApp(
            text:  pagesModel.url,
            size: 4,
            colors: Colors.blue,
            decoration: TextDecoration.underline,
            decorationColor: Colors.blue,
            thickness: 1,
          ).onTap(() {
            launchUrl(Uri.parse(
              pagesModel.url!,));
          }),
          6.ph
        ],
      ),
    );
  }
}
