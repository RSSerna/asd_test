import 'package:flutter/material.dart';

import 'app_typography.dart';

class AppTheme {
  static ThemeData themeData = ligthTheme;

  static final ThemeData ligthTheme = ThemeData(
    useMaterial3: true,
    colorScheme: lightColorScheme,
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(color: lightColorScheme.primary),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: lightColorScheme.primary,
      indicatorColor: Colors.transparent,
      iconTheme: const WidgetStatePropertyAll(IconThemeData(
        color: Colors.white,
      )),
      labelTextStyle: const WidgetStatePropertyAll(TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
      )),
    ),
    splashColor: Colors.transparent,
    typography: appMaterialTypography,
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: darkColorScheme,
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: darkColorScheme.primary,
      indicatorColor: Colors.transparent,
      iconTheme: const WidgetStatePropertyAll(IconThemeData(
        color: Colors.white,
      )),
      labelTextStyle: const WidgetStatePropertyAll(TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
      )),
    ),
    splashColor: Colors.transparent,
    typography: appMaterialTypography,
  );

  static const lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFFBA1C05),
    onPrimary: Color(0xFFF7F7F7),
    primaryContainer: Color(0xFFBA1C05),
    onPrimaryContainer: Color(0xFFF7F7F7),
    secondary: Color(0xFF44312E),
    onSecondary: Color(0xFFF7F7F7),
    secondaryContainer: Color(0xFFFFDAD4),
    onSecondaryContainer: Color(0xFF001F24),
    tertiary: Color(0xFFBA1C05),
    onTertiary: Color(0xFFF7F7F7),
    tertiaryContainer: Color(0xFFFFDAD4),
    onTertiaryContainer: Color(0xFF3F0300),
    error: Color(0xFFBA1A1A),
    errorContainer: Color(0xFFFFDAD6),
    onError: Color(0xFFF7F7F7),
    onErrorContainer: Color(0xFF410002),
    surface: Color(0xFFFFFBFF),
    onSurface: Color(0xFF3F0300),
    surfaceContainerHighest: Color(0xFFFFFBFF),
    onSurfaceVariant: Color(0xFF534340),
    outline: Color(0xFF857370),
    onInverseSurface: Color(0xFFFFEDE9),
    inverseSurface: Color(0xFF5F150A),
    inversePrimary: Color(0xFFFFB4A6),
    shadow: Color(0xFF000000),
    surfaceTint: Color(0xFFBA1C05),
    outlineVariant: Color(0xFFD8C2BE),
    scrim: Color(0xFF000000),
  );

  static const darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFFBA1C05),
    onPrimary: Color(0xFFF7F7F7),
    primaryContainer: Color(0xFFBA1C05),
    onPrimaryContainer: Color(0xFFF7F7F7),
    secondary: Color(0xFFE7BDB5),
    onSecondary: Color(0xFF442A24),
    secondaryContainer: Color(0xFF5D3F3A),
    onSecondaryContainer: Color(0xFFF7F7F7),
    tertiary: Color(0xFFFFB4A6),
    onTertiary: Color(0xFF660800),
    tertiaryContainer: Color(0xFF900F00),
    onTertiaryContainer: Color(0xFFF7F7F7),
    error: Color(0xFFFFB4AB),
    errorContainer: Color(0xFF93000A),
    onError: Color(0xFF690005),
    onErrorContainer: Color(0xFFFFDAD6),
    surface: Color(0xFF201A19),
    onSurface: Color(0xFFF7F7F7),
    surfaceContainerHighest: Color(0xFF534340),
    onSurfaceVariant: Color(0xFFD8C2BE),
    outline: Color(0xFFA08C89),
    onInverseSurface: Color(0xFF3F0300),
    inverseSurface: Color(0xFFFFDAD4),
    inversePrimary: Color(0xFFBA1C05),
    shadow: Color(0xFF000000),
    surfaceTint: Color(0xFFFFB4A6),
    outlineVariant: Color(0xFF534340),
    scrim: Color(0xFF000000),
  );
}
