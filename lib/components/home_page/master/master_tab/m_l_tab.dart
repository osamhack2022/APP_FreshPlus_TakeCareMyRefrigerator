import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../master_page/m_u_page.dart';
import 'package:get/get.dart';

class MLTab extends StatefulWidget {
  _MLTabState createState() => _MLTabState();
}

class _MLTabState extends State<MLTab> with TickerProviderStateMixin {
  CollectionReference product =
      FirebaseFirestore.instance.collection('product');

  final TextEditingController nameController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController pictureController = TextEditingController();

  Future<void> _update(DocumentSnapshot documentSnapshot) async {
    nameController.text = documentSnapshot['name'];
    dateController.text = documentSnapshot['date'];
    pictureController.text = documentSnapshot['picture'];

    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          child: Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: dateController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(labelText: 'date'),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    final String name = nameController.text;
                    final String date = dateController.text;
                    await product
                        .doc(documentSnapshot.id)
                        .update({"name": name, "date": date});
                    nameController.text = "";
                    dateController.text = "";
                    Navigator.of(context).pop();
                  },
                  child: Text('Update'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(
      length: 4,
      vsync: this, //vsync에 this 형태로 전달해야 애니메이션이 정상 처리됨
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Color(0xff2C7B0C),
            child: TabBar(
              tabs: [
                Container(
                  height: 56,
                  alignment: Alignment.center,
                  child: Text(
                    '분대원\nR명',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  height: 56,
                  alignment: Alignment.center,
                  child: Text(
                    '위험물품 \n M + L 개',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  height: 56,
                  alignment: Alignment.center,
                  child: Text(
                    '유실\nK개',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  height: 56,
                  alignment: Alignment.center,
                  child: Text(
                    '미등록\nT개',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
              labelColor: Color(0xffC8DDC0),
              unselectedLabelColor: Colors.black,
              controller: _tabController,
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                Container(
                  child: StreamBuilder(
                    stream: product.snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                      if (streamSnapshot.hasData) {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: streamSnapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            final DocumentSnapshot documentSnapshot =
                                streamSnapshot.data!.docs[index];
                            String _productImage = "";
                            String _setImage() {
                              String _mTitle = documentSnapshot['picture'];
                              if (_mTitle == "hotdog") {
                                _productImage = "assets/hotdog.jpg";
                              } else if (_mTitle == "icecream") {
                                _productImage = "assets/icecream.jpg";
                              } else if (_mTitle == "strawberry_milk") {
                                _productImage = "assets/strawberry_milk.jpg";
                              } else if (_mTitle == "banana_milk") {
                                _productImage = "assets/banana_milk.jpg";
                              } else if (_mTitle == "choco_milk") {
                                _productImage = "assets/choco_milk.jpg";
                              } else if (_mTitle == "chicken") {
                                _productImage = "assets/chicken.jpg";
                              }
                              print(_productImage);
                              return _productImage;
                            }

                            String _productDate = "";
                            String datetime = DateTime.now().toString();
                            print(datetime);
                            var dt = DateTime.now();
                            var day = dt.day;
                            var month = dt.month;
                            var year = dt.year;
                            
                            print(day);
                            print(month);
                            print(year);

                            String _setDate() {
                              var _mDate = int.parse(documentSnapshot['date']);

                              return _productDate;
                            }

                            return GestureDetector(
                              onTap: () => Get.to(MUPage()),
                              child: Card(
                                margin: EdgeInsets.only(
                                    left: 8, right: 8, top: 2, bottom: 2),
                                child: ListTile(
                                  leading:
                                      Image(image: AssetImage(_setImage())),
                                  title: Text(documentSnapshot['name']),
                                  subtitle: Text(documentSnapshot['date']),
                                  trailing: Text(
                                    '위험',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Roboto',
                                    ),
                                  ),
                                  isThreeLine: true,
                                ),
                              ),
                            );
                          },
                        );
                      }
                      return Center(child: CircularProgressIndicator());
                    },
                  ),
                ),
                Container(
                  color: Colors.green[200],
                  alignment: Alignment.center,
                  child: Text(
                    'Tab2 View',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
                Container(
                  color: Colors.green[200],
                  alignment: Alignment.center,
                  child: Text(
                    'Tab3 View',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
                Container(
                  color: Colors.green[200],
                  alignment: Alignment.center,
                  child: Text(
                    'Tab4 View',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
