import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gluteno/auth/login/user_login.dart';
import 'package:gluteno/classes/colors.dart';
import 'package:gluteno/utils/responsive_size_helper.dart';
import 'package:gluteno/widgets/buttons.dart';
import 'package:gluteno/widgets/text_field.dart';

class ForgetPassword extends StatelessWidget {
  ForgetPassword({super.key});
  final TextEditingController emailPhoneController = TextEditingController();

  bool isValidPhone(String input) {
    final numericRegex = RegExp(r'^\d{10}$');
    return numericRegex.hasMatch(input);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SingleChildScrollView(
        child: Column(children: [
          SafeArea(
            child: Row(
              children: [
                SizedBox(
                  width: responsiveWidth(context, 10),
                ),
                InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserLoginPage()),
                  ),
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    size: responsiveHeight(context, 40),
                    color: AppColors.textColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: responsiveHeight(context, 50),
          ),
          Image.asset("assets/images/logoo.png"),
          SizedBox(
            height: responsiveHeight(context, 50),
          ),
          CustomTextField(
            label: "Email or phone number",
            textEditingController: emailPhoneController,
            obscureText: false,
          ),
          SizedBox(
            height: responsiveHeight(context, 50),
          ),
          CustomButton(
            text: "Send",
            onTap: () async {
              String input = emailPhoneController.text.trim();
              if (input.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content:
                          Text('Please enter your email or phone number.')),
                );
                return;
              }

              try {
                if (input.contains('@')) {
                  await FirebaseAuth.instance
                      .sendPasswordResetEmail(email: input);
                } else {
                  if (!isValidPhone(input)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content:
                              Text('Phone number must be exactly 10 digits.')),
                    );
                    return;
                  }

                  final snapshot = await FirebaseFirestore.instance
                      .collection('users')
                      .where('phone', isEqualTo: input)
                      .limit(1)
                      .get();

                  if (snapshot.docs.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Phone number not found.')),
                    );
                    return;
                  }

                  String email = snapshot.docs.first.get('email');
                  await FirebaseAuth.instance
                      .sendPasswordResetEmail(email: email);
                }

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text('Reset link has been sent to your email.')),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error: ${e.toString()}')),
                );
                print(e);
              }
            },
            height: responsiveHeight(context, 60),
            width: responsiveWidth(context, 150),
          )
        ]),
      ),
    );
  }
}
