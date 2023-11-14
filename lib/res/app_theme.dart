
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {

  Color get primaryColor => const Color(0xFF0C77BA);
  Color shimmerHighlight = Colors.grey.withOpacity(0.3);
  Color shimmerBaseColor = Colors.black38;

  Color get accentColor => const Color(0xFFE28626);
  Color get nearlyWhite =>const  Color(0xFFFEFEFE);
  Color get lightBlue => const Color(0xFF3FA6C0);
  Color get grey =>const  Color(0xFF565555);
  Color get darkGrey => Colors.grey.shade800;
  Color get nearlyBlack => Colors.black54;

  TextStyle get regularTxt => GoogleFonts.inter(
    color: Colors.black,
    fontSize: 14.sp,
    fontWeight: FontWeight.w400
  );
  TextStyle get mediumTxt => GoogleFonts.inter(
    color: Colors.black,
    fontSize: 14.sp,
    fontWeight: FontWeight.w500
  );
  TextStyle get semiBoldTxt => GoogleFonts.inter(
    color: Colors.black,
    fontSize: 18.sp,
    fontWeight: FontWeight.w600
  );
  TextStyle get boldTxt => GoogleFonts.inter(
    color: Colors.black,
    fontSize: 20.sp,
    fontWeight: FontWeight.w700
  );


  ButtonStyle get priBtnStyle => ButtonStyle(
      backgroundColor: MaterialStatePropertyAll(primaryColor),
      shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r)
          )
      )
  );

  double get kBtnHeight => 35.h;
  EdgeInsets get screenPadding => EdgeInsets.all(10.w);
  ScrollPhysics bouncingPhysics = const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics());

  AppTheme();

}