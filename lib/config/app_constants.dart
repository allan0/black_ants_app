import 'package:flutter/material.dart';

class AppConstants {
  static const String appName = "BlackAnts";

  // Taglines (choose one or cycle)
  static const List<String> taglines = [
    "#1 Africa Focus Robot Advisor.",
    "Save. Trade. Invest.",
    "Democratize cross-border trading of securities in Africa & More.",
    "Connect Africa Opportunities to Global Investors.",
  ];

  // Emojis for Splash Screen - Mix representation
  static const List<String> splashEmojis = [
    '🧑🏿‍💻', // Black Developer
    '👩🏾‍💼', // Black Businesswoman
    '👨🏿‍🚀', // Black Astronaut (representing ambition)
    '👩🏿‍🏫', // Black Teacher
    '👨🏾‍🌾', // Black Farmer
    '🧑🏽‍🎨', // Medium skin tone Artist
    '🧑🏻‍🔬', // Light skin tone Scientist
    '🧑🏼‍🚀', // Asian Astronaut (Example) - Adapt as needed
    '👩🏻‍⚖️', // American Judge (Example - White/Light Skin Tone) - Adapt as needed
    '🌍', // Globe/Africa
  ];

  // Theme Colors
  static const Color primaryGold = Color(0xFFD4AF37); // Classic Gold
  // static const Color primaryGold = Color(0xFFFFD700); // Brighter Gold
  static const Color secondaryGold = Color(0xFFB8860B); // Darker Gold / Accent
  static const Color primaryBlack = Color(0xFF000000); // Pure Black
  static const Color offBlack = Color(0xFF121212);     // Slightly off-black for surfaces
  static const Color greyText = Color(0xFFBDBDBD);     // For less important text
  static const Color whiteText = Color(0xFFFFFFFF);     // For contrast on black
}
