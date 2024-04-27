
import '../../../libs.dart';

class SignUpProvider with ChangeNotifier
{
bool loading=false;
void setLoading(bool register)
{
  loading=register;
  notifyListeners();
}


// Sign up with email and password
  Future<void> signUpWithEmailAndPassword(String name,int birthdate,String email,String password) async {
    setLoading(true);
    globalPrint("inaide sign up");
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      storeUserData(userCredential.user!.uid,   name,   birthdate,email,password);
      // User is signed up, you can store additional user data here
    }
    on SocketException
    {
      setLoading(false);
      AppRouter.navigatorKey.currentContext!.showAppDialog(message: "No Internet Connection",title: "Error");

    }
    catch ( e) {
      globalPrint('Failed to sign up: ${e}');
      setLoading(false);
      AppRouter.navigatorKey.currentContext!.showAppDialog(message: e.toString(),title: "Error");
      // Handle sign-up errors
    }
  }

// Store user data in Firestore
  Future<void> storeUserData(String uid, String name, int birthdate,String email,String password) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'name': name,
        'birthdate': birthdate,
      });
     sl<SignInProvider>().signInWithEmailAndPassword(email, password);

    } catch (e) {
      setLoading(false);
      globalPrint('Failed to store user data: $e');
      AppRouter.navigatorKey.currentContext!.showAppDialog(message: e.toString(),title: "Error");

      // Handle errors
    }
  }

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      AppRouter.navigatorKey.currentContext!.pushReplacementName(AppRoutes.signIn);


     } catch (e) {
      AppRouter.navigatorKey.currentContext!.showAppDialog(message: e.toString(),title: "Error");

    }
  }

}