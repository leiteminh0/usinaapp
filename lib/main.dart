import 'package:flutter/material.dart';

import 'screens/tela_principal.dart';

void main() {
  runApp(const UsinaApp());
}

class UsinaApp extends StatelessWidget {
  const UsinaApp({super.key});

  static const _rosa = Color(0xFFE7A1B0);
  static const _rosaClaro = Color(0xFFF3CBD4);
  static const _rosaSuave = Color(0xFFF6DDE2);
  static const _fundo = Color(0xFFF7F5F5);
  static const _preto = Color(0xFF171717);
  static const _texto = Color(0xFF242424);
  static const _cinza = Color(0xFF777777);

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: _rosa,
      brightness: Brightness.light,
    ).copyWith(
      primary: _rosa,
      onPrimary: _preto,
      secondary: const Color(0xFFE98EA5),
      onSecondary: _preto,
      surface: Colors.white,
      onSurface: _texto,
      error: const Color(0xFFB3261E),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Usina App',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: colorScheme,
        scaffoldBackgroundColor: _fundo,
        textTheme: ThemeData.light().textTheme.apply(
              bodyColor: _texto,
              displayColor: _preto,
            ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          foregroundColor: _preto,
          elevation: 0,
          centerTitle: false,
          titleTextStyle: TextStyle(
            color: _preto,
            fontSize: 20,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.3,
          ),
        ),
        drawerTheme: const DrawerThemeData(
          backgroundColor: _fundo,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(32),
              bottomRight: Radius.circular(32),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xBFFFFFFF),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 17,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(21),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(21),
            borderSide: const BorderSide(color: Color(0x14242424)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(21),
            borderSide: const BorderSide(color: _rosa, width: 1.6),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(21),
            borderSide: const BorderSide(color: Color(0xFFB3261E)),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(21),
            borderSide: const BorderSide(color: Color(0xFFB3261E), width: 1.6),
          ),
          labelStyle: const TextStyle(color: _cinza),
          hintStyle: const TextStyle(color: _cinza),
          prefixIconColor: _cinza,
          errorStyle: const TextStyle(fontWeight: FontWeight.w500),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: _preto,
            foregroundColor: Colors.white,
            elevation: 0,
            minimumSize: const Size.fromHeight(54),
            padding: const EdgeInsets.symmetric(horizontal: 22),
            shape: const StadiumBorder(),
            textStyle: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.1,
            ),
          ),
        ),
        cardTheme: CardThemeData(
          color: const Color(0xE6FFFFFF),
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
            side: const BorderSide(color: Color(0x1AFFFFFF)),
          ),
        ),
        snackBarTheme: SnackBarThemeData(
          behavior: SnackBarBehavior.floating,
          backgroundColor: _preto,
          contentTextStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
          shape: const StadiumBorder(),
          insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        ),
      ),
      home: const TelaPrincipal(),
    );
  }
}
