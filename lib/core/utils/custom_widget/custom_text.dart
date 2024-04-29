import 'package:flutter_html/flutter_html.dart';

import '../../../libs.dart';

class CustomTextApp extends StatelessWidget {
  final String? text;
  final double? size;
  final FontWeight? font;
  final Color? colors;
  final int? maxLines;
  final int? minLines;
  final TextDecoration? decoration;
  final double? thickness;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final Color? decorationColor;
  final List<Shadow>? shadow;
  final TextDirection? textDirection;
  final bool? italic;
  final Color? backgroundColor;

  const CustomTextApp({
    this.text,
    this.size,
    this.font,
    this.colors,
    this.decorationColor,
    this.maxLines,
    this.thickness,
    this.overflow,
    this.textAlign,
    this.decoration,
    super.key,
    this.shadow,
    this.textDirection,
    this.minLines,
    this.italic,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: text,
      child: Text(
        text ?? "",
        semanticsLabel: text,
        textAlign: textAlign ?? TextAlign.start,
        maxLines: maxLines,
        style: TextStyle(
          shadows: shadow,
          backgroundColor: backgroundColor,
          fontWeight: font ?? FontWeight.normal,
          color: colors ?? Colors.black,
          fontSize: size == null
              ? Responsive.width(context) *
                  1.5 *
                  (Responsive.screenSize(context, 1, .75, .48))
              : Responsive.width(context) *
                  size! *
                  (Responsive.screenSize(context, 1, .75, .48)),
          fontStyle: italic == true ? FontStyle.italic : null,
          overflow: overflow,
          decoration: decoration ?? TextDecoration.none,
          decorationThickness: thickness ?? 2.5,
          decorationColor: decorationColor,
          fontFamily: appFont,
        ),
        textDirection: textDirection,
      ),
    );
  }
}

class CustomHtml extends StatelessWidget {
  final String data;
  final Color ?color;
  final bool? isCard;
 final FontWeight?fontWeight;
  const CustomHtml({
    super.key,
    required this.data,
      this.color,
    this.isCard, this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return isCard != false
        ? HtmlText(data: data,fontWeight: fontWeight,).fullSizeWidth().containerWithBorderSide(color??AppColors.white)
        : HtmlText(data: data,fontWeight: fontWeight,);
  }
}

class HtmlText extends StatelessWidget {
  final String data;
  final FontWeight? fontWeight;
  const HtmlText({
    super.key,
    required this.data,   this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Html(
      data: data,
      onLinkTap: (String? url, Map<String, String> attributes, element) {
        globalPrint("url inside $url");
        if (url != null) {
          launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
        }
      },
      style: {
        "body": Style(
            fontFamily: appFont,
            alignment: Alignment.center,
            fontStyle: FontStyle.italic,
            fontWeight: fontWeight,
            fontSize: FontSize(Responsive.width(context) * 4.5)),
      },
    );
  }
}
