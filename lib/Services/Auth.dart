import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:route_salesman_system/Models/AppUser.dart';

class AuthenticationService {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final User? currentUser = FirebaseAuth.instance.currentUser;

  Future SignInAnon()async{
    try{
      UserCredential  result = await _auth.signInAnonymously();
      User? user =  result.user;
      return user;
    } catch(e){
      print(e.toString()+" from auth services");
      return null;
    }
  }

  Future SignIn(String email , String password ) async{
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      dynamic user = result.user;
      return user;
    } catch (e){
          print(e.toString()+" *from auth services");
          return null;

        }
  }

  AppUser  getCurrentUser(){
    return  AppUser(currentUser?.email.toString(),currentUser?.displayName.toString(),currentUser?.phoneNumber.toString(),currentUser?.uid.toString(),);
  }

}