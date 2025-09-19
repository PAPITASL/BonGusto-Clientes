// App BonGusto: Rutas
// ==========================
import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/forgot_password_screen.dart';
import 'screens/confirm_code_screen.dart';
import 'screens/reset_password_screen.dart';
import 'screens/success_screen.dart';
import 'screens/home_screen.dart';
import 'screens/pesqueria_screen.dart';
import 'screens/rapido_screen.dart';
import 'screens/menu_screen.dart';
import 'screens/restaurante_screen.dart';
import 'screens/mesero_screen.dart';
import 'screens/platos_screen.dart';

void main() {
  runApp(const BonGustoApp());
}

// Colores de marca
const kBrandRed = Color(0xFFB2281D);
const kFieldFill = Color(0xFFF3F6F4);
const kPageBg = Color(0xFFF5F5F5);

class BonGustoApp extends StatelessWidget {
  const BonGustoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BonGusto',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: kBrandRed,
        scaffoldBackgroundColor: Colors.white,
        // Estilo base de inputs como en tu mock
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: kFieldFill,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 14,
          ),
        ),
        // Botón elevado
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kBrandRed,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: kBrandRed),
        ),
      ),
      // Pantalla inicial de bienvenida
      initialRoute: '/start',
      // Rutas de la app
      routes: {
        '/start': (_) => const WelcomeScreen(),
        '/login': (_) => const LoginScreen(),
        '/register': (_) => const RegisterScreen(),
        '/forgot': (_) => const ForgotPasswordScreen(),
        '/confirm': (_) => const ConfirmCodeScreen(),
        '/reset': (_) => const ResetPasswordScreen(),
        '/success': (_) => const SuccessScreen(),
        '/home': (_) => const HomeScreen(),
        '/pesqueria': (_) => const PesqueriaScreen(),
        '/rapido': (_) => const RapidoYRicoScreen(),
        '/menu': (_) => const MenuScreen(),
        '/restaurante': (_) => const RestauranteScreen(),
        '/mesero': (_) => const MeseroScreen(),
        '/pollo': (_) => const PlatosPage(categoria: "Pollo"),
      },
    );
  }
}
