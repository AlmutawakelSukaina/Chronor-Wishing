import '../../../libs.dart';

class CustomTextSpan extends StatelessWidget {
  final VoidCallback onPressed;
  final String text1;
  final String text2;

  const CustomTextSpan({
    super.key,
    required this.onPressed,
    required this.text1,
    required this.text2,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: "$text1 ",
        style: TextStyle(color: Colors.black, fontFamily: appFont,
        fontSize: 15
        ),
        children: <TextSpan>[
          TextSpan(
            text: text2,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue,
                fontFamily: appFont,
              decoration: TextDecoration.underline,
            ),
          ),
        ],
      ),
    ).onTap(onPressed);
  }
}
