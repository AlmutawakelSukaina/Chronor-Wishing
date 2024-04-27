import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../../libs.dart';

class BirthdayCelebration extends StatelessWidget {
  const BirthdayCelebration({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                flex: 7,
                child: Column(
                  children: [
                    CustomTextApp(
                      text: '🎉Happy birthday!🎉',
                      italic: true,
                      size: 5,
                    ),
                    CustomTextApp(
                      text: 'We hope you have a fantastic day! 🎉',
                      italic: true,
                      size: 5,
                    ),
                  ],
                ),
              ),
              3.pw,
              Expanded(
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: const BoxDecoration(
                    color: Colors.pink,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.cake,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Divider(),
          const CustomTextApp(
            text: 'Share your special day with your friends on'
                ' Facebook or Twitter! 🥳',
            italic: true,
            size: 5,
          ),
          2.ph,
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Icon(
                Icons.share,
              ).onTap(() async {
                final box = context.findRenderObject() as RenderBox?;
                await Share.share(
                  'It\'s my birthday today! 🎉🎂🥳',
                  subject: '🎉Happy birthday!🎉',
                  sharePositionOrigin:
                      box!.localToGlobal(Offset.zero) & box.size,
                );
              })
            ],
          ),
          2.ph,
        ],
      ),
    ).symmetricPadding(2, 2).roundedWidget();
  }
}
