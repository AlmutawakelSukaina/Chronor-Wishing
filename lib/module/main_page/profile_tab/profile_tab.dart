import '../../../libs.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          10.ph,
          Column(
            children: [
              CustomListTile(
                title: "User Profile",
                onTap: () {
                  context.pushName(AppRoutes.userProfile);
                },
              ),
              const Divider().symmetricPadding(2, 4),

              CustomListTile(
                title: "Notification",
                onTap: () {
                  context.pushName(AppRoutes.notification);
                },
              ),

            ],
          ).roundedWidget(),
          5.ph,
          CustomButton(
            onPressed: () {
              sl<SignUpProvider>().signOut();
            },
            text: " Logout ",
            elevation: 0,
            border: true,
            buttonColor: AppColors.white,
            textColor: AppColors.black,
            radius: 30,
          )
        ],
      ).symmetricPadding(4, 4),
    );
  }
}

class CustomListTile extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const CustomListTile({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: CustomTextApp(
        text: title,
        size: 5,
      ),
      trailing:   Icon(
        CupertinoIcons.forward,
        color: AppColors.orange,
      ),
      onTap: onTap,
    );
  }
}
