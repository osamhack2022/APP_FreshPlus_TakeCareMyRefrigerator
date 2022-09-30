import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'sign_text_form.dart';
import 'dropdownbutton_page.dart';
import 'checkbox_page.dart';
import 'signupButton.dart';

class SignupPage extends StatelessWidget{
    @override
    Widget build(BuildContext context){
        return MaterialApp(
            home:Scaffold(
                body:Container(
                    child:ListView(
                        children: [
                            SizedBox(height:40),

                            //Flesh Plus logo 삽입
                            SvgPicture.asset(
                                'assets/fp.svg',
                                width:147.45,
                                height: 137.36,
                            ),

                            SizedBox(height: 35),
                            Text("회원가입",
                                style: TextStyle(fontSize: 24, color: Colors.black,)),
                            SizedBox(height: 24),
                            
                            //이름, 이메일, 부대코드, 비밀번호 클래스
                            SignTextForm(),
                            
                            //냉장고, 회원유형 DropdownButton 클래스
                            Dropdownbutton_page(),
                            SizedBox(height: 15),

                            Checkbox_page(),
                            SizedBox(height: 20),
                            SignupButton_page(),
                            SizedBox(height: 20),
                

                        ],
                    ),
                ),
            ),
        );
    }
}

