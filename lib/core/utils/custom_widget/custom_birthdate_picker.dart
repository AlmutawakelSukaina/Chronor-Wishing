
import '../../../libs.dart';

class CustomBirthDatePicker extends StatelessWidget
{
  final ValueNotifier<DateTime?>birthDate;
  final ValueNotifier<bool>showBirthDateError;
  const CustomBirthDatePicker({super.key, required this.birthDate, required this.showBirthDateError});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: birthDate,
        builder: (BuildContext context, value, _) {
          return Row(
            children: [
              Icon(
                Icons.arrow_drop_down,
                color: AppColors.orange,
                size: Responsive.width(context) * 6,
              ).symmetricPadding(1, 0),
              CustomTextApp(
                text: value != null
                    ? "${value.day.toString()}-${value.month.toString()}-${value.year.toString()}"
                    : "BirthDate",
                textAlign: TextAlign.start,
                colors: value != null ? null : Colors.grey[600],
                size: value != null ? 3.5 : 3,
              ).symmetricPadding(0, 0.5),
            ],
          )
              .symmetricPadding(1.8, 0)
              .roundedWidget(
            color: AppColors.white,
          )
              .onTap(() {
            context.showDatePicker(
                onConfirm: (DateTime dateTime) {
                  birthDate.value = dateTime;
                  showBirthDateError.value = false;
                });
          });
        });
  }

}