import 'package:cloud_firestore/cloud_firestore.dart';

class Fridge {
  String fridgeID;
  String fridgeName;
  int itemNum;
  String manager;
  List<String> users;
  int warningNum;
  int trashNum;
  Fridge(this.fridgeID, this.fridgeName, this.itemNum, this.manager, this.users,
      this.warningNum, this.trashNum);
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
        .collection('fridges').doc(fridgeID);
    fridgeRef.delete();
  }

  Future<void> editFridgeName(String fridgeID, String fridgeName) async {
    await fridgesRef!
    .doc(fridgeID)
    .update({"fridgeName": fridgeName});
  }

  Future<void> editItemNum(String fridgeID, int num) async {
    int numPast = (await fridgesRef!.doc(fridgeID).get()).get('itemNum');
    await fridgesRef!.doc(fridgeID).update({'itemNum': (numPast + num)});
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

  Future<Fridge> getFridge(String fridgeID) async {
    DocumentSnapshot fridgeSnapshot = 
      await fridgesRef!
        .doc(fridgeID)
        .get();
    return Fridge(
      fridgeSnapshot.get('fridgeID'),
      fridgeSnapshot.get('fridgeName'),
      fridgeSnapshot.get('itemNum'),
      fridgeSnapshot.get('manager'),
      fridgeSnapshot.get('users').cast<String>(),
      fridgeSnapshot.get('warningNum'),
      fridgeSnapshot.get('trashNum'),
    );
  }
}
