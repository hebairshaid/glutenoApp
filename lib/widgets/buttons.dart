import 'package:flutter/material.dart';
import 'package:gluteno/classes/colors.dart';
import 'package:gluteno/utils/responsive_size_helper.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color textColor;
  final Color buttonColor;
  final double fontSize;
  final double? height;
  final double? width;
  final double radius;
  final bool isOutlined;
  final bool isTextUnderlined;
  final IconData? iconData;
  final double borderWidth;
  final Color? borderColor;
  final double? size;
  final EdgeInsetsGeometry padding;

  const CustomButton({
    super.key,
    required this.text,
    required this.onTap,
    this.textColor = AppColors.textColor,
    this.buttonColor = AppColors.btnColor,
    this.fontSize = 16,
    this.height,
    this.width,
    this.radius = 16,
    this.isOutlined = false,
    this.isTextUnderlined = false,
    this.iconData,
    this.borderWidth = 2,
    this.borderColor,
    this.size = 17,
    this.padding = const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10.0),
  });

  @override
  Widget build(BuildContext context) {
    final double buttonHeight = height ?? responsiveHeight(context, 80);
    final double buttonWidth = width ?? responsiveWidth(context, 240);

    return Padding(
      padding: padding,
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(radius),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(radius),
          child: Container(
            width: buttonWidth,
            height: buttonHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              color: isOutlined ? Colors.transparent : buttonColor,
              border: Border.all(
                color: borderColor ?? buttonColor,
                width: borderWidth,
              ),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(255, 99, 98, 98),
                  offset: Offset(3, 3),
                  blurRadius: 6,
                  spreadRadius: 0,
                ),
              ],
            ),
            alignment: Alignment.center,
            child: text.isNotEmpty
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (iconData != null) ...[
                        Icon(
                          iconData,
                          size: size,
                          color: isOutlined ? buttonColor : textColor,
                        ),
                        SizedBox(width: responsiveWidth(context, 20)),
                      ],
                      Text(
                        text,
                        style: TextStyle(
                          fontSize: fontSize,
                          fontWeight: FontWeight.bold,
                          color: isOutlined ? buttonColor : textColor,
                          decoration: isTextUnderlined
                              ? TextDecoration.underline
                              : TextDecoration.none,
                          decorationColor: AppColors.borderColor,
                          decorationThickness: 1.0,
                        ),
                      ),
                    ],
                  )
                : (iconData != null
                    ? Icon(
                        iconData,
                        size: size,
                        color: isOutlined ? buttonColor : textColor,
                      )
                    : SizedBox()),
          ),
        ),
      ),
    );
  }
}

class Rec extends StatelessWidget {
  const Rec({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

