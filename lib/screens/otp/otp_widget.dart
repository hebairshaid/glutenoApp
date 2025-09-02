// import "package:flutter/material.dart";
// import "package:flutter/services.dart";
// import "package:gluteno/classes/colors.dart";
// import "package:gluteno/utils/responsive_size_helper.dart";

// class OtpContainer extends StatelessWidget {
//   final TextEditingController controller;
//   final Function(String) onChanged;
//   final FocusNode? focusNode;
//   final Color? color;

//   const OtpContainer(
//       {super.key,
//       required this.controller,
//       required this.onChanged,
//       this.focusNode,
//       this.color});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: responsiveWidth(context, 80),
//       height: responsiveHeight(context, 80),
//       margin: const EdgeInsets.symmetric(horizontal: 8.0),
//       decoration: BoxDecoration(
//         color: AppColors.scaffoldBackground,
//         borderRadius: BorderRadius.circular(16.0),
//         boxShadow: const [
//           BoxShadow(
//             color: Color.fromARGB(173, 145, 143, 142),
//             spreadRadius: 1,
//             blurRadius: 5,
//             offset: Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Center(
//         child: TextFormField(
//           controller: controller,
//           focusNode: focusNode,
//           keyboardType: TextInputType.number,
//           textAlign: TextAlign.center,
//           inputFormatters: [
//             LengthLimitingTextInputFormatter(1),
//             FilteringTextInputFormatter.digitsOnly,
//           ],
//           cursorColor: AppColors.textColor,
//           style: TextStyle(
//             fontSize: responsiveWidth(context, 40),
//             fontWeight: FontWeight.bold,
//             color: AppColors.textColor,
//           ),
//           onChanged: onChanged,
//           decoration: const InputDecoration(
//             border: InputBorder.none,
//             contentPadding: EdgeInsets.zero,
//             // fillColor: AppColors.textColor 
//           ),
//         ),
//       ),
//     );
//   }
// }
