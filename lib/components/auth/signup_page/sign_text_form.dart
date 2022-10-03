// name, email, armyCode, password Textflied
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helloworld/firebase/controller/ctrl_exception.dart';
import '../login_page/login_page.dart';
import '/firebase/controller/auth/sign_up_ctrl.dart';

class SignTextForm extends StatefulWidget {
  const SignTextForm({Key? key}) : super(key: key);
  _SignTextFormState createState() => _SignTextFormState();
}

class _SignTextFormState extends State<SignTextForm> {
  /*final List<String> refrigerator_list = <String>[
    '냉장고1',
    '냉장고2',
    '냉장고3',
    '냉장고4'
  ];*/
  final List<String> member_list = <String>['user', 'manager', 'master'];
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final armyCodeController = TextEditingController();
  final passwordController = TextEditingController();
  List<String> refrigerator_list = [];
  String fridge = "냉장고1";
  String userType = "master";
  bool isChecked = false;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    armyCodeController.dispose();
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
            nameForm(),
            const SizedBox(height: 15.0),
            emailForm(),
            const SizedBox(height: 15.0),
            const SizedBox(height: 15.0),
            passwordForm(),
            const SizedBox(height: 17.0),
            unitIDForm(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("회원유형"),
                    dropUserType(),
                  ],
                ),
                SizedBox(width: 50),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("냉장고"),
                    dropFridge(),
                  ],
                ),
              ],
            ),
            checkbox(),
            signUpButton(),
          ],
        ),
      ),
    );
  }

  nameForm() {
    return TextFormField(
      controller: nameController,
      validator: (name) {
        if (name!.isEmpty) {
          return '반드시 본명을 입력해야합니다.';
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
        labelText: "이름",
        labelStyle: TextStyle(
            fontSize: 12.0, color: Colors.black, fontWeight: FontWeight.w400),
        hintText: "이름을 입력해주세요",
        hintStyle: TextStyle(
            fontSize: 16.0, color: Colors.black, fontWeight: FontWeight.w500),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0x14212121)),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(4.0), topRight: Radius.circular(4.0)),
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
    );
  }

  emailForm() {
    return TextFormField(
      controller: emailController,
      validator: (email) {
        if (email!.isEmpty) {
          return '이메일을 입력하세요';
        } else if (!RegExp(
                r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
            .hasMatch(email)) {
          return '이메일 형식이 바르지 않습니다';
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
        labelText: "이메일",
        labelStyle: TextStyle(
            fontSize: 12.0, color: Colors.black, fontWeight: FontWeight.w400),
        hintText: "이메일을 입력해주세요",
        hintStyle: TextStyle(
            fontSize: 16.0, color: Colors.black, fontWeight: FontWeight.w500),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0x14212121)),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(4.0), topRight: Radius.circular(4.0)),
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
    );
  }

  unitIDForm() {
    return TextFormField(
      controller: armyCodeController,
      validator: (armyCode) {
        if (armyCode!.isEmpty) {
          return '부대 코드를 입력해주세요';
        } else if (!RegExp(
                r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
            .hasMatch(armyCode)) {
          return '부대 코드 형식이 바르지 않습니다';
        } else if (armyCode.length < 7) {
          return '부대코드는 부대별로 부여한 6자리 숫자입니다';
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
        labelText: "부대 코드",
        labelStyle: TextStyle(
            fontSize: 12.0, color: Colors.black, fontWeight: FontWeight.w400),
        hintText: "부대 코드를 입력해주세요",
        hintStyle: TextStyle(
            fontSize: 16.0, color: Colors.black, fontWeight: FontWeight.w500),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0x14212121)),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(4.0), topRight: Radius.circular(4.0)),
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
    );
  }

  passwordForm() {
    return TextFormField(
      controller: passwordController,
      validator: (password) {
        if (password!.isEmpty) {
          return '비밀번호를 입력하세요';
        } else if (password.length < 8) {
          return '비밀번호가 짧습니다';
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        border: InputBorder.none,
        filled: true,
        fillColor: const Color(0x14212121),
        labelText: "비밀번호",
        labelStyle: const TextStyle(
            fontSize: 12.0, color: Colors.black, fontWeight: FontWeight.w400),
        hintText: "비밀번호를 입력해주세요",
        hintStyle: const TextStyle(
            fontSize: 16.0, color: Colors.black, fontWeight: FontWeight.w500),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0x14212121)),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(4.0), topRight: Radius.circular(4.0)),
        ),
        focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xff6200EE))),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
      ),
    );
  }

  dropUserType() {
    return SizedBox(
      width: 120,
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(width: 1, color: Colors.white),
          ),
        ),
        value: userType,
        elevation: 13,
        style: const TextStyle(color: Colors.black),
        onChanged: (String? value) async {
          setState(() {
            userType = value!;
          });
          try {
            if (value != "master") {
              if (armyCodeController.text.trim() != "") {
                refrigerator_list =
                    await getFridgeList(armyCodeController.text.trim());
                if (refrigerator_list.length > 0) fridge = refrigerator_list[0];
              }
            }
            print(refrigerator_list);
          } on CtrlException catch (e) {
            print(e.code);
          }
        },
        items: member_list.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  dropFridge() {
    return SizedBox(
      width: 120,
      child: DropdownButtonFormField<String>(
        disabledHint: Text("냉장고 없음"),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(width: 1, color: Colors.white),
          ),
        ),
        value: fridge,
        elevation: 13,
        style: const TextStyle(color: Colors.black),
        onChanged: refrigerator_list != []
            ? (value) => setState(() {
                  fridge = value!;
                })
            : null,
        items: refrigerator_list.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  checkbox() {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Text("개인 정보 취급에 관한 동의",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                    )),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  width: 300,
                  height: 50,
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                  child: Text(
                    """본인은 위의 동의서 내용을 충분히 숙지하였으며, 개인정보 수집, 이용, 제공하는 것에 동의합니다.""",
                    style: TextStyle(fontSize: 12),
                  )),
              makeCheck(),
            ],
          ),
        ],
      ),
    );
  }

  makeCheck() {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.black;
    }

    return Checkbox(
      checkColor: Colors.white,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: isChecked,
      onChanged: (bool? value) {
        setState(() {
          isChecked = value!;
        });
      },
    );
  }

  signUpButton() {
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
          onPressed: () async {
            //where is validator?
            try {
              await signUp(
                  emailController.text.trim(),
                  passwordController.text.trim(),
                  nameController.text.trim(),
                  armyCodeController.text.trim(),
                  fridge!,
                  userType!);
              print('Successfully Signed Up');
              Get.to(LoginPage());
            } on CtrlException catch (e) {
              if (e.code == "user-exist") {
              } else if (e.code == "no-fridge") {
              } else if (e.code == "no-unit") {
              } else if (e.code == "manager-exist") {
              } else if (e.code == "unit-exist") {}
            }
          },
          child: Text("회원가입"),
        ),
      ),
    );
  }
}
