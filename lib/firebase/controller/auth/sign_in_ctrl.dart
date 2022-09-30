import '/firebase/repository/user_repository.dart';
import '../ctrl_exception.dart';

/*
Future<String> signIn(String email, String password)
Using email and password, request SignIn to Firebase and return uid
It can throw error code ["no-user","wrong-password","firebase-error","unknown-error"]
*/
Future<String> signIn(String email, String password) async {
    try{
        return await UserRepository().requestLogIn(email,password);
    } on UserRepositoryException catch(e){
      throw CtrlException(e.code);
    }
}

