import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';

class CustomDescriptionTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final String? prefixIconPath;
  final String labelText;
  final bool isPasswordField;
  final String? suffixIcoPath;
  final VoidCallback? onSuffixTap;
  final FormFieldValidator<String>? validator;

  const CustomDescriptionTextField({
    super.key,
    required this.hintText,
    required this.controller,
    this.prefixIconPath,
    required this.labelText,
    this.isPasswordField = false,
    this.suffixIcoPath,
    this.onSuffixTap,
    this.validator,
  });

  @override
  State<CustomDescriptionTextField> createState() => _CustomDescriptionTextFieldState();
}

class _CustomDescriptionTextFieldState extends State<CustomDescriptionTextField> {
  bool isObscured = false;
  FocusNode _focusNode = FocusNode();
  bool isFocused = false;

  @override
  void initState() {
    super.initState();
    isObscured = widget.isPasswordField;

    _focusNode.addListener(() {
      setState(() {
        isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.labelText,
          style: GoogleFonts.poppins(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: blackColor2,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          height: 100.h,
        
          child: TextFormField(
            scrollPadding: EdgeInsets.zero,
            textAlignVertical: TextAlignVertical.top,
            focusNode: _focusNode,
            cursorColor:greyColor2 ,
            controller: widget.controller,
            obscureText: widget.isPasswordField ? isObscured : false,
            obscuringCharacter: "●",
            validator: widget.validator,
            maxLines: null,  // Allow multiline input
            expands: true,   // Expand to fit the container
            decoration: InputDecoration(
              
               focusedBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none,
              fillColor: lightWhiteColor,
              filled: true,
              hintText: widget.hintText,
              hintStyle: GoogleFonts.urbanist(
                fontSize: 18.sp,
                fontWeight: FontWeight.w400,
                color: greyColor2,
              ),
               prefixIcon: widget.prefixIconPath != null
                  ? SizedBox(
                      height: 20.h,
                      width: 20.w,
                      child: Center(
                        child: SvgPicture.asset(
                          widget.prefixIconPath!,
                          colorFilter: ColorFilter.mode(
                            isFocused ? blackColor3 : greyColor2,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    )
                  : null,
                contentPadding: EdgeInsets.only(
                top:  13.h ,
                left: widget.prefixIconPath != null ? 15.w: 15.w,
              ),
              errorStyle: GoogleFonts.urbanist(
                color: redColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                // Customize the error message color to yellow
              ),
            ),
            style: GoogleFonts.urbanist(
              fontSize: 18.sp,
              fontWeight: FontWeight.w800,
              color: blackColor2,
            ),
          ),
        ),
      ],
    );
  }
}