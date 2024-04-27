import '../../libs.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _animation;
  String logoText = 'Chrono Wishing';

  void route() async {
    const storage = FlutterSecureStorage();
    bool isSignedIn = (await storage.read(key: prefSignedIn) == "true");
    if (!mounted) return;
    if (isSignedIn) {
      context.pushName(AppRoutes.mainPage);
    } else {
      context.pushName(AppRoutes.welcomeScreen);
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
    _animation = IntTween(begin: 0, end: logoText.length)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut))
      ..addListener(() {
        setState(() {});
      });
    _controller.forward();
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        route();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String animatedText = logoText.substring(0, _animation.value);
    return Container(
      color: AppColors.orange,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CustomTextApp(
              text: animatedText,
              colors: Colors.white,
              size: 10,
              font: FontWeight.w600,
            )
          ],
        ),
      ),
    );
  }
}
