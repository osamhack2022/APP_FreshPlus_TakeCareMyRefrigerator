import 'package:flutter/material.dart';
import '../login_page.dart';
class SignupButton_page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
    }
}

class SignupButton extends StatefulWidget {
  @override
  State<SignupButton> createState() => _SignupButtonState();
}

class _SignupButtonState extends State<SignupButton> {
  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20),
      primary: Color(0xff2C7B0C),
      onPrimary: Color(0xffE0E0E0),
    );

    return Center(
      child: SizedBox(
        width: 250,
        child: ElevatedButton(
          style: style,
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => LoginPage()));
          },
          child: Text("회원가입"),
        ),
      ),
    );
  }
}