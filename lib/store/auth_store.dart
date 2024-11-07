import 'package:mobx/mobx.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'auth_store.g.dart'; 

class AuthStore = _AuthStore with _$AuthStore;

abstract class _AuthStore with Store {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @observable
  User? user; // Almacena el usuario autenticado

  @action
  Future<void> signIn(String email, String password) async {
    try {
      UserCredential credential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user =
          credential.user; 
    } catch (e) {
      user = null; 
    }
  }

  @action
  Future<void> register(String email, String password) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
    } catch (e) {
      user = null;
    }
  }

  @action
  Future<void> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      
    } catch (e) {
      throw Exception(
          "Error al enviar el correo de restablecimiento: ${e.toString()}");
    }
  }

  @action
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    user = null; 
  }
}
