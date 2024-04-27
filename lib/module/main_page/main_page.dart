import 'package:chrono_wish/module/main_page/birth_day_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../libs.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage>
    with AutomaticKeepAliveClientMixin<MainPage> {
  int _selectedIndex = 0;
  Future<List<HistoricalCategoryModel>>? responseHistoricalEvent;
  Future? userData;

  void getUserName() {
    const storage = FlutterSecureStorage();
    userData = Future.wait([
      storage.read(key: prefUserName),
      storage.read(key: prefBirthdate),
    ]);
  }

  void getHistoricalEvent() {
    responseHistoricalEvent = sl<HomeProvider>().getHistoricalEvent();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    getHistoricalEvent();
    getUserName();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: Column(
          children: [
            FutureBuilder(
                future: userData,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    String? birthDay = snapshot.data[1];
                    DateTime? birthDate;
                    if (birthDay != null) {
                      birthDate = DateTime.fromMillisecondsSinceEpoch(
                          int.parse(birthDay));
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextApp(
                          text: "${greetUser()} ${snapshot.data[0] ?? ""}",
                          italic: true,
                          size: 7,
                          backgroundColor: Colors.orange[50],
                        ),
                        if (_selectedIndex == 0) ...[
                          2.ph,
                          if (birthDate != null &&
                              birthDate.day == DateTime.now().day &&
                              birthDate.month == DateTime.now().month)
                            const BirthdayCelebration(),
                        ]
                      ],
                    ).fullSizeWidth().symmetricPadding(4, 4);
                  } else {
                    return const Nothing();
                  }
                }),
            Expanded(
              child: IndexedStack(
                index: _selectedIndex,
                children: <Widget>[
                  HomePage(
                    responseHistoricalEvent: responseHistoricalEvent,
                  ),
                  const ProfileTab()
                ],
              ),
            ),
          ],
        ),
        extendBody: true,
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(40),
              topLeft: Radius.circular(40),
            ),
            child: BottomNavigationBar(
              backgroundColor: AppColors.white,
              selectedLabelStyle: const TextStyle(fontFamily: appFont),
              unselectedLabelStyle: const TextStyle(fontFamily: appFont),
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_2),
                  label: 'Profile',
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: AppColors.orange,
              onTap: _onItemTapped,
            ),
          ),
        ),
      ),
    );
  }

  String greetUser() {
    DateTime now = DateTime.now();
    int hour = now.hour;

    if (hour < 12) {
      return 'Good morning!';
    } else if (hour < 18) {
      return 'Good afternoon!';
    } else {
      return 'Good evening!';
    }
  }

  @override
  bool get wantKeepAlive => true;
}
