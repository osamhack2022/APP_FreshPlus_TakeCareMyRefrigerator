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
    var user_doc = {
      'uid': user.uid,
      'email': user.email,
      'serialNum': user.serialNum,
      'userName': user.userName,
      'unitID': user.unitID,
      'fridgeID': user.fridgeID
    };
    switch (user.type) {
      case (UserType.master):
        user_doc['type'] = 'master';
        break;
      //manager class can be deleted soon, to get info about manager
      //you may use fridge entity
      case (UserType.manager):
        user_doc['type'] = 'manager';
        break;
      case (UserType.user):
        user_doc['type'] = 'user';
        break;
    }

    //set user dictionary data
    await FirebaseFirestore.instance
        .collection("user")
        .doc(user.uid)
        .set(user_doc);
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

  void editUser(User user) async {
    var user_doc = {
      'uid': user.uid,
      'email': user.email,
      'serialNum': user.serialNum,
      'userName': user.userName,
      'unitID': user.unitID,
      'fridgeID': user.fridgeID
    };
    switch (user.type) {
      case (UserType.master):
        user_doc['type'] = 'master';
        break;
      //manager class can be deleted soon, to get info about manager
      //you may use fridge entity
      case (UserType.manager):
        user_doc['type'] = 'manager';
        break;
      case (UserType.user):
        user_doc['type'] = 'user';
        break;
    }
    DocumentReference user_doc_past =
        await FirebaseFirestore.instance.collection('user').doc(user.uid);
    DocumentSnapshot snapshot = await user_doc_past.get();
    if (snapshot.exists == false) throw UserRepositoryException("no-user");
    await user_doc_past.set(user_doc);
  }

  Future<User> getUser(String uid) async {
    DocumentSnapshot user_doc =
        await FirebaseFirestore.instance.collection('user').doc(uid).get();
    UserType type_enum = UserType.user;
    switch (user_doc.get('type')) {
      case ("manager"):
        type_enum = UserType.manager;
        break;
      case ("master"):
        type_enum = UserType.master;
        break;
    }
    return User(
        (user_doc.get('uid')),
        user_doc.get('email'),
        user_doc.get('serialNum'),
        user_doc.get('userName'),
        user_doc.get('unitID'),
        user_doc.get('fridgeID'),
        type_enum);
  }

  Future<void> requestLogIn(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
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
  }

  Future<void> requestPasswordReset(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
}
