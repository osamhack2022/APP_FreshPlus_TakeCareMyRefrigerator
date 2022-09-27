import 'package:cloud_firestore/cloud_firestore.dart';

class UserBox {
  String uid;
  int itemNum;
  List<String> items;
  int warningNum;
  int trashNum;
  int lostNum;
  UserBox(this.uid, this.itemNum, this.items, this.warningNum, this.trashNum,
      this.lostNum);
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
    if (userBoxesRef == null)
      throw UserBoxRepositoryException("null-userBoxes");
  }

  Future<void> addUserBox(UserBox userBox) async {
    DocumentSnapshot userBoxSnapshot =
        await userBoxesRef!.doc(userBox.uid).get();
    var userBoxDoc = {
      'uid': userBox.uid,
      'itemNum': userBox.itemNum,
      'items': [],
      'warningNum': 0,
      'trashNum': 0,
      'lostNum': 0,
    };
    if (userBoxSnapshot.exists == true) {
      throw UserBoxRepositoryException('already-exist');
    } else {
      await userBoxesRef!.doc(userBox.uid).set(userBoxDoc);
    }
  }

  Future<void> deleteUserBox(String uid) async {
    DocumentReference userBoxRef = userBoxesRef!.doc(uid);
    userBoxRef.delete();
  }
  //will be deleted soon
  Future<void> editItemNum(String uid, int num) async {
    DocumentSnapshot userBoxSnapshot = await userBoxesRef!.doc(uid).get();
    if (userBoxSnapshot.exists == false)
      throw UserBoxRepositoryException('no-userbox');
    int numPast = userBoxSnapshot.get('itemNum');
    await userBoxesRef!.doc(uid).update({'itemNum': (numPast + num)});
  }

  Future<void> updateUserStats(String uid) async {
    DocumentReference userBoxRef = await userBoxesRef!.doc(uid);
    if ((await userBoxRef.get()).exists == false)
      throw UserBoxRepositoryException('no-userbox');
    int warningNum = (await (userBoxesRef!
                .doc(uid)
                .collection('items')
                .where("itemType", isEqualTo: "warning"))
            .get())
        .size;
    int trashNum = (await (userBoxesRef!
                .doc(uid)
                .collection('items')
                .where("itemType", isEqualTo: "trash"))
            .get())
        .size;
    int lostNum = (await (userBoxesRef!
                .doc(uid)
                .collection('items')
                .where("itemType", isEqualTo: "lost"))
            .get())
        .size;
    await userBoxRef.update(
        {'warningNum': warningNum, 'trashNum': trashNum, 'lostNum': lostNum});
  }

  Future<void> addItems(String uid, String itemID) async {
    await userBoxesRef!.doc(uid).update({
      'itemList': FieldValue.arrayUnion([itemID])
    });
  }

  Future<void> deleteItems(String uid, String itemID) async {
    await userBoxesRef!.doc(uid).update({
      'itemList': FieldValue.arrayRemove([itemID])
    });
  }

  Future<UserBox> getUserBox(String uid) async {
    DocumentSnapshot userBoxSnapshot = await userBoxesRef!.doc(uid).get();
    if (userBoxSnapshot.exists == false)
      throw UserBoxRepositoryException('no-userbox');
    return UserBox(userBoxSnapshot.get('uid'), userBoxSnapshot.get('itemNum'),
        userBoxSnapshot.get('items').cast<String>(),
        userBoxSnapshot.get('warningNum'),userBoxSnapshot.get('trashNum'),
        userBoxSnapshot.get('lostNum'));
  }
}
