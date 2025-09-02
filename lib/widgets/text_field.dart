import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gluteno/classes/colors.dart';
import 'package:gluteno/utils/responsive_size_helper.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final Icon? icon;
  final Color? iconColor;
  final bool isPassword;
  final String? errorText;
  final String? hintText;
  final TextEditingController textEditingController;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  const CustomTextField({
    super.key,
    required this.label,
    required this.textEditingController,
    this.icon,
    this.iconColor,
    this.isPassword = false,
    this.errorText,
    this.hintText,
    this.keyboardType,
    this.inputFormatters, required bool obscureText,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isObscured = true;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (widget.icon != null) ...[
            IconTheme(
              data: IconThemeData(color: widget.iconColor ?? AppColors.borderColor),
              child: widget.icon!,
            ),
            const SizedBox(width: 12),
          ],
          Expanded(
            child: SizedBox(
              height: responsiveHeight(context, 80),
              child: TextField(
              
                controller: widget.textEditingController,
                obscureText: widget.isPassword ? _isObscured : false,
                keyboardType: widget.keyboardType ?? TextInputType.text,
                inputFormatters: widget.inputFormatters,
                decoration: InputDecoration(
                  
                  labelText: widget.label,
                  labelStyle: const TextStyle(color: AppColors.borderColor
                  , fontSize: 12),
                  hintText: widget.hintText,
                  errorText: widget.errorText,
                  border: const UnderlineInputBorder(

                    borderSide: BorderSide(color: AppColors.borderColor),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                  ),
                  suffixIcon: widget.isPassword
                      ? IconButton(
                          icon: Icon(
                            _isObscured ? Icons.visibility_off : Icons.visibility,
                            color: AppColors.borderColor,
                          ),
                          onPressed: () {
                            setState(() {
                              _isObscured = !_isObscured;
                            });
                          },
                        )
                      : null,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
