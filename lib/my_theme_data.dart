import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_d0_app/app_color.dart';

class MtTheme {
  static final ThemeData themelight = ThemeData(
      scaffoldBackgroundColor: AppColor.backgroundlightcolor,
      primaryColor: AppColor.primarycolor,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColor.primarycolor,
      ),
      textTheme: TextTheme(
        bodyMedium: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: AppColor.blackcolor),
        bodyLarge: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppColor.whitecolor),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: AppColor.primarycolor,
          unselectedItemColor: Colors.grey,
          selectedIconTheme: IconThemeData(size: 20)),
      bottomSheetTheme: BottomSheetThemeData(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
              side: BorderSide(color: AppColor.primarycolor, width: 3))));

  static final ThemeData themedark = ThemeData(
      scaffoldBackgroundColor: AppColor.backgrounddarkcolor,
      primaryColor: AppColor.primarycolor,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColor.primarycolor,
      ),
      textTheme: TextTheme(
        bodyMedium: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: AppColor.blackcolor),
          bodyLarge: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColor.backgrounddarkcolor)),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: AppColor.primarycolor,
          unselectedItemColor: Colors.grey,
          selectedIconTheme: IconThemeData(size: 30)));
}
