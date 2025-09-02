// // ignore_for_file: avoid_print

// import 'package:flutter/material.dart';
// import 'package:gluteno/classes/colors.dart';
// import 'package:gluteno/utils/responsive_size_helper.dart';
// import 'package:gluteno/widgets/app_text.dart';
// import 'package:gluteno/widgets/buttons.dart';
// import 'package:gluteno/screens/otp/otp_widget.dart';

// class OtpScreen extends StatefulWidget {
//   const OtpScreen({super.key});

//   @override
//   State<OtpScreen> createState() => _OtpScreenState();
// }

// class _OtpScreenState extends State<OtpScreen> {
//   final List<TextEditingController> controllers =
//       List.generate(4, (_) => TextEditingController());
//   final List<FocusNode> focusNodes = List.generate(4, (_) => FocusNode());

//   @override
//   void dispose() {
//     for (var controller in controllers) {
//       controller.dispose();
//     }
//     for (var node in focusNodes) {
//       node.dispose();
//     }
//     super.dispose();
//   }

//   void handleInput(String value, int index) {
//     if (value.isNotEmpty) {
//       if (index < 3) {
//         focusNodes[index + 1].requestFocus();
//       } else {
//         focusNodes[index].unfocus();
//         String code = controllers.map((e) => e.text).join();
//         print("OTP Code is: $code");
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.scaffoldBackground,
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(responsiveHeight(context, 300)),
//         child: Row(
//           children: [
//             Padding(
//               padding: EdgeInsets.symmetric(
//                   horizontal: responsiveWidth(context, 30),
//                   vertical: responsiveHeight(context, 70)),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   InkWell(
//                       onTap: () {
//                         Navigator.pop(context);
//                       },
//                       child: Icon(
//                         Icons.arrow_back_ios,
//                         color: AppColors.textColor,
//                         size: responsiveHeight(context, 40),
//                       )),
//                   SizedBox(width: responsiveWidth(context, 75)),
//                   const CustomAppText(text: "Verification", fontSize: 24),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             SizedBox(height: responsiveHeight(context, 10)),
//             const CustomAppText(
//               textAlign: TextAlign.center,
//               text: "Please Enter The Code We Just Sent To Your Phone Number",
//               fontSize: 16,
//               hasPadding: true,
//               fontWeight: FontWeight.normal,
//               color: Colors.grey,
//             ),
//             SizedBox(height: responsiveHeight(context, 20)),
//             const CustomAppText(
//               textAlign: TextAlign.center,
//               text: "+962 79 xxxxxx7",
//               fontSize: 16,
//               hasPadding: true,
//               fontWeight: FontWeight.bold,
//               color: Colors.grey,
//             ),
//             SizedBox(height: responsiveHeight(context, 40)),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: List.generate(4, (index) {
//                 return OtpContainer(
//                   controller: controllers[index],
//                   focusNode: focusNodes[index],
//                   onChanged: (value) {
//                     handleInput(value, index);
//                   },
//                 );
//               }),
//             ),
//             SizedBox(height: responsiveHeight(context, 40)),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const CustomAppText(
//                   text: "If you don't receive a code?",
//                   fontSize: 16,
//                   hasPadding: false,
//                   fontWeight: FontWeight.normal,
//                   color: Colors.grey,
//                 ),
//                 InkWell(
//                   onTap: () {},
//                   child: const CustomAppText(
//                     text: " Resend",
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                     hasPadding: false,
//                     color: Colors.grey,
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: responsiveHeight(context, 40)),
//             CustomButton(
//               text: "Continue",
//               buttonColor: AppColors.scaffoldBackground,
//               onTap: () {
//                 String otp = controllers.map((e) => e.text).join();
//                 print("Final OTP: $otp");
//               },
//               width: responsiveWidth(context, 300),
//               height: responsiveHeight(context, 70),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
