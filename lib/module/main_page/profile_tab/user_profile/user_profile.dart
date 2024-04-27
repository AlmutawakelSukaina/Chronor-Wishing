import '../../../../libs.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final birthDate = ValueNotifier<DateTime?>(null);
  final showBirthDateError = ValueNotifier<bool>(false);
  final TextEditingController userName = TextEditingController();
  String? currentBirthDate, currentUserName;
  String? userId;

  void getUserData() async {
    const storage = FlutterSecureStorage();

    List result = await Future.wait([
      storage.read(key: prefUserName),
      storage.read(key: prefBirthdate),
      storage.read(key: prefUserId),
    ]);

    currentBirthDate = result[1];
    currentUserName = result[0];
    globalPrint("currentBirthDate $currentBirthDate");
    globalPrint("currentUserName $currentUserName");
    userId = result[2];
    userName.text = result[0];

    birthDate.value = DateTime.fromMillisecondsSinceEpoch(int.parse(result[1]));

  }

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  @override
  void dispose() {
    birthDate.dispose();
    showBirthDateError.dispose();
    userName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: customAppBar(),
        body: SingleChildScrollView(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            5.ph,
            CustomTextField(
              textEditingController: userName,
              textInputType: TextInputType.text,
              textInputAction: TextInputAction.next,
              fillColor: AppColors.white,
              hint: "Name",
              validator: (String? value) {
                return checkEmpty(value);
              },
            ),
            4.ph,
            CustomBirthDatePicker(
              birthDate: birthDate,
              showBirthDateError: showBirthDateError,
            ),
            4.ph,
            CustomButton(
                onPressed: () {
                  String userBirth= birthDate.value!.millisecondsSinceEpoch.toString();
                  globalPrint("currentBirthDate $currentBirthDate $userBirth ");
                  globalPrint("currentBirthDate ${userName.text}  $currentUserName");
                  if (currentBirthDate !=userBirth ||
                      currentUserName != userName.text.trim()) {
                    sl<UserProfile>().updateUser(userId, {
                      'name': userName.text,
                      'birthdate': userBirth,
                    });
                  }else
                    {
                      context.showAppDialog(
                          message:"Nothing has been changed. No edits to save", title: "Error");
                    }
                },
                text: "Edit")
          ],
        ).symmetricPadding(7, 6)),
      ),
    );
  }
}
