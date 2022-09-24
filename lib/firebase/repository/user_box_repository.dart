import 'package:cloud_firestore/cloud_firestore.dart';

class UserBox {
  String uid;
  int itemNum;
  List<String> items;
  UserBox(this.uid, this.itemNum, this.items);
}

class UserBoxRepositoryException {
  String code;
  UserBoxRepositoryException(this.code);
}

class UserBoxRepository {
  String unitID;
  String fridgeID;
  CollectionReference? userBoxesRef;
  UserBoxRepository(this.unitID, this.fridgeID);
  void init() {
    //https://firebase.google.com/docs/firestore/solutions/aggregation?hl=ko Control way for warningNum, trashNum
    userBoxesRef = FirebaseFirestore.instance
        .collection('unit')
        .doc(unitID)
        .collection('fridges')
        .doc(fridgeID)
        .collection('userBoxes');
    if(userBoxesRef==null) throw UserBoxRepositoryException("null-userBoxes");
  }
  Future<void> addUserBox(UserBox userBox) async{
    DocumentSnapshot userBoxSnapshot =
        await userBoxesRef!.doc(userBox.uid).get();
    var userBoxDoc = {
      'uid':userBox.uid,
      'itemNum':userBox.itemNum,
      'items':userBox.items
    };
    if (userBoxSnapshot.exists == true) {
      throw UserBoxRepositoryException('already-exist');
    } else {
      await userBoxesRef!.doc(userBox.uid).set(userBoxDoc);
    }
  }
  Future<void> deleteUserBox(String uid) async{
      DocumentReference userBoxRef = userBoxesRef!.doc(uid);
      userBoxRef.delete();
  }
  Future<void> editItemNum(String uid, int num) async{
    DocumentSnapshot userBoxSnapshot = await userBoxesRef!.doc(uid).get();
    if(userBoxSnapshot.exists==false) throw UserBoxRepositoryException('no-userbox');
    int numPast = userBoxSnapshot.get('itemNum');
    await userBoxesRef!.doc(uid).update({'itemNum':(numPast+num)});
  }
  Future<void> addItems(String uid,String itemID) async{
    await userBoxesRef!.doc(uid).update({
      'itemList':FieldValue.arrayUnion([itemID])
    });
  }
  Future<void> deleteItems(String uid,String itemID) async{
    await userBoxesRef!.doc(uid).update({
      'itemList':FieldValue.arrayRemove([itemID])
    });
  }
  Future<UserBox> getUserBox(String uid) async{
      DocumentSnapshot userBoxSnapshot = 
        await userBoxesRef!
          .doc(uid)
          .get();
      if(userBoxSnapshot.exists==false) throw UserBoxRepositoryException('no-userbox');
      return UserBox(
        userBoxSnapshot.get('uid'),
        userBoxSnapshot.get('itemNum'),
        userBoxSnapshot.get('items').cast<String>()
      );
  }
}
