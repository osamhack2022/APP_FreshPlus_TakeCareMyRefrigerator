import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutlab/components/pages/login_page.dart';
import 'package:get/get.dart';

class HomepageDrawer extends StatefulWidget {
  const HomepageDrawer({Key? key}) : super(key: key);
  _HomepageDrawerState createState() => _HomepageDrawerState();
}

class _HomepageDrawerState extends State<HomepageDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            currentAccountPicture: Container(
              width: 20,
              height: 20,
              child: CircleAvatar(
                backgroundImage: AssetImage("assets/profile.jpg"),
              ),
            ),
            accountName: Text(
              'User_name님',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w500,
                fontFamily: 'Roboto',
              ),
            ),
            accountEmail: Text(
              'test@test.io',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 14.0,
                color: Color(0x99000000),
                fontWeight: FontWeight.w400,
              ),
            ),
            decoration: BoxDecoration(color: Colors.white),
          ),
          Padding(
              padding: EdgeInsets.only(left: 7),
              child: Text(
                'Fresh Plus와 함께 쉽고 철저한 신선식품관리',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 14.0,
                  color: Color(0x99000000),
                  fontWeight: FontWeight.w400,
                ),
              )),
          SizedBox(height: 11),
          SizedBox(
            height: 1,
            width: double.infinity,
            child: const DecoratedBox(
              decoration: const BoxDecoration(color: Color(0x14212121)),
            ),
          ),
          InkWell(
            splashColor: Colors.lightGreen,
            child: ListTile(
              leading: Icon(
                Icons.info,
                color: Color(0x99000000),
              ),
              title: Text(
                '지난알림',
                style: TextStyle(
                  color: Color(0x99000000),
                ),
              ),
              onTap: () {
                print('Home is clicked');
              },
            ),
          ),
          InkWell(
            splashColor: Colors.lightGreen,
            child: ListTile(
              leading: Icon(
                Icons.settings,
                color: Color(0x99000000),
              ),
              title: Text(
                '비밀번호 재설정',
                style: TextStyle(
                  color: Color(0x99000000),
                ),
              ),
              onTap: () {
                //Get.to("password reset page route here");
              },
            ),
          ),
          InkWell(
            splashColor: Colors.lightGreen,
            child: ListTile(
              leading: Icon(
                Icons.logout,
                color: Color(0x99000000),
              ),
              title: Text(
                '로그아웃',
                style: TextStyle(
                  color: Color(0x99000000),
                ),
              ),
              onTap: () {
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Logout'),
                    content: const Text('로그아웃 하시겠습니까?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('No'),
                      ),
                      TextButton(
                        onPressed: () {
                          _signOut();
                          //Get.to(LoginPage());
                        },
                        child: const Text('Yes'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> _signOut() async {
  await FirebaseAuth.instance.signOut();
}
