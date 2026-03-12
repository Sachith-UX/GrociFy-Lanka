import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocify/core/constants/app_sizes.dart';

class AppTextStyles {
  // Headings
  static TextStyle heading1 = GoogleFonts.poppins(
    fontSize: AppSizes.fontSizeXXXL,
    fontWeight: FontWeight.bold,
    height: 1.2,
  );

  static TextStyle heading2 = GoogleFonts.poppins(
    fontSize: AppSizes.fontSizeXXL,
    fontWeight: FontWeight.bold,
    height: 1.3,
  );

  static TextStyle heading3 = GoogleFonts.poppins(
    fontSize: AppSizes.fontSizeXL,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );

  static TextStyle heading4 = GoogleFonts.poppins(
    fontSize: AppSizes.fontSizeLG,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );

  // Body text
  static TextStyle bodyLarge = GoogleFonts.poppins(
    fontSize: AppSizes.fontSizeMD,
    fontWeight: FontWeight.normal,
    height: 1.5,
  );

  static TextStyle bodyMedium = GoogleFonts.poppins(
    fontSize: AppSizes.fontSizeSM,
    fontWeight: FontWeight.normal,
    height: 1.5,
  );

  static TextStyle bodySmall = GoogleFonts.poppins(
    fontSize: AppSizes.fontSizeXS,
    fontWeight: FontWeight.normal,
    height: 1.4,
  );

  // Button text
  static TextStyle button = GoogleFonts.poppins(
    fontSize: AppSizes.fontSizeMD,
    fontWeight: FontWeight.w600,
    height: 1.2,
  );

  // Caption
  static TextStyle caption = GoogleFonts.poppins(
    fontSize: AppSizes.fontSizeXS,
    fontWeight: FontWeight.normal,
    height: 1.4,
  );

  // Label
  static TextStyle label = GoogleFonts.poppins(
    fontSize: AppSizes.fontSizeSM,
    fontWeight: FontWeight.w500,
    height: 1.4,
  );

  // Price text
  static TextStyle price = GoogleFonts.poppins(
    fontSize: AppSizes.fontSizeLG,
    fontWeight: FontWeight.bold,
    height: 1.2,
  );

  static TextStyle priceSmall = GoogleFonts.poppins(
    fontSize: AppSizes.fontSizeMD,
    fontWeight: FontWeight.w600,
    height: 1.2,
  );

  // Status text
  static TextStyle status = GoogleFonts.poppins(
    fontSize: AppSizes.fontSizeSM,
    fontWeight: FontWeight.w500,
    height: 1.4,
  );
}