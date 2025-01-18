  import 'package:flutter/material.dart';
  import 'package:flutter_screenutil/flutter_screenutil.dart';
  import 'package:flutter_svg/flutter_svg.dart';
  import 'package:google_fonts/google_fonts.dart';
  import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
  import 'package:lnbg_crypto_wallet_app/Constants/images.dart';


  class CustomTextField extends StatefulWidget {
    final String hintText;
    final TextEditingController controller;
    final String? prefixIconPath;
    final String labelText;
    final bool isPasswordField;
    final String? suffixIcoPath;
    final VoidCallback? onSuffixTap;
    final FormFieldValidator<String>? validator;

    const CustomTextField({
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
    State<CustomTextField> createState() => _CustomTextFieldState();
  }
  class _CustomTextFieldState extends State<CustomTextField> {
    bool isObscured = false;
    FocusNode _focusNode = FocusNode();
    bool isFocused = false;

    @override
    void initState() {
      super.initState();
      isObscured = widget.isPasswordField;
      
      // Listener to track focus changes
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
          TextFormField(
            focusNode: _focusNode, // Attach focus node
            controller: widget.controller,
            obscureText: isObscured,
            obscuringCharacter: "●", // You can choose your custom character
            validator: widget.validator,
            decoration: InputDecoration(
              focusedBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
              focusColor: lightWhiteColor,
              filled: true,
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
              hintText: widget.hintText,
              hintStyle: GoogleFonts.urbanist(
                fontSize: 18.sp,
                fontWeight: FontWeight.w400,
                color: greyColor2,
              ),
              fillColor: lightWhiteColor,
              suffixIcon: widget.suffixIcoPath != null
                  ? SizedBox(
                      height: 20.h,
                      width: 20.w,
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            if (widget.suffixIcoPath == eyeIcon) {
                              setState(() {
                                isObscured = !isObscured;
                              });
                            } else {
                              widget.onSuffixTap?.call();
                            }
                          },
                          child: SvgPicture.asset(
                            widget.suffixIcoPath!,
                            colorFilter: ColorFilter.mode(
                              isFocused ? blackColor3 : greyColor2,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                    )
                  : null,
              contentPadding: EdgeInsets.only(
                top: widget.prefixIconPath != null ? 13.h : 0,
                left: widget.prefixIconPath != null ? 0 : 15.w,
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
        ],
      );
    }
  }

