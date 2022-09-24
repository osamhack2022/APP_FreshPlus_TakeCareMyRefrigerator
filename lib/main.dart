import 'package:flutter/material.dart';
import 'firebase/repository/item_repository.dart';
import 'firebase/repository/user_repository.dart';
import 'firebase/init.dart';
//flutter 
void main() async{
  await initialize();
  UserRepository userRepo = UserRepository();
  await userRepo.requestLogIn("test@test.io","testtest");
  ItemRepository repo = ItemRepository("777QQQ","1c1p","babu");
  repo.init();
  //Fridge fridge = Fridge("1c1p","1층 우측",6,"서현동",["서현동","조현민"],3,3);
  //await repo.addFridge(fridge);
  // await repo.editItemNum("1c1p",5);
  // await repo.editItemNum("1c1p",-3);
  // await repo.editManager("1c1p","조현민");
  // await repo.addUsers("1c1p","소현민");
  // await repo.deleteUsers("1c1p","서현동");
  // Fridge fridge = await repo.getFridge("1c1p");
  // print(fridge.manager);
  //await repo.deleteFridge("1c1p");

  // UserBox box = UserBox("YGMlwcrNsQRpJ8yvBVEuoJMGbt83",3,[]);
  // await repo.editItemNum("YGMlwcrNsQRpJ8yvBVEuoJMGbt83",-1);
  // await repo.addItems("YGMlwcrNsQRpJ8yvBVEuoJMGbt83","chips");
  // await repo.addItems("YGMlwcrNsQRpJ8yvBVEuoJMGbt83","hargendas");
  // await repo.deleteItems("YGMlwcrNsQRpJ8yvBVEuoJMGbt83","hargendas");
  // print((await repo.getUserBox("YGMlwcrNsQRpJ8yvBVEuoJMGbt83")).itemNum);
  // await repo.deleteUserBox("YGMlwcrNsQRpJ8yvBVEuoJMGbt83");
  // Item item = Item("","banana",'babu',DateTime(2022,9,24),DateTime(2022,9,30),ItemType.ok);
  // await repo.editItemName("9eJaBxkUj0IAwoheQCdM","babobo");
  // await repo.editDueDate("9eJaBxkUj0IAwoheQCdM",DateTime(2022,10,2));
  // await repo.editType("9eJaBxkUj0IAwoheQCdM",ItemType.lost);
  // print((await repo.getItem("9eJaBxkUj0IAwoheQCdM")).dueDate);
  // await repo.deleteItem("9eJaBxkUj0IAwoheQCdM");
  // await userRepo.requestLogOut();

  //runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Application name
      title: 'Flutter Hello World',
      // Application theme data, you can set the colors for the application as
      // you want
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // A widget which will be started on application startup
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // The title text which will be shown on the action bar
        title: Text(title),
      ),
      body: Center(
        child: Text(
          'Hello, World!',
        ),
      ),
    );
  }
}
