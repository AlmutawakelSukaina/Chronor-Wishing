


import '../../../libs.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController email=TextEditingController();
  final TextEditingController password=TextEditingController();
  final FocusNode emailFocus =FocusNode();
  final FocusNode passFocus =FocusNode();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
     super.initState();
  }
  @override
  void dispose() {
   email.dispose();
   password.dispose();
   emailFocus.dispose();
   passFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return   SafeArea(
      child:  PopScope(
        canPop: false,
        onPopInvoked: (bool pop){
          if(pop)return;
          SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        },
        child: Material(
          color: AppColors.backgroundColor,

          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 30
              ),
              child: Column(
                children: [
                  CustomTextApp(
                    text: "Sign In",
                    size: 13,
                    colors: AppColors.orange,
                    italic: true,
                  ).fullSizeWidth(),
                  20.ph,
                  CustomTextField(
                    textEditingController: email,
                    focusNode: emailFocus,
                    textInputType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    fillColor: AppColors.white,
                    hint: "Email",
                    validator:(String?value){
                      return checkEmpty(value);
                    } ,


                  ),
                  5.ph,

                  CustomTextField(
                    textEditingController: password,
                    focusNode: passFocus,
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    suffixShowHidePassword: true,
                    fillColor: AppColors.white,
                    hint: "Password",
                    onFieldSubmitted: (String?value){
                      onSubmit();
                    },
                    validator: (String?value){
                      return checkEmpty(value);
                    },
                  ),
                  5.ph,

                  CustomButton(onPressed:onSubmit, text: "Sign In").fullSizeWidth(),
                  4.ph,
                  CustomTextSpan(onPressed: () {
                    context.pushReplacementName(AppRoutes.signUp);

                  },
                    text1: "Don't have an account?",
                    text2:"Sign up" ,

                  )
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
  void onSubmit()
  {
    if(_formKey.currentState!.validate())
    {
      sl<SignInProvider>().signInWithEmailAndPassword(email.text,
          password.text);
    }

  }
}
