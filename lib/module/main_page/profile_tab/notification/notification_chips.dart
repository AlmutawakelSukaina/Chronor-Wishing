import '../../../../libs.dart';



class CustomFilterChips extends StatelessWidget {
  final String text;
  final int index;
  final ValueNotifier<int> currentIndex;
  final Function setAlarm;
  const CustomFilterChips({
    super.key,
    required this.text,
    required this.index,
    required this.currentIndex, required this.setAlarm,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: currentIndex,
        builder: (BuildContext context, value, _) {
          return FilterChip(
            backgroundColor: AppColors.white,
            disabledColor: AppColors.white,
            selectedColor: AppColors.white,
            checkmarkColor: AppColors.orange,
            shape:
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0), // Change the border radius as needed
              side: const BorderSide(style: BorderStyle.none, ),
            ),


            surfaceTintColor: AppColors.white,
            label: SizedBox(
                width: Responsive.fullWidth(context),
                child: CustomTextApp(
                  text: text,
                  size: 5,
                )),
            selected: value == index,
            onSelected: (bool value) {
              const storage = FlutterSecureStorage();
              storage.write(key: prefNotificationSetting, value: index.toString());
              currentIndex.value = index;
              setAlarm(index);
            },
          );
        });
  }
}
