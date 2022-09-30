import '../repository/user_repository.dart';
import '../repository/unit_repository.dart';
import '../repository/fridge_repository.dart';
import '../ctrl_exception.dart';

String admin_email = "admin";
String admin_password = "adminadmin";
/*
Future<List<String>> getFridgeList
It requests FridgeList List<String> on unitID
Possible Error code
[fail-login,user-not-found,wrong-password,firebase-error,unknown-error,no-unit]
*/
Future<List<String>> getFridgeList(String unitID) async {
  try{
    UserRepository repo = UserRepository();
    UnitRepository unit_repo = UnitRepository();
    await repo.requestLogIn(admin_email,admin_password);
    Unit unit = await unit_repo.getUnit(unitID);
    repo.requestLogOut();
    return unit.fridges;
  } on UserRepositoryException catch(e){
    throw CtrlException(e.code);
  } on UnitRepositoryException catch(e){
    throw CtrlException(e.code);
  } catch(e){
    throw CtrlException('unknown-error');
  }
}
Future<String> signUp(
  String email, 
  String password,
  String name, 
  String unitID, 
  String fridgeID, 
  String userType) 
async {
  UserType type = UserType.user;
  //Validity Check
  UserRepository repo = UserRepository();
  UnitRepository unit_repo = UnitRepository();
  FridgeRepository fridge_repo = FridgeRepository(unitID);
  fridge_repo.init();
  try{
    await repo.requestLogIn(admin_email,admin_password);
  } on UserRepositoryException catch(e){
    CtrlException(e.code);
  }
  if(userType=="master"){
    try{
      type = UserType.master;
      await unit_repo.getUnit(unitID);
      throw CtrlException("unit-exist");
    } on UnitRepositoryException catch(e){
      if(e.code!='no-unit') throw CtrlException("unknown-error");
    }
  }
  else if(userType=="manager"){
    try{
      type = UserType.manager;
      await unit_repo.getUnit(unitID);
      Fridge fridge = await fridge_repo.getFridge(fridgeID);
      if(fridge.manager!="") throw CtrlException('manager-exist');
    } on UnitRepositoryException catch(e){
      CtrlException(e.code);
    } on FridgeRepositoryException catch(e){
      CtrlException(e.code);
    } catch (e){  
      CtrlException(e.code);
    }
  }
  else{
    try{
      await unit_repo.getUnit(unitID);
      await fridge_repo.getFridge(fridgeID);
    } on UnitRepositoryException catch(e){
      CtrlException(e.code);
    } on FridgeRepositoryException catch(e){
      CtrlException(e.code);
    } catch (e){  
      CtrlException(e.code);
    }
  }
  repo.requestLogOut();

  try{
    String uid = await repo.addUser(
      User(
        "",
        email,
        "",
        name,
        unitID,
        fridgeID,
        type
      ),
      password
    );

    if(userType=="master"){
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
    }
    else if(userType=="manager"){
      //editManager
      await fridge_repo.editManager(fridgeID,uid);
    }
    else{
      //addUsers
      await fridge_repo.addUsers(fridgeID,uid);
      //addUserBox
      UserBoxRepository userboxRepo = UserBoxRepository(unitID,fridgeID);
      await userboxRepo.addUserBox(UserBox(
        uid,
        0,
        [],
        0,
        0,
        0
      ));
    }
  } on UserRepositoryException catch(e){
    throw CtrlException(e.code);
  }on UnitRepositoryExcception catch(e){
    throw CtrlException(e.code);
  } on FridgeRepositoryException catch(e){
    throw CtrlException(e.code);
  } on UserBoxRepositoryException(e.code){
    throw CtrlException(e.code);
  } catch(e){
    throw CctrlException('unknown-error');
  }
  return uid;
}
