import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

enum UserType { master, manager, user }

class User {
  String uid;
  String email;
  String serialNum;
  String userName;
  String unitID;
  String fridgeID;
  UserType type;
  User(this.uid, this.email, this.serialNum, this.userName, this.unitID,
      this.fridgeID, this.type);
}

class UserRepositoryException {
  String code;
  UserRepositoryException(this.code);
}

class UserRepository {
  Future<void> addUser(User user, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: user.email, password: password);
      if (credential.user == null)
        throw UserRepositoryException("no-user");
      else
        user.uid = credential.user!.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw UserRepositoryException("weak-password");
      } else if (e.code == 'email-already-in-use') {
        throw UserRepositoryException('email-already-in-use');
      } else {
        throw UserRepositoryException("unknown-firebase-auth-exception");
      }
    } catch (e) {
      throw UserRepositoryException("unknown-firebase-exception");
    }
    var userDoc = {
      'uid': user.uid,
      'email': user.email,
      'serialNum': user.serialNum,
      'userName': user.userName,
      'unitID': user.unitID,
      'fridgeID': user.fridgeID
    };
    switch (user.type) {
      case (UserType.master):
        userDoc['type'] = 'master';
        break;
      //manager class can be deleted soon, to get info about manager
      //you may use fridge entity
      case (UserType.manager):
        userDoc['type'] = 'manager';
        break;
      case (UserType.user):
        userDoc['type'] = 'user';
        break;
    }

    //set user dictionary data
    await FirebaseFirestore.instance
        .collection("user")
        .doc(user.uid)
        .set(userDoc);
  }

  //delete currentUser
  Future<void> deleteUser() async {
    String? email;
    if (FirebaseAuth.instance.currentUser != null) {
      email = FirebaseAuth.instance.currentUser!.email;
      await FirebaseAuth.instance.currentUser!.delete();
    } else
      throw UserRepositoryException("no-user");
    if (email != null) {
      var uid = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance.collection('user').doc(uid).delete();
    } else
      throw UserRepositoryException('no-email');
  }

  Future<void> editUserName(String uid, String name) async{
    DocumentSnapshot userSnapshot = 
        await FirebaseFirestore.instance.collection('user').doc(uid).get();
    if(userSnapshot.exists==false) throw UserRepositoryException('no-user');
    await FirebaseFirestore.instance.collection('user').doc(uid).update({
      'name':name
    });
  }
  Future<void> editUserType(String uid, UserType type) async{
    String userType;
    switch (type) {
      case (UserType.master):
        userType = 'master';
        break;
      case (UserType.manager):
        userType = 'manager';
        break;
      default:
        userType = 'user';
        break;
    }
    DocumentSnapshot userSnapshot = 
        await FirebaseFirestore.instance.collection('user').doc(uid).get();
    if(userSnapshot.exists==false) throw UserRepositoryException('no-user');
    await FirebaseFirestore.instance.collection('user').doc(uid).update({
      'type':userType
    });
  }
  //double check required?
  Future<User> getUser(String uid) async {
    DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('user').doc(uid).get();
    UserType type_enum = UserType.user;
    switch (userDoc.get('type')) {
      case ("manager"):
        type_enum = UserType.manager;
        break;
      case ("master"):
        type_enum = UserType.master;
        break;
    }
    return User(
        (userDoc.get('uid')),
        userDoc.get('email'),
        userDoc.get('serialNum'),
        userDoc.get('userName'),
        userDoc.get('unitID'),
        userDoc.get('fridgeID'),
        type_enum);
  }

  Future<String> requestLogIn(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (credential.user == null)
        throw (UserRepositoryException('fail-login'));
      return credential.user!.uid;
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'user-not-found') {
        throw UserRepositoryException('no-user');
      } else if (e.code == 'wrong-password') {
        throw UserRepositoryException('wrong-password');
      } else {
        throw UserRepositoryException('firebase-error');
      }
    } catch (e) {
      throw UserRepositoryException('unknown-error');
    }
  }

  Future<void> requestLogOut() async {
    await FirebaseAuth.instance.signOut();
    print("Successfully logout");
  }

  Future<void> requestPasswordReset(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
}
