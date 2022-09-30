import 'package:cloud_firestore/cloud_firestore.dart';

class Fridge {
  String fridgeID;
  String fridgeName;
  int itemNum;
  String manager;
  List<String> users;
  int warningNum;
  int trashNum;
  int lostNum;
  int noHostNum;
  Fridge(this.fridgeID, this.fridgeName, this.itemNum, this.manager, this.users,
      this.warningNum, this.trashNum, this.lostNum, this.noHostNum);
}

class FridgeRepositoryException {
  String code;
  FridgeRepositoryException(this.code);
}

class FridgeRepository {
  String unitID;
  CollectionReference? fridgesRef;
  FridgeRepository(this.unitID);
  void init() {
    //https://firebase.google.com/docs/firestore/solutions/aggregation?hl=ko Control way for warningNum, trashNum
    fridgesRef = FirebaseFirestore.instance
        .collection('unit')
        .doc(unitID)
        .collection('fridges');
  }

  Future<void> addFridge(Fridge fridge) async {
    DocumentSnapshot fridgeSnapShot =
        await fridgesRef!.doc(fridge.fridgeID).get();
    var fridgeDoc = {
      'fridgeID': fridge.fridgeID,
      'fridgeName': fridge.fridgeName,
      'itemNum': fridge.itemNum,
      'manager': fridge.manager,
      'users': fridge.users,
      'warningNum': 0,
      'trashNum': 0,
      'lostNum': 0,
      'noHostNum': 0,
    };
    if (fridgeSnapShot.exists == true) {
      throw FridgeRepositoryException('already-exist');
    } else {
      await fridgesRef!.doc(fridge.fridgeID).set(fridgeDoc);
    }
  }

  Future<void> deleteFridge(String fridgeID) async {
    DocumentReference fridgeRef = FirebaseFirestore.instance
        .collection('unit')
        .doc(unitID)
        .collection('fridges')
        .doc(fridgeID);
    fridgeRef.delete();
  }

  Future<void> editFridgeName(String fridgeID, String fridgeName) async {
    await fridgesRef!.doc(fridgeID).update({"fridgeName": fridgeName});
  }

  //will be deleted soon
  Future<void> editItemNum(String fridgeID, int num) async {
    int numPast = (await fridgesRef!.doc(fridgeID).get()).get('itemNum');
    await fridgesRef!.doc(fridgeID).update({'itemNum': (numPast + num)});
  }

  Future<void> updateFridgeStats(String fridgeID) async {
    DocumentReference fridgeRef = await fridgesRef!.doc(fridgeID);
    if ((await fridgeRef.get()).exists == false)
      throw FridgeRepositoryException('no-fridge');
    QuerySnapshot query = await (fridgeRef.collection('userBoxes').get());
    int warningNum = 0;
    int trashNum = 0;
    int lostNum = 0;
    int noHostNum = 0;
    query.docs.forEach((doc) {
      warningNum += doc.get('warningNum') as int;
      trashNum += doc.get('trashNum') as int;
      lostNum += doc.get('lostNum') as int;
      noHostNum += doc.get('noHostNum') as int;
    });
    await fridgeRef.update({
      'warningNum': warningNum,
      'trashNum': trashNum,
      'lostNum': lostNum,
      'noHostNum': noHostNum,
    });
  }

  Future<void> editManager(String fridgeID, String manager) async {
    await fridgesRef!.doc(fridgeID).update({'manager': manager});
  }

  Future<void> addUsers(String fridgeID, String uid) async {
    await fridgesRef!.doc(fridgeID).update({
      'users': FieldValue.arrayUnion([uid])
    });
  }

  Future<void> deleteUsers(String fridgeID, String uid) async {
    await fridgesRef!.doc(fridgeID).update({
      'users': FieldValue.arrayRemove([uid])
    });
  }
  Future<bool> existFridge(String fridgeID) async{
    DocumentSnapshot fridgeSnapshot = await fridgesRef!.doc(fridgeID).get();
    if(fridgeSnapshot.exists==true) return true;
    else return false;
  }
  Future<Fridge> getFridge(String fridgeID) async {
    DocumentSnapshot fridgeSnapshot = await fridgesRef!.doc(fridgeID).get();
    if(fridgeSnapshot.exists==false) throw FridgeRepositoryException('no-fridge');
    return Fridge(
      fridgeSnapshot.get('fridgeID'),
      fridgeSnapshot.get('fridgeName'),
      fridgeSnapshot.get('itemNum'),
      fridgeSnapshot.get('manager'),
      fridgeSnapshot.get('users').cast<String>(),
      fridgeSnapshot.get('warningNum'),
      fridgeSnapshot.get('trashNum'),
      fridgeSnapshot.get('lostNum'),
      fridgeSnapshot.get('noHostNum'),
    );
  }
}
