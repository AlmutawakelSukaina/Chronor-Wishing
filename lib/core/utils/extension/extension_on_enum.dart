import '../../../libs.dart';

extension EmptyPadding on num {
  SizedBox get ph => SizedBox(
      height: Responsive.width(AppRouter.navigatorKey.currentContext!) *
          toDouble());

  SizedBox get pw => SizedBox(
      width: Responsive.width(AppRouter.navigatorKey.currentContext!) *
          toDouble());
}
