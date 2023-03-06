import 'package:firebase_auth/firebase_auth.dart';
import 'package:whatsapp/screens/model/users.dart';

class AuthService{
 
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Users? _userFromFirebaseUser(User? user){
    return user != null ? Users(uid: user.uid) : null;
  }
  // auth change user stream
  Stream<Users?> get user{
    return _auth.authStateChanges()
    .map(_userFromFirebaseUser);
  }
  //sign in anon
  Future signInAnon() async{
    try{
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebaseUser(user!);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //sign in with email and password
  Future signInWithEmailAndPassword(String Email,String Password) async{
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: Email, password: Password);
      User? user = result.user;
      return _userFromFirebaseUser(user!);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //register with email and password
  Future registerWithEmailAndPassword(String Email,String Password) async{
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: Email, password: Password);
      User? user = result.user;
      return _userFromFirebaseUser(user!);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  // forgot password
  Future reset(String email) async{
    try{
      return await _auth.sendPasswordResetEmail(email: email);
    }catch(e){
      print(e.toString());
      return null;
    }
  }
  
}