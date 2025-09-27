import 'package:flutter/material.dart';

class AppCardTheme {
  static final CardThemeData light = CardThemeData(
    elevation: 2,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    color: Colors.white,
  );

  static final CardThemeData dark = CardThemeData(
    elevation: 2,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    color: Colors.grey[800],
  );
}
