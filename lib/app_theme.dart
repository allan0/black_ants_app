import 'package:black_ants_app/config/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppConstants.primaryGold,
      scaffoldBackgroundColor: AppConstants.primaryBlack,
      colorScheme: const ColorScheme.dark(
        primary: AppConstants.primaryGold,
        secondary: AppConstants.secondaryGold,
        background: AppConstants.primaryBlack,
        surface: AppConstants.offBlack, // Cards, dialogs
        onPrimary: AppConstants.primaryBlack, // Text/icons on primary color
        onSecondary: AppConstants.primaryBlack, // Text/icons on secondary color
        onBackground: AppConstants.whiteText,   // Text/icons on background
        onSurface: AppConstants.whiteText,    // Text/icons on surface
        error: Colors.redAccent,
        onError: AppConstants.primaryBlack,
      ),

      appBarTheme: AppBarTheme(
        backgroundColor: AppConstants.primaryBlack,
        elevation: 0, // Flat design
        iconTheme: const IconThemeData(color: AppConstants.primaryGold),
        titleTextStyle: GoogleFonts.poppins( // Example font
          color: AppConstants.primaryGold,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),

      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppConstants.offBlack,
        selectedItemColor: AppConstants.primaryGold,
        unselectedItemColor: AppConstants.greyText,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        unselectedLabelStyle: TextStyle(fontSize: 12),
        type: BottomNavigationBarType.fixed, // Ensures background is shown
      ),

      textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme).apply(
        bodyColor: AppConstants.whiteText,
        displayColor: AppConstants.primaryGold,
      ).copyWith(
        headlineSmall: GoogleFonts.poppins(color: AppConstants.primaryGold, fontWeight: FontWeight.bold),
         titleLarge: GoogleFonts.poppins(color: AppConstants.whiteText, fontWeight: FontWeight.w600), // App bar title if not overridden
         bodyMedium: GoogleFonts.poppins(color: AppConstants.whiteText), // Default text
         labelSmall: GoogleFonts.poppins(color: AppConstants.greyText), // Hint text, captions
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppConstants.primaryGold,
          foregroundColor: AppConstants.primaryBlack,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
         focusedBorder: OutlineInputBorder(
           borderSide: const BorderSide(color: AppConstants.primaryGold),
           borderRadius: BorderRadius.circular(8),
         ),
         enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppConstants.greyText),
           borderRadius: BorderRadius.circular(8),
         ),
         labelStyle: const TextStyle(color: AppConstants.greyText),
         hintStyle: const TextStyle(color: AppConstants.greyText),
       ),

       cardTheme: CardTheme(
         color: AppConstants.offBlack,
         elevation: 4,
         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
       ),

       progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: AppConstants.primaryGold,
          linearTrackColor: AppConstants.greyText,
       ),

      // Add other theme properties as needed (floatingActionButton, dialogs, etc.)
    );
  }
}
