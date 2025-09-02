import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gluteno/classes/colors.dart';
import 'package:gluteno/auth/login/user_login.dart';
import 'package:gluteno/service/auth_service.dart';
import 'package:gluteno/utils/responsive_size_helper.dart';
import 'package:gluteno/widgets/app_text.dart';
import 'package:gluteno/widgets/buttons.dart';
import 'package:gluteno/widgets/text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  final AuthService authService = AuthService();
  String? pendingPhone;
  String? pendingPassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/backgrouunnd.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: responsiveWidth(context, 20),
              vertical: responsiveHeight(context, 50),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/logoo.png",
                  width: responsiveWidth(context, 200),
                ),
                SizedBox(height: responsiveHeight(context, 20)),
                const CustomAppText(
                  text: "Sign Up",
                  fontSize: 24,
                  color: AppColors.textColor,
                ),
                SizedBox(height: responsiveHeight(context, 20)),
                CustomTextField(
                  textEditingController: emailController,
                  obscureText: false,
                  isPassword: false,
                  label: "Email",
                  icon: Icon(Icons.email_outlined),
                ),
                CustomTextField(
                  textEditingController: phoneController,
                  obscureText: false,
                  isPassword: false,
                  label: "Phone Number (10 digits)",
                  icon: Icon(Icons.phone_outlined),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ],
                ),
                CustomTextField(
                  textEditingController: passwordController,
                  obscureText: true,
                  isPassword: true,
                  label: "Password",
                  icon: Icon(Icons.lock_outline),
                ),
                CustomTextField(
                  textEditingController: confirmController,
                  obscureText: true,
                  isPassword: true,
                  label: "Confirm Password",
                  icon: Icon(Icons.lock_outline),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomAppText(
                        text: "---- OR ---- ",
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: onGoogleSignUp,
                  child: Container(
                    height: responsiveHeight(context, 40),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          spreadRadius: 2,
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const CircleAvatar(
                      backgroundImage: AssetImage('assets/images/google.jpg'),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: CustomButton(
                    text: "Sign Up",
                    onTap: onSignUpPressed,
                    height: 30,
                    width: 100,
                    isTextUnderlined: false,
                    buttonColor: AppColors.scaffoldBackground,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomAppText(
                      text: "Already Have An Account? ",
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const UserLoginPage()),
                        );
                      },
                      child: CustomAppText(
                        text: "Login",
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey,
                        isUnderlined: true,
                        underlineColor: Colors.blueGrey,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> checkIfUserExists(String email, String phone) async {
    final users = FirebaseFirestore.instance.collection('users');
    final emailQuery = await users.where('email', isEqualTo: email).get();
    if (emailQuery.docs.isNotEmpty) return true;
    final phoneQuery = await users.where('phone', isEqualTo: phone).get();
    if (phoneQuery.docs.isNotEmpty) return true;
    return false;
  }

  void onSignUpPressed() async {
    final email = emailController.text.trim();
    final phone = phoneController.text.trim();
    final password = passwordController.text.trim();
    final confirm = confirmController.text.trim();

    if (email.isEmpty || phone.isEmpty || password.isEmpty || confirm.isEmpty) {
      showSnackBar("Please fill all fields");
      return;
    }
    if (!email.contains("@") && !email.contains(".")) {
      showSnackBar("Email must contain @ and .");
      return;
    }
    if (phone.length != 10 || !phone.startsWith('07')) {
      showSnackBar("Phone number must be exactly 10 digits and start with 07");
      return;
    }
    final passwordRegex = RegExp(
        r'''^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$%^&*()_\+\-=\[\]{};:'"\\|,.<>\/?])[A-Za-z\d!@#\$%^&*()_\+\-=\[\]{};:'"\\|,.<>\/?]{6,}$''');
    if (!passwordRegex.hasMatch(password)) {
      showSnackBar(
          "Password must be at least 6 characters, include a capital letter, a small letter, number and symbols.");
      return;
    }
    if (password != confirm) {
      showSnackBar("Passwords do not match");
      return;
    }

    final exists = await checkIfUserExists(email, phone);
    if (exists) {
      showSnackBar("Email or phone already signed up");
      return;
    }

    try {
      final cred = await authService.registerWithEmail(
        email: email,
        password: password,
      );
      await authService.sendEmailVerification(cred.user!);
      pendingPhone = phone;
      pendingPassword = password;
      showVerifyDialog();
    } on FirebaseAuthException catch (e) {
      showSnackBar(e.message ?? "Registration failed");
    }
  }

  void showVerifyDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: Text("Verify Your Email"),
        content: Text(
          "A verification link has been sent to your email. Please click the link to verify your account.",
        ),
        actions: [
          TextButton(
            onPressed: () async {
              final user = FirebaseAuth.instance.currentUser;
              if (user != null) {
                await user.reload();
                final updatedUser = FirebaseAuth.instance.currentUser;
                if (updatedUser != null && updatedUser.emailVerified) {
                  if (pendingPhone != null && pendingPassword != null) {
                    await authService.saveUserData(
                      uid: updatedUser.uid,
                      email: updatedUser.email!,
                      phone: pendingPhone!,
                    );
                  }
                  Navigator.of(context).pop();
                  navigateToLogin();
                } else {
                  showSnackBar("Email not verified yet");
                }
              }
            },
            child: Text("I have verified"),
          ),
        ],
      ),
    );
  }

  void navigateToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const UserLoginPage()),
    );
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void onGoogleSignUp() async {
    try {
      await GoogleSignIn().disconnect();
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        showSnackBar("Google Sign-In cancelled");
        return;
      }
      final users = FirebaseFirestore.instance.collection('users');
      final emailQuery =
          await users.where('email', isEqualTo: googleUser.email).get();
      if (emailQuery.docs.isNotEmpty) {
        showSnackBar("This Google account is already signed up");
        return;
      }
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final userCred =
          await FirebaseAuth.instance.signInWithCredential(credential);
      await authService.saveUserData(
        uid: userCred.user!.uid,
        email: userCred.user!.email ?? '',
        phone: userCred.user!.phoneNumber ?? '',
      );
      navigateToLogin();
    } catch (e) {
      showSnackBar("Google Sign-In failed: ${e.toString()}");
    }
  }
}
