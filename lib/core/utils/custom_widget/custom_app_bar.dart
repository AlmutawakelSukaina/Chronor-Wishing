import '../../../libs.dart';

AppBar customAppBar({VoidCallback? backFun}) {
  return AppBar(
    surfaceTintColor: AppColors.backgroundColor,
    backgroundColor: AppColors.backgroundColor,
    iconTheme: IconThemeData(
        color: AppColors.orange,
        size: Responsive.width(AppRouter.navigatorKey.currentContext!) * 8),
    leading: IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        if (backFun != null) {
          backFun();
        } else {
          AppRouter.navigatorKey.currentContext!.pop();
        }
      },
    ),
  );
}
