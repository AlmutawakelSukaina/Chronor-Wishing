import '../../libs.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        color: AppColors.backgroundColor,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            20.ph,

            CustomTextApp(
              text: "Welcome to our",
              size: 8,
              textAlign: TextAlign.center,
              italic: true,
              backgroundColor: Colors.orange[50],
            ),
             CustomTextApp(
              text: "🎉Chrono Wish App! 🎉",
              size: 8,
              textAlign: TextAlign.center,
              italic: true,
              backgroundColor: Colors.orange[50],
            ),
            20.ph,
            SizedBox(
              width: Responsive.fullWidth(context),
              child: CustomButton(
                onPressed: () {
                  context.pushReplacementName(AppRoutes.signIn);
                },
                text: "Sign In",
                textColor: AppColors.white,
              ),
            ),
            5.ph,
            SizedBox(
              width: Responsive.fullWidth(context),
              child: CustomButton(
                onPressed: () {
                  context.pushReplacementName(AppRoutes.signUp);
                },
                text: "Sign Up",
                border: true,
                buttonColor: AppColors.white,
                textColor: AppColors.black,
              ),
            ),
          ],
        ).symmetricPadding(2, 4),
      ),
    );
  }
}
