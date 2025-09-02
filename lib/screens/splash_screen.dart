import 'package:flutter/material.dart';
import 'package:gluteno/auth/login/user_login.dart';
import 'package:gluteno/classes/colors.dart';
import 'package:gluteno/classes/images.dart';
import 'package:gluteno/utils/extension.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    transtion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SizedBox.expand(
        child: Image.asset(
          AppImages.appLogo,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  transtion() async {
    await Future.delayed(
      const Duration(seconds: 5),
    );
    if (mounted) {
      context.pushReplacement(const UserLoginPage());
    }
  }
}
