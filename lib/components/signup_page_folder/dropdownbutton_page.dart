import 'package:flutter/material.dart';

const List<String> refrigerator_list = <String>['냉장고1', '냉장고2', '냉장고3', '냉장고4'];
const List<String> member_list = <String>['병사', '분대장', '관리자'];

class Dropdownbutton_page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("냉장고"),
                  DropBtn(),
                ],
              ),
              SizedBox(width: 50),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("회원유형"),
                  DropBtn2(),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DropBtn extends StatefulWidget {
  @override
  State<DropBtn> createState() => _DropBtnState();
}

class _DropBtnState extends State<DropBtn> {
  String dropdownValue = refrigerator_list.first;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(width: 1, color: Colors.white),
          ),
        ),
        value: dropdownValue,
        elevation: 13,
        style: const TextStyle(color: Colors.black),
        onChanged: (String? value) {
          setState(() {
            dropdownValue = value!;
          });
        },
        items: refrigerator_list.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}

class DropBtn2 extends StatefulWidget {
  @override
  State<DropBtn2> createState() => _DropBtnState2();
}

class _DropBtnState2 extends State<DropBtn2> {
  String dropdownValue = member_list.first;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(width: 1, color: Colors.white),
          ),
        ),
        value: dropdownValue,
        elevation: 13,
        style: const TextStyle(color: Colors.black),
        onChanged: (String? value) {
          setState(() {
            dropdownValue = value!;
          });
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
}
