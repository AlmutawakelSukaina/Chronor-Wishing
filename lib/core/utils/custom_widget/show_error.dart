import '../../../libs.dart';
class ShowErrorText extends StatelessWidget {
  final ValueNotifier text;

  const ShowErrorText({super.key,  required this.text});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: text,
        builder: (BuildContext context, value, _) {
          return value!=null&&value.toString().trim().isNotEmpty?Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min
            ,
            children: [
              Icon(Icons.info_outline,
                color:AppColors.red,size: 11,),

              CustomTextApp(
                text: value,
                colors: AppColors.red,
                size: 3,
              ),
            ],
          ):const Nothing();

        });
  }
}

class ShowError extends StatelessWidget {
  final ValueNotifier error;
  final String text;
  const ShowError({super.key, required this.error, required this.text});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: error,
        builder: (BuildContext context, value, _) {
          return value?Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min
            ,
            children: [
              Icon(Icons.info_outline,
              color:AppColors.red,size: 11,),

              CustomTextApp(
                text: text,
                colors: AppColors.red,
                size: 3,
              ),
            ],
          ):const Nothing();

    });
  }
}
