import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gluteno/auth/login/user_login.dart';
import 'package:gluteno/classes/colors.dart';
import 'package:gluteno/screens/profile/profile_button.dart';
import 'package:gluteno/utils/responsive_size_helper.dart';
import 'package:gluteno/widgets/app_text.dart';
import 'package:gluteno/widgets/buttons.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final user = auth.currentUser;
    if (user == null) {
      return Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const UserLoginPage()),
              );
            },
            child: const Text("Please log in"),
          ),
        ),
      );
    }

    final uid = user.uid;
    final userDoc = firestore.collection('users').doc(uid);

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: StreamBuilder<DocumentSnapshot>(
        stream: userDoc.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(
                child: CustomAppText(text: "No profile data", fontSize: 18));
          }

          final data = snapshot.data!.data() as Map<String, dynamic>;
          final email = data['email'] as String? ?? '';
          final phone = data['phone'] as String? ?? '';
          final username = email.contains('@') ? email.split('@')[0] : email;

          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 60),
                Image.asset("assets/images/logoo.png"),
                SizedBox(height: responsiveHeight(context, 18)),
                CustomAppText(
                  text: "Profile",
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textColor,
                ),
                SizedBox(height: responsiveHeight(context, 18)),
                CustomAppText(
                  text: username,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textColor,
                ),
                SizedBox(height: responsiveHeight(context, 18)),
                ProfileButton(
                  text: phone,
                  onTap: () {},
                  icon: Icons.phone_android_rounded,
                  showArrow: false,
                ),
                ProfileButton(
                  text: email,
                  onTap: () {},
                  icon: Icons.mail,
                  showArrow: false,
                ),
                ProfileButton(
                  text: "Change password",
                  onTap: () => showChangePasswordDialog(context),
                  icon: Icons.lock_outline_rounded,
                  showArrow: true,
                ),
                ProfileButton(
                  text: "Delete account",
                  onTap: () => showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: CustomAppText(
                        text: "Delete Account",
                        fontSize: 20,
                        color: AppColors.textColor,
                      ),
                      content: CustomAppText(
                        text:
                            "Are you sure you want to delete your account? This action cannot be undone.",
                        fontSize: 14,
                      ),
                      actions: [
                        TextButton(
                          onPressed: () async {
                            final user = FirebaseAuth.instance.currentUser;
                            if (user != null) {
                              await firestore
                                  .collection('users')
                                  .doc(user.uid)
                                  .delete();
                              await user.delete();
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (_) => const UserLoginPage()),
                                (route) => false,
                              );
                            }
                          },
                          child: CustomAppText(
                            text: "Delete",
                            fontSize: 16,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                  icon: Icons.delete_outline,
                  showArrow: false,
                ),
                SizedBox(height: responsiveHeight(context, 50)),
                CustomButton(
                  text: "Sign Out",
                  onTap: () async {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: CustomAppText(
                            text: "Log Out",
                            fontSize: 20,
                            color: AppColors.textColor,
                          ),
                          content: CustomAppText(
                            text: "Are you sure you want to log out?",
                            fontSize: 14,
                          ),
                          actions: [
                            // TextButton(
                            //   child: CustomAppText(
                            //     text: "Cancel",
                            //     fontSize: 16,
                            //   ),
                            //   onPressed: () {
                            //     Navigator.of(context, rootNavigator: true)
                            //         .pop();
                            //   },
                            // ),
                            TextButton(
                              child: CustomAppText(
                                text: "Log Out",
                                fontSize: 16,
                                color: Colors.red,
                              ),
                              onPressed: () async {
                                await FirebaseAuth.instance.signOut();

                                Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                    builder: (context) => UserLoginPage(),
                                  ),
                                  (Route<dynamic> route) => false,
                                );
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  fontSize: 18,
                  radius: 100,
                  height: responsiveHeight(context, 65),
                  iconData: Icons.logout,
                  size: 30.0,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void showChangePasswordDialog(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null || user.email == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No logged in user or email found')),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Change Password'),
        content: Text(
            'A password reset link will be sent to your email: ${user.email}.'),
        actions: [
          // TextButton(
          //   onPressed: () => Navigator.pop(context),
          //   child: Text('Cancel'),
          // ),
          TextButton(
            onPressed: () async {
              try {
                await FirebaseAuth.instance
                    .sendPasswordResetEmail(email: user.email!);
                // Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Reset link sent to ${user.email}')),
                );
              } catch (e) {
                // Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Failed to send reset email')),
                );
              }
              // Navigator.pop(context);
            },
            child: CustomAppText(text: "Send", fontSize: 16),
          ),
        ],
      ),
    );
  }
}
