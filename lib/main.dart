import 'package:flutter/material.dart';

import 'screens/tela_principal.dart';

void main() {
  runApp(const UsinaApp());
}

class UsinaApp extends StatelessWidget {
  const UsinaApp({super.key});

  static const _verdeUsina = Color(0xFF236B45);
  static const _verdeProfundo = Color(0xFF164B32);
  static const _fundo = Color(0xFFF5F8F4);

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: _verdeUsina,
      brightness: Brightness.light,
    ).copyWith(
      primary: _verdeUsina,
      onPrimary: Colors.white,
      secondary: const Color(0xFFC9892D),
      surface: Colors.white,
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Usina App',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: colorScheme,
        scaffoldBackgroundColor: _fundo,
        appBarTheme: const AppBarTheme(
          backgroundColor: _fundo,
          foregroundColor: _verdeProfundo,
          elevation: 0,
          centerTitle: false,
          titleTextStyle: TextStyle(
            color: _verdeProfundo,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        drawerTheme: const DrawerThemeData(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          elevation: 8,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 17,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xFFDDE6DD)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: _verdeUsina, width: 1.6),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xFFBA1A1A)),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xFFBA1A1A), width: 1.6),
          ),
          labelStyle: const TextStyle(color: Color(0xFF5F6F63)),
          hintStyle: const TextStyle(color: Color(0xFF92A097)),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: _verdeUsina,
            foregroundColor: Colors.white,
            elevation: 0,
            minimumSize: const Size.fromHeight(54),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        cardTheme: CardThemeData(
          color: Colors.white,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
            side: const BorderSide(color: Color(0xFFE4ECE3)),
          ),
        ),
        snackBarTheme: SnackBarThemeData(
          behavior: SnackBarBehavior.floating,
          backgroundColor: _verdeProfundo,
          contentTextStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
      home: const TelaPrincipal(),
    );
  }
}
