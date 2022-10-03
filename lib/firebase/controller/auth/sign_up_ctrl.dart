import '/firebase/repository/user_repository.dart';
import '/firebase/repository/unit_repository.dart';
import '/firebase/repository/fridge_repository.dart';
import '/firebase/repository/user_box_repository.dart';
import '../ctrl_exception.dart';

String adminEmail = "admin@admin.io";
String adminPassword = "adminadmin";
/*
Future<List<String>> getFridgeList
It requests FridgeList List<String> on unitID
Possible Error code
[fail-login,user-not-found,wrong-password,firebase-error,unknown-error,no-unit]
*/
Future<List<String>> getFridgeList(String unitID) async {
  try {
    UserRepository repo = UserRepository();
    UnitRepository unit_repo = UnitRepository();
    await repo.requestLogIn(adminEmail, adminPassword);
    Unit unit = await unit_repo.getUnit(unitID);
    return unit.fridges;
  } on UserRepositoryException catch (e) {
    throw CtrlException(e.code);
  } on UnitRepositoryException catch (e) {
    throw CtrlException(e.code);
  } catch (e) {
    throw CtrlException('unknown-error');
  }
}

Future<String> signUp(String email, String password, String name, String unitID,
    String fridgeID, String userType) async {
  String uid;
  UserType type = UserType.user;
  //Validity Check
  UserRepository repo = UserRepository();
  UnitRepository unit_repo = UnitRepository();
  FridgeRepository fridge_repo = FridgeRepository(unitID);
  fridge_repo.init();
  try {
    await repo.requestLogIn(adminEmail, adminPassword);
  } on UserRepositoryException catch (e) {
    CtrlException(e.code);
  }
  if (userType == "master") {
    try {
      type = UserType.master;
      if ((await unit_repo.existUnit(unitID)) == true) {
        await repo.requestLogOut();
        throw CtrlException('unit-exists');
      }
    } catch (e) {
      await repo.requestLogOut();
      throw CtrlException('unknown-error');
    }
  } else if (userType == "manager") {
    try {
      type = UserType.manager;
      if ((await unit_repo.existUnit(unitID)) == false) {
        throw CtrlException('no-unit');
      }
      Fridge fridge = await fridge_repo.getFridge(fridgeID);
      await repo.requestLogOut();
      if (fridge.manager != "") throw CtrlException('manager-exist');
    } on FridgeRepositoryException catch (e) {
      await repo.requestLogOut();
      throw CtrlException(e.code);
    } catch (e) {
      await repo.requestLogOut();
      throw CtrlException("unknown-error");
    }
  } else {
    try {
      if ((await unit_repo.existUnit(unitID)) == false) {
        throw CtrlException('no-unit');
      }
      if ((await fridge_repo.existFridge(unitID)) == false) {
        throw CtrlException('no-fridge');
      }
      await repo.requestLogOut();
    } catch (e) {
      await repo.requestLogOut();
      CtrlException("unknown-error");
    }
  }
  try {
    uid = await repo.addUser(
        User("", email, "", name, unitID, fridgeID, type), password);
    print(3);
    if (userType == "master") {
      //addUnit
      await unit_repo.addUnit(Unit(
        unitID,
        "",
        [],
        uid,
        0,
        0,
        0,
        0,
        0,
      ));
    } else if (userType == "manager") {
      //editManager
      await fridge_repo.editManager(fridgeID, uid);
      UserBoxRepository userboxRepo = UserBoxRepository(unitID, fridgeID);
      userboxRepo.init();
      await userboxRepo.addUserBox(UserBox(uid, 0, [], 0, 0, 0));
    } else {
      //addUsers
      await fridge_repo.addUsers(fridgeID, uid);
      //addUserBox
      UserBoxRepository userboxRepo = UserBoxRepository(unitID, fridgeID);
      userboxRepo.init();
      await userboxRepo.addUserBox(UserBox(uid, 0, [], 0, 0, 0));
    }
  } on UserRepositoryException catch (e) {
    throw CtrlException(e.code);
  } on UnitRepositoryException catch (e) {
    throw CtrlException(e.code);
  } on FridgeRepositoryException catch (e) {
    throw CtrlException(e.code);
  } on UserBoxRepositoryException catch (e) {
    throw CtrlException(e.code);
  } catch (e) {
    throw CtrlException('unknown-error');
  }
  return uid;
}
