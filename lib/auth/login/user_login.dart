import 'package:flutter/material.dart';
import 'package:gluteno/auth/forget_pass_user/forget_pass_user.dart';
import 'package:gluteno/auth/sign_up/sign_up.dart';
import 'package:gluteno/classes/colors.dart';
import 'package:gluteno/screens/user/navigation.dart';
import 'package:gluteno/utils/responsive_size_helper.dart';
import 'package:gluteno/widgets/app_text.dart';
import 'package:gluteno/widgets/buttons.dart';
import 'package:gluteno/widgets/text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserLoginPage extends StatefulWidget {
  const UserLoginPage({super.key});

  @override
  State<UserLoginPage> createState() => _UserLoginPageState();
}

class _UserLoginPageState extends State<UserLoginPage> {
  final TextEditingController passController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  bool loading = false;

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Future<void> onLoginPressed() async {
    final email = emailController.text.trim();
    final password = passController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      showSnackBar("Please fill all fields");
      return;
    }

    setState(() => loading = true);

    try {
      final cred = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final uid = cred.user!.uid;

      final doc = await firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Navigation()),
        );
      } else {
        await auth.signOut();
        showSnackBar("User not found. Please sign up first.");
      }
    } on FirebaseAuthException catch (_) {
      showSnackBar("User not found. Please check your credentials.");
    } catch (_) {
      showSnackBar("An unexpected error occurred");
    } finally {
      setState(() => loading = false);
    }
  }

  Future<void> onGoogleLogin() async {
    try {
      final googleSignIn = GoogleSignIn();
      await googleSignIn.signOut();

      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        showSnackBar("Google Sign-In cancelled");
        return;
      }

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCred =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final uid = userCred.user!.uid;

      final doc = await firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Navigation()),
        );
      } else {
        await FirebaseAuth.instance.signOut();
        showSnackBar(
            "This Google account is not registered. Please sign up first.");
      }
    } catch (e) {
      showSnackBar("Google Sign-In failed: ${e.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3DFDF),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: responsiveWidth(context, 700),
              height: responsiveHeight(context, 950),
              decoration: const BoxDecoration(color: AppColors.btnColor),
              child: Stack(
                children: [
                  Positioned(
                    top: responsiveHeight(context, -50),
                    left: responsiveWidth(context, 20),
                    child: Image.asset(
                      "assets/images/logoo.png",
                      width: responsiveWidth(context, 400),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Image.asset("assets/images/user_login_bottom.png"),
                  ),
                  Positioned(
                    top: responsiveHeight(context, 280),
                    left: responsiveWidth(context, 180),
                    child: const CustomAppText(
                      text: "Login",
                      fontSize: 24,
                      color: AppColors.textColor,
                    ),
                  ),
                  Positioned(
                    top: responsiveHeight(context, 460),
                    left: responsiveWidth(context, 20),
                    right: responsiveWidth(context, 20),
                    child: Column(
                      children: [
                        CustomTextField(
                          textEditingController: emailController,
                          obscureText: false,
                          label: "Email",
                          icon: const Icon(Icons.person_2_outlined),
                        ),
                        SizedBox(height: responsiveHeight(context, 20)),
                        CustomTextField(
                          textEditingController: passController,
                          obscureText: true,
                          isPassword: true,
                          label: "Password",
                          icon: const Icon(Icons.lock_outline),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24.0),
                          child: loading
                              ? const CircularProgressIndicator()
                              : CustomButton(
                                  text: "Login",
                                  onTap: onLoginPressed,
                                  height: 35,
                                  width: 100,
                                  isTextUnderlined: false,
                                ),
                        ),
                        SizedBox(height: responsiveHeight(context, 10)),
                        GestureDetector(
                          onTap: onGoogleLogin,
                          child: Container(
                            height: responsiveHeight(context, 40),
                            width: responsiveWidth(context, 40),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: const CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/images/google.jpg'),
                            ),
                          ),
                        ),
                        SizedBox(height: responsiveHeight(context, 20)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CustomAppText(
                              text: "Forgot ",
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ForgetPassword()),
                                );
                              },
                              child: const CustomAppText(
                                text: "Password?",
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: Colors.blueGrey,
                                isUnderlined: true,
                                underlineColor: Colors.blueGrey,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: responsiveHeight(context, 20)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CustomAppText(
                              text: "Don't Have An Account? ",
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const SignUpPage()),
                                );
                              },
                              child: const CustomAppText(
                                text: "Sign Up",
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: Colors.blueGrey,
                                isUnderlined: true,
                                underlineColor: Colors.blueGrey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
