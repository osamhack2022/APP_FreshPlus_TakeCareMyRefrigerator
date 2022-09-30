import 'package:flutter/material.dart';


class Checkbox_page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                      MakeCheckbox(),
                    ],
                  ),
        ],
      ),
    );
  }
}

class MakeCheckbox extends StatefulWidget {
  @override
  State<MakeCheckbox> createState() => _MakeCheckboxState();
}

class _MakeCheckboxState extends State<MakeCheckbox> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
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
}

