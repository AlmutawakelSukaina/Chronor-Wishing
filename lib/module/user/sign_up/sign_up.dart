
import '../../../libs.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController email = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController password = TextEditingController();
  final FocusNode emailFocus = FocusNode();
  final FocusNode passFocus = FocusNode();
  final FocusNode nameFocus = FocusNode();
  final birthDate = ValueNotifier<DateTime?>(null);
  final showBirthDateError = ValueNotifier<bool>(false);
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
    birthDate.dispose();
    name.dispose();
    nameFocus.dispose();
     showBirthDateError.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child:
     PopScope(
       canPop: false,
       onPopInvoked: (bool pop){
         if(pop)return;
         backButton();
       },
       child: Scaffold(
         backgroundColor: AppColors.backgroundColor,
         appBar: customAppBar(
           backFun:backButton
         ),
         body: Form(
           key: _formKey,
           child: SingleChildScrollView(
             padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
             child: Stack(
               children: [
                 Column(
                   children: [
                     CustomTextApp(
                       text: "Sign Up",
                       size: 13,
                       colors: AppColors.orange,
                       italic: true,
                     ).fullSizeWidth(),
                     15.ph,
                     CustomTextField(
                       textEditingController: name,
                       focusNode: nameFocus,
                       textInputType: TextInputType.text,
                       textInputAction: TextInputAction.next,
                       fillColor: AppColors.white,
                       hint: "Name",
                       validator: (String? value) {
                         return checkEmpty(value);
                       },
                     ),
                     5.ph,
                     CustomBirthDatePicker(
                       birthDate: birthDate,
                       showBirthDateError: showBirthDateError,
                     ),
                     ShowError(
                         error: showBirthDateError, text: 'Select your birthdate'),
                     5.ph,
                     CustomTextField(
                       textEditingController: email,
                       focusNode: emailFocus,
                       textInputType: TextInputType.emailAddress,
                       textInputAction: TextInputAction.next,
                       fillColor: AppColors.white,
                       hint: "Email",
                       validator: (String? value) {
                         return validateEmail(value);
                       },
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
                       validator: (String? value) {
                         return validatePassword(value);
                       },
                       onFieldSubmitted: (String?value){
                         onSubmit();
                       },
                     ),
                     5.ph,
                     CustomButton(
                         onPressed: onSubmit,
                         text: "Sign Up")
                         .fullSizeWidth(),
                     4.ph,
                   ],
                 ),
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
    if (!_formKey.currentState!.validate()) {
    } else if (birthDate.value == null) {
      showBirthDateError.value = true;
    } else {
      sl<SignUpProvider>().signUpWithEmailAndPassword(
          name.text,
          birthDate.value!.millisecondsSinceEpoch,
          email.text,
          password.text);
    }
  }
  void backButton()
  {
    context.pushReplacementName(AppRoutes.signIn);
  }
}
