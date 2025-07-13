// Tipografia do Design System
// Defina aqui estilos de texto, fontes, tamanhos, pesos, etc.

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Tokens de tipografia do Design System Kanba
class KanbaTypography {
  // Headings
  static TextStyle get h1 => GoogleFonts.urbanist(
    fontSize: 48,
    fontWeight: FontWeight.bold,
    height: 1.2,
  );
  static TextStyle get h2 => GoogleFonts.urbanist(
    fontSize: 40,
    fontWeight: FontWeight.bold,
    height: 1.2,
  );
  static TextStyle get h3 => GoogleFonts.urbanist(
    fontSize: 32,
    fontWeight: FontWeight.w600,
    height: 1.2,
  );
  static TextStyle get h4 => GoogleFonts.urbanist(
    fontSize: 24,
    fontWeight: FontWeight.w500,
    height: 1.2,
  );
  static TextStyle get h5 => GoogleFonts.urbanist(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    height: 1.2,
  );
  static TextStyle get h6 => GoogleFonts.urbanist(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    height: 1.2,
  );

  // Body
  static TextStyle get bodyXLarge => GoogleFonts.urbanist(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    height: 1.4,
  );
  static TextStyle get bodyLarge => GoogleFonts.urbanist(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );
  static TextStyle get bodyMedium => GoogleFonts.urbanist(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.4,
  );
  static TextStyle get bodySmall => GoogleFonts.urbanist(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.4,
  );
  static TextStyle get bodyXSmall => GoogleFonts.urbanist(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    height: 1.4,
  );
}
