import 'package:flutter/material.dart';

const Color primaryColor = Color(0xFF121421);


const MaterialColor primarySwatchColor = MaterialColor(_primarySwatchColorPrimaryValue, <int, Color>{
  50: Color(0xFFE3E3E4),
  100: Color(0xFFB8B9BC),
  200: Color(0xFF898A90),
  300: Color(0xFF595B64),
  400: Color(0xFF363742),
  500: Color(_primarySwatchColorPrimaryValue),
  600: Color(0xFF10121D),
  700: Color(0xFF0D0E18),
  800: Color(0xFF0A0B14),
  900: Color(0xFF05060B),
});
const int _primarySwatchColorPrimaryValue = 0xFF121421;

const MaterialColor primarySwatchColorAccent = MaterialColor(_primarySwatchColorAccentValue, <int, Color>{
  100: Color(0xFF5151FF),
  200: Color(_primarySwatchColorAccentValue),
  400: Color(0xFF0000EA),
  700: Color(0xFF0000D0),
});
const int _primarySwatchColorAccentValue = 0xFF1E1EFF;