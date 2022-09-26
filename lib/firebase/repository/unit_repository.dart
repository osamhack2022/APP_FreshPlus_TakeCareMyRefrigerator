import 'package:cloud_firestore/cloud_firestore.dart';

class Unit {
  String unitID;
  String unitName;
  List<String> fridges;
  String master;
  int itemNum;
  int warningNum;
  int trashNum;
  int lostNum;
  int noHostNum;
  Unit(this.unitID, this.unitName, this.fridges, this.master,
  this.itemNum,this.warningNum,this.trashNum,this.lostNum,this.noHostNum);
}

class UnitRepositoryException {
  String code;
  UnitRepositoryException(this.code);
}

class UnitRepository {
  Future<void> addUnit(Unit unit) async {
    DocumentSnapshot unitSnapShot = await FirebaseFirestore.instance
        .collection('unit')
        .doc(unit.unitID)
        .get();
    var unitDoc = {
      'unitID': unit.unitID,
      'unitName': unit.unitName,
      'fridges': unit.fridges,
      'master': unit.master,
      'itemNum':0,
      'warningNum':0,
      'trashNum':0,
      'lostNum':0,
      'noHostNum':0,
    };
    if (unitSnapShot.exists == true) {
      throw UnitRepositoryException('already-exist');
    } else {
      await FirebaseFirestore.instance
          .collection('unit')
          .doc(unit.unitID)
          .set(unitDoc);
    }
  }

  Future<void> deleteUnit(String unitID) async {
    DocumentReference unitRef =
        FirebaseFirestore.instance.collection('unit').doc(unitID);
    unitRef.delete();
  }

  Future<void> editUnitName(String unitID, String unitName) async {
    await FirebaseFirestore.instance
        .collection('unit')
        .doc(unitID)
        .update({'unitName': unitName});
  }

  Future<void> editMaster(String unitID, String master) async {
    await FirebaseFirestore.instance
        .collection('unit')
        .doc(unitID)
        .update({'master': master});
  }
  //will be deleted soon
  Future<void> editItemNum(String unitID, int num) async {
    int numPast = (await FirebaseFirestore.instance
        .collection('unit').doc(unitID).get()).get('itemNum');
    await FirebaseFirestore.instance
        .collection('unit').doc(unitID).update({'itemNum': (numPast + num)});
  }

  Future<void> updateUnitStats(String unitID) async {
   DocumentReference unitRef = await FirebaseFirestore.instance
        .collection('unit').doc(unitID);
    if ((await unitRef.get()).exists == false)
      throw UnitRepositoryException('no-unit');
    QuerySnapshot query = await (unitRef.collection('fridges').get());
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
    await unitRef.update({
      'warningNum': warningNum,
      'trashNum': trashNum,
      'lostNum': lostNum,
      'noHostNum': noHostNum,
    });
  }
  Future<void> addFridges(String unitID, String fridgeID) async {
    await FirebaseFirestore.instance.collection('unit').doc(unitID).update({
      'fridges': FieldValue.arrayUnion([fridgeID])
    });
  }

  Future<void> deleteFridges(String unitID, String fridgeID) async {
    await FirebaseFirestore.instance.collection('unit').doc(unitID).update({
      'fridges': FieldValue.arrayRemove([fridgeID])
    });
  }

  Future<Unit> getUnit(String unitID) async {
    DocumentSnapshot unitSnapshot =
        await FirebaseFirestore.instance.collection('unit').doc(unitID).get();
    return Unit(
        unitSnapshot.get('unitID'),
        unitSnapshot.get('unitName'),
        unitSnapshot.get('fridges').cast<String>(), //List requires casting
        unitSnapshot.get('master'),
        unitSnapshot.get('itemNum'),
        unitSnapshot.get('warningNum'),
        unitSnapshot.get('trashNum'),
        unitSnapshot.get('lostNum'),
        unitSnapshot.get('noHostNum'),
        );
  }
}
