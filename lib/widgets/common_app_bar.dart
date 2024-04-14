import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertask/app/app_colors.dart';
import 'package:fluttertask/widgets/common_text.dart';

class CommonAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  final VoidCallback? onBackClick;
  final double? appbarHeight;
  final double? elevation;
  final bool? isChangedTextFamily;
  final bool? isRegular;
  final bool? isLexus;
  final Color? backButtonColor;
  final List<Widget>? actionButtons;

  const CommonAppbar(
      {Key? key,
        required this.text,
        this.onBackClick,
        this.elevation,
        this.appbarHeight,
        this.isChangedTextFamily = false,
        this.isRegular,
        this.backButtonColor,
        this.isLexus,this.actionButtons
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      enabled: true,
      button: true,
      // label:AppStrings.backButtonId,
      child: PreferredSize(
        preferredSize: preferredSize,
        child:AppBar(
          elevation: elevation ?? 0,
          titleSpacing: 2.w,
          backgroundColor: AppColors.colorWhite,
          leading: IconButton(
              onPressed: onBackClick,
              padding: EdgeInsets.only(left: 3.w),
              icon: Container(height: 38.h,width: 38.w,decoration: BoxDecoration(color:backButtonColor?? AppColors.color5A5A5A,shape: BoxShape.circle),
                child: const Center(child: Icon(Icons.arrow_back_rounded,color: AppColors.colorWhite),),
              )),
          title:isChangedTextFamily == true? CommonMontserratText(text: text, textSize:isLexus == true? 18.sp:16.sp, ):CommonMontserratText(text: text, textSize: 18.sp,),
          leadingWidth:  68.w,
          actions: actionButtons,

          centerTitle: false,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appbarHeight ?? 50.h);
}