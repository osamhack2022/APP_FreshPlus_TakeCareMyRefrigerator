import '/firebase/repository/user_repository.dart';
import '../ctrl_exception.dart';
Future<void> resetPW(String email) async{
  try{
    await UserRepository().requestPasswordReset(email);
  } on UserRepositoryException catch(e){
    throw CtrlException(e.code);
  }
}