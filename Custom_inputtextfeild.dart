import 'package:cableproject/utilities/app_font.dart';
import 'package:flutter/material.dart';

import 'app_color.dart';
import 'app_constant.dart';

class CustomInputTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxLength;

  final bool readOnly;

  final dynamic image;
  final dynamic prefixIcon;
  final dynamic suffixIcon;

  final TextInputType keyboardtype;

  CustomInputTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.maxLength,
    required this.readOnly,
    this.image,
    this.prefixIcon,
    this.suffixIcon,
    required Color cursorColor,
    required this.keyboardtype,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 90 / 100,
        child: TextFormField(
          controller: controller,
          readOnly: readOnly,
          style: AppConstant.textFilledStyle,
          cursorColor: AppColor.primaryColor,
          keyboardType: keyboardtype,
          // maxLength: maxLength,
          decoration: InputDecoration(
            suffixIcon: suffixIcon != null
                ? Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 6 / 100,
                      width: MediaQuery.of(context).size.width * 6 / 100,
                      child: Image.asset(
                        suffixIcon,
                        fit: BoxFit.contain,
                      ),
                    ),
                  )
                : null,
            prefixIcon: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  child: Image.asset(
                    prefixIcon,
                    height: MediaQuery.of(context).size.width * 5.5 / 100,
                    width: MediaQuery.of(context).size.width * 5.5 / 100,
                  ),
                ),
              ],
            ),
            hintText: hintText,
            hintStyle: TextStyle(
                color: AppColor.primaryColor.withOpacity(0.5),
                fontWeight: FontWeight.w500,
                fontFamily: AppFont.fontFamily,
                fontSize: 18),
            border: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.blue),
            ),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.blue),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.blue, width: 1.5),
            ),
          ),
        ),
      ),
    );
  }
}
