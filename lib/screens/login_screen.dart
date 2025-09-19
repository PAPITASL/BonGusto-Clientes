import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //Controladores y estado
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _obscure = true;
  bool _emailValido = false;

  //Cuenta demo
  final String demoEmail = "juanito@gmail.com";
  final String demoPass = "Juanito1234!";

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  //Regex de email
  bool _isValidEmail(String v) {
    final reg = RegExp(r'^[\w\.\-]+@([\w\-]+\.)+[a-zA-Z]{2,}$');
    return reg.hasMatch(v);
  }

  //Login
  void _login() {
    if (_formKey.currentState!.validate()) {
      final email = _emailCtrl.text.trim();
      final pass = _passCtrl.text.trim();

      if (email == demoEmail && pass == demoPass) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Correo o contraseña incorrectos')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tarjeta
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 18,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(22, 26, 22, 26),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'Iniciar sesión',
                          style: TextStyle(
                              fontSize: 28,
                              height: 1.1,
                              letterSpacing: -0.2,
                              fontWeight: FontWeight.w900),
                        ),
                        const SizedBox(height: 24),

                        // Correo
                        const Text('Correo electrónico',
                            style:
                                TextStyle(fontSize: 14, color: Colors.black87)),
                        const SizedBox(height: 6),
                        TextFormField(
                          controller: _emailCtrl,
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (v) => setState(() {
                            _emailValido = _isValidEmail(v.trim());
                          }),
                          decoration: InputDecoration(
                            hintText: 'ejemplo@gmail.com',
                            // Icono cuando el correo es válido
                            suffixIcon: _emailValido
                                ? const Icon(Icons.check_circle_rounded,
                                    color: Color(0xFFB2281D))
                                : null,
                          ),
                          validator: (v) {
                            if (v == null || v.trim().isEmpty) {
                              return 'Ingrese su correo';
                            }
                            if (!_isValidEmail(v.trim())) {
                              return 'Correo no válido';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),

                        // Contraseña
                        const Text('Contraseña',
                            style:
                                TextStyle(fontSize: 14, color: Colors.black87)),
                        const SizedBox(height: 6),
                        TextFormField(
                          controller: _passCtrl,
                          obscureText: _obscure,
                          decoration: InputDecoration(
                            hintText: 'ingresar contraseña',
                            suffixIcon: IconButton(
                              icon: Icon(_obscure
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onPressed: () =>
                                  setState(() => _obscure = !_obscure),
                            ),
                          ),
                          validator: (v) {
                            if (v == null || v.isEmpty) {
                              return 'Ingrese su contraseña';
                            }
                            if (v.length < 8) {
                              return 'Mínimo 8 caracteres';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () =>
                                Navigator.pushNamed(context, '/forgot'),
                            child: const Text('¿Olvidaste tu contraseña?',
                                style: TextStyle(color: Colors.red)),
                          ),
                        ),
                        const SizedBox(height: 18),

                        // Botón iniciar sesion
                        ElevatedButton(
                            onPressed: _login,
                            child: const Text('Iniciar sesión')),
                        const SizedBox(height: 22),

                        // Enlace Regístrate
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('¿No tienes una cuenta? ',
                                style: TextStyle(color: Colors.black54)),
                            GestureDetector(
                              onTap: () =>
                                  Navigator.pushNamed(context, '/register'),
                              child: const Text('Regístrate',
                                  style: TextStyle(color: Colors.red)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
