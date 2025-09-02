import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<UserCredential> registerWithEmail({
    required String email,
    required String password,
  }) async {
    return await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> sendEmailVerification(User user) async {
    await user.sendEmailVerification();
  }

  Future<void> saveUserData({
    required String uid,
    required String email,
    required String phone,
  }) async {
    await firestore.collection('users').doc(uid).set({
      'email': email,
      'phone': phone,
    });
  }

  Future<void> reloadUser(User user) async {
    await user.reload();
  }
}
