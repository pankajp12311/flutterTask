import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertask/app/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';


/// Common app input used in whole app
class CommonAppInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final TextInputType textInputType;
  final bool isPassword;
  final bool isEnable;
  final bool isMobileNumber;
  final bool isVerificationCode;
  final bool isUserName;
  final bool autofocus;
  final double borderRadius;
  final String hintText;
  final String headerText;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final IconData? suffixIcon;
  final Widget? suffixWidget;
  final VoidCallback? onSuffixClick;
  final VoidCallback? onSubmitClick;
  final void Function(String)? onChanged;
  final TextInputAction textInputAction;
  final TextCapitalization textCapitalization;
  final Widget? prefixIcon;
  final InputDecoration? inputDecoration;
  final Color? filledColor;
  final Color? borderColor;
  final Color? textColor;
  final Color? hintColor;
  final double? height;
  final int? maxLine;
  final bool readOnly;
  final FocusNode? focusNode;
  final double? contentPadding;

  const CommonAppInput(
      {Key? key,
      required this.textEditingController,
      this.textInputType = TextInputType.text,
      this.isPassword = false,
      this.isMobileNumber = false,
      this.isVerificationCode = false,
      this.isUserName = false,
      this.isEnable = true,
      this.borderRadius = 0,
      this.hintText = '',
      this.headerText = '',
      this.hintStyle,
      this.labelStyle,
      this.suffixIcon,
      this.suffixWidget,
      this.onSuffixClick,
      this.onSubmitClick,
      this.onChanged,
      this.inputDecoration,
      this.prefixIcon,
      this.focusNode,
      this.readOnly = false,
      this.autofocus = false,
      this.textInputAction = TextInputAction.next,
      this.textCapitalization = TextCapitalization.none,
      this.filledColor,
      this.borderColor,
      this.textColor,
      this.hintColor,
      this.height,
      this.maxLine,
      this.contentPadding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 52.h,
      child: TextField(
        controller: textEditingController,
        keyboardType: textInputType,
        obscureText: isPassword,
        maxLines: maxLine ?? 1,
        enabled: isEnable,
        onSubmitted: (_) {
          onSubmitClick!();
          //FocusScope.of(context).nextFocus();
        },
        focusNode: focusNode,
        autofocus: autofocus,
        textCapitalization: textCapitalization,
        textInputAction: textInputAction,
        inputFormatters: isMobileNumber
            ? <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                LengthLimitingTextInputFormatter(11),
              ]
            : isPassword
                ? <TextInputFormatter>[
                    LengthLimitingTextInputFormatter(12),
                  ]
                : isVerificationCode ?
        <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp("[0-9]")),
          LengthLimitingTextInputFormatter(4),
        ] : isUserName ?
        <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp("r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}\$")),
        ] : null,
        autocorrect: true,
        readOnly: readOnly,
        style: GoogleFonts.sora(
          color: textColor ??  AppColors.colorBlack.withOpacity(0.6),
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
        ),
        onChanged: onChanged,
        decoration: inputDecoration ??
            InputDecoration(
                hintText: hintText,
                hintStyle: GoogleFonts.sora(
                  color: hintColor ?? AppColors.colorBlack.withOpacity(0.6),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
                prefixIcon:prefixIcon!=null? Padding(padding: EdgeInsets.all(13.w), child: prefixIcon):null,
                suffixIcon: suffixIcon != null
                    ? Container(
                        width: 40.w,
                        color: Colors.transparent,
                        child: InkResponse(
                          radius: 15,
                          onTap: onSuffixClick,
                          child: Icon(suffixIcon, size: 20.h, color: AppColors.colorD6AB76),
                        ),
                      )
                    : suffixWidget != null
                        ? Container(width: 80.w, color: Colors.transparent, alignment: Alignment.center, padding: EdgeInsets.only(left: 15.w,right: 15.w), child: suffixWidget)
                        : null,
                contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal:contentPadding?? 10.w),
                filled: true,
                fillColor: filledColor ?? AppColors.colorD9D9D9.withOpacity(0.2),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(borderRadius != 0 ? borderRadius : 10.r)),
                  borderSide: BorderSide(color: borderColor ?? AppColors.colorWhite, width: 1.w),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(borderRadius != 0 ? borderRadius : 10.r)),
                  borderSide: BorderSide(color: AppColors.colorWhite, width: 1.w),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(borderRadius != 0 ? borderRadius : 10.0.r)),
                  borderSide: BorderSide(color: AppColors.colorWhite, width: 1.w),
                )),
      ),
    );
  }
}
