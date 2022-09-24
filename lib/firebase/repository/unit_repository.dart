import 'package:cloud_firestore/cloud_firestore.dart';

class Unit {
  String unitID;
  String unitName;
  List<String> fridges;
  String master;
  Unit(this.unitID, this.unitName, this.fridges, this.master);
}

class UnitRepositoryException {
  String code;
  UnitRepositoryException(this.code);
}

class UnitRepository {
  Future<void> addUnit(Unit unit) async {
    DocumentSnapshot unitSnapShot = await FirebaseFirestore.instance.collection('unit').doc(unit.unitID).get();
    var unitDoc = {
      'unitID' : unit.unitID,
      'unitName' : unit.unitName,
      'fridges' : unit.fridges,
      'master' :unit.master,
    };
    if(unitSnapShot.exists == true){
      throw UnitRepositoryException('already-exist');
    }
    else{
      await FirebaseFirestore
        .instance
        .collection('unit')
        .doc(unit.unitID)
        .set(unitDoc);
    }
  }


  Future<void> deleteUnit(String unitID) async {
    DocumentReference unitRef = FirebaseFirestore.instance.collection('unit').doc(unitID);
    unitRef.delete();
  }


  Future<void> editUnitName(String unitID,String unitName) async {
    await FirebaseFirestore
      .instance
      .collection('unit')
      .doc(unitID)
      .update({'unitName' : unitName});
  }


  Future<void> editMaster(String unitID,String master) async {
    await FirebaseFirestore
      .instance
      .collection('unit')
      .doc(unitID)
      .update({'master' : master});
  }


  Future<void> addFridges(String unitID, String fridgeID) async {
    await FirebaseFirestore
      .instance
      .collection('unit')
      .doc(unitID)
      .update({'fridges':FieldValue.arrayUnion([fridgeID])});
  }


  Future<void> deleteFridges(String unitID, String fridgeID) async {
    await FirebaseFirestore
      .instance
      .collection('unit')
      .doc(unitID)
      .update({'fridges':FieldValue.arrayRemove([fridgeID])});
  }

  
  Future<Unit> getUnit(String unitID) async {
    DocumentSnapshot unitSnapshot = await FirebaseFirestore
                                    .instance
                                    .collection('unit')
                                    .doc(unitID)
                                    .get();
    return Unit(unitSnapshot.get('unitID'),
      unitSnapshot.get('unitName'),
      unitSnapshot.get('fridges').cast<String>(), //List requires casting
      unitSnapshot.get('master'));
  }
}
