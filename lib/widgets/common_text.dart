import 'package:flutter/material.dart';
import 'package:fluttertask/app/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';


class CommonMontserratText extends StatelessWidget {
  final String text;
  final double textSize;
  final Color? color;
  final TextDecoration? decoration;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;

  const CommonMontserratText(
      {Key? key,
        required this.text,
        required this.textSize,
        this.color,
        this.decoration,
        this.fontWeight,
        this.textAlign,
        this.overflow,
        this.maxLines})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: overflow,
      softWrap: true,
      maxLines: maxLines,
      style: GoogleFonts.sora(
        color: color ?? AppColors.colorBlack,
        fontSize: textSize,
        decoration: decoration,
        fontWeight: fontWeight,
      ),
    );
  }
}
