//   import 'package:flutter/material.dart';
// import 'package:gluteno/classes/colors.dart';
// import 'package:gluteno/widgets/app_text.dart';

// void showChangePasswordDialog(BuildContext context) {
//     final TextEditingController oldPasswordController = TextEditingController();
//     final TextEditingController newPasswordController = TextEditingController();
//     final TextEditingController confirmPasswordController = TextEditingController();

//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//           title: Text("Change Password"),
//           content: SingleChildScrollView(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 TextField(
//                   controller: oldPasswordController,
//                   obscureText: true,
//                   decoration: InputDecoration(
//                     labelText: 'Old Password',
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 TextField(
//                   controller: newPasswordController,
//                   obscureText: true,
//                   decoration: InputDecoration(
//                     labelText: 'New Password',
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 TextField(
//                   controller: confirmPasswordController,
//                   obscureText: true,
//                   decoration: InputDecoration(
//                     labelText: 'Confirm Password',
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           actions: [
//             TextButton(
//               child: Text("Cancel"),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: AppColors.btnColor,
//                 foregroundColor: Colors.white,
//               ),
//               child: CustomAppText(text: "save", fontSize: 12),
//               onPressed: () {
//                 String oldPass = oldPasswordController.text.trim();
//                 String newPass = newPasswordController.text.trim();
//                 String confirmPass = confirmPasswordController.text.trim();

//                 if (newPass != confirmPass) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text("New and confirm passwords do not match")),
//                   );
//                   return;
//                 }

//                 if (oldPass.isEmpty || newPass.isEmpty || confirmPass.isEmpty) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text("Please fill all fields")),
//                   );
//                   return;
//                 }

//                 // TODO: Add actual password change logic/API call here

//                 Navigator.of(context).pop();
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(content: Text("Password changed successfully")),
//                 );
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
