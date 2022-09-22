import '../main.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class CustomForm extends StatefulWidget {
  const CustomForm({Key? key}) : super(key: key);
  _CustomFormState createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool _isObscure = true;
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24.0, 0.0, 23.0, 0.0),
        child: Column(
          children: [
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return '군번을 입력하세요';
                } else if (value.length <= 10) {
                  return '군번 형식이 옳바르지 않습니다';
                } else if (value.contains("-") == true) {
                  return '-를 제외하세요';
                } else {
                  return null;
                }
              },
              //keyboardType: TextInputType.number,
              //inputFormatters: [
              //  FilteringTextInputFormatter.allow(RegExp('[0-9]')),
              //],
              //obscureText: true,
              decoration: const InputDecoration(
                border: InputBorder.none,
                filled: true,
                fillColor: Color(0x14212121),
                labelText: "군번",
                labelStyle: TextStyle(
                    fontSize: 12.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w400),
                hintText: "군번을 입력해주세요",
                hintStyle: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0x14212121)),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(4.0),
                      topRight: Radius.circular(4.0)),
                ),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff6200EE))),
                errorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
                errorStyle: TextStyle(
                  fontFamily: "Roboto",
                  fontSize: 12.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(height: 15.0),
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return '비밀번호를 입력하세요';
                } else if (value.length < 8) {
                  return '비밀번호가 짧습니다';
                } else {
                  return null;
                }
              },
              obscureText: _isObscure,
              decoration: InputDecoration(
                border: InputBorder.none,
                filled: true,
                fillColor: const Color(0x14212121),
                labelText: "비밀번호",
                labelStyle: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w400),
                hintText: "비밀번호를 입력해주세요",
                hintStyle: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isObscure ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  },
                ),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0x14212121)),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(4.0),
                      topRight: Radius.circular(4.0)),
                ),
                focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff6200EE))),
                errorBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
              ),
            ),
            const SizedBox(height: 17.0),
            SizedBox(
              width: 250.0,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    //Navigator.push(
                    //    context, MaterialPageRoute(builder: (_) => HomePage()));
                  }
                },
                child: const Text(
                  '로그인test',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w500,
                    color: Color(0xffFFFFFF),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xff2C7B0C),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  signIn() async {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).requestFocus(FocusNode());
      try {
        print(emailController.text.trim());
        print(emailController.text);
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
        //Get.offAll(() => const HomePage());
      } on FirebaseAuthException catch (e) {
        logger.e(e);
        String message = '';
        if (e.code == 'user-not-found') {
          message = '사용자가 존재하지 않습니다.';
        } else if (e.code == 'wrong-password') {
          message = '비밀번호를 확인하세요';
        } else if (e.code == 'invalid-email') {
          message = '이메일을 확인하세요.';
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: Colors.deepOrange,
          ),
        );
      }
    }
  }
}
