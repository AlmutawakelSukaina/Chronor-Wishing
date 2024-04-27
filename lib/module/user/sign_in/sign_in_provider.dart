
import '../../../libs.dart';

class SignInProvider
{

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      sl<SignUpProvider>().setLoading(true);
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      sl<SignUpProvider>().setLoading(false);
      const storage =   FlutterSecureStorage();
      Map<String, dynamic>? data=await  getUserDataFromFireStore( userCredential.user!.uid);

      storage.write(key: prefUserId, value: userCredential.user!.uid);
      storage.write(key: prefSignedIn, value: "true");
      storage.write(key: prefUserName, value:data!['name']);
      storage.write(key: prefBirthdate, value: data['birthdate'].toString());
      storage.write(key: "$prefNotificationSetting$prefUserId", value:"1");
      setAlarm(DateTime.fromMillisecondsSinceEpoch(int.parse(data['birthdate'].toString())),  data['name'], userCredential.user!.uid);
      AppRouter.navigatorKey.currentContext!.pushReplacementName(AppRoutes.mainPage);
    } catch (e,s) {
      globalPrint("error inside $e $s");
      sl<SignUpProvider>().setLoading(false);
      AppRouter.navigatorKey.currentContext!.showAppDialog(message: e.toString(),title: "Error");

    }
  }
  Future<Map<String, dynamic>?> getUserDataFromFireStore(String userId) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection('users').doc(userId).get();
    return snapshot.data();
  }
}