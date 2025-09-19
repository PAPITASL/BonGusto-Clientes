import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  // Controlador del correo
  final _emailCtrl = TextEditingController();

  @override
  void dispose() {
    _emailCtrl.dispose();
    super.dispose();
  }

  // Acción: validar y pasar a confirmación
  void _sendCode() {
    if (_emailCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ingrese su correo')),
      );
      return;
    }
    Navigator.pushNamed(context, '/confirm');
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
              // Tarjeta blanca
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 18,
                      offset: const Offset(0, 8),
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(22, 26, 22, 26),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Botón atrás redondeado
                      Align(
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                          onTap: () => Navigator.pop(context),
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF3F6F4),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(Icons.arrow_back, size: 20),
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),

                      const Text(
                        '¿Olvidaste tu contraseña?',
                        style: TextStyle(
                            fontSize: 28,
                            height: 1.1,
                            letterSpacing: -0.2,
                            fontWeight: FontWeight.w900),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                          'No te preocupes, suele pasar. Por favor ingresa el correo asociado a tu cuenta.',
                          style:
                              TextStyle(fontSize: 14, color: Colors.black54)),
                      const SizedBox(height: 22),

                      const Text('Correo electrónico',
                          style:
                              TextStyle(fontSize: 14, color: Colors.black87)),
                      const SizedBox(height: 6),
                      TextField(
                        controller: _emailCtrl,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          hintText: 'Ingresa tu correo electrónico',
                        ),
                      ),
                      const SizedBox(height: 18),

                      ElevatedButton(
                          onPressed: _sendCode,
                          child: const Text('Enviar código')),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('¿Recordaste tu contraseña? ',
                      style: TextStyle(color: Colors.black54)),
                  GestureDetector(
                    onTap: () =>
                        Navigator.pushReplacementNamed(context, '/login'),
                    child: const Text('Inicia sesión',
                        style: TextStyle(color: Colors.red)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
