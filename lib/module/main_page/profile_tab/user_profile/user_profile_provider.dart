
import '../../../../libs.dart';

class UserProfile {


  Future<void> updateUser(String? userId,Map<String, dynamic> newData) async {
    try {
        sl<SignUpProvider>().setLoading(true);
      await FirebaseFirestore.instance.collection('users').doc(userId).update(
          newData);
        sl<SignUpProvider>().setLoading(false);

        AppRouter.navigatorKey.currentContext!.showAppDialog(
            message: "Your changes have been saved and will be retained even after logging out and logging back in.", title: "Success",
           cancelButton: (){
             AppRouter.navigatorKey.currentContext!.pop();
           },onTapSuccess: (){
          AppRouter.navigatorKey.currentContext!.pop();
          AppRouter.navigatorKey.currentContext!.pushReplacementName(AppRoutes.signIn);
        },successTitle: "Logout",cancelButtonTitle:"Cancel"




        );


    } catch (e) {
      sl<SignUpProvider>().setLoading(false);

      AppRouter.navigatorKey.currentContext!.showAppDialog(
          message: e.toString(), title: "Error");
    }
  }
}
