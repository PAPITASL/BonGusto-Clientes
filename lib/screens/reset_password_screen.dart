import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _pass1Ctrl = TextEditingController();
  final _pass2Ctrl = TextEditingController();
  bool _obscure1 = true;
  bool _obscure2 = true;

  @override
  void dispose() {
    _pass1Ctrl.dispose();
    _pass2Ctrl.dispose();
    super.dispose();
  }

  bool _strongPass(String v) {
    final reg = RegExp(
        r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&\.\-\_]).{8,}$');
    return reg.hasMatch(v);
  }

  void _reset() {
    final p1 = _pass1Ctrl.text;
    final p2 = _pass2Ctrl.text;

    if (!_strongPass(p1)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content:
              Text('Incluye mayúscula, minúscula, número y símbolo (8+)')));
      return;
    }
    if (p1 != p2) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Las contraseñas no coinciden')));
      return;
    }

    Navigator.pushReplacementNamed(context, '/success');
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
              // Título gris
              const Padding(
                padding: EdgeInsets.only(left: 4, bottom: 12),
                child: Text(
                  'Cambiar contraseña',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black38,
                      fontWeight: FontWeight.w600),
                ),
              ),

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
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(22, 26, 22, 26),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Botón atras
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
                        'Restablecer contraseña',
                        style: TextStyle(
                            fontSize: 28,
                            height: 1.1,
                            letterSpacing: -0.2,
                            fontWeight: FontWeight.w900),
                      ),
                      const SizedBox(height: 6),
                      const Text('Por favor escribe algo que puedas recordar.',
                          style:
                              TextStyle(fontSize: 14, color: Colors.black54)),
                      const SizedBox(height: 22),

                      // Nueva contraseña
                      const Text('Nueva contraseña',
                          style:
                              TextStyle(fontSize: 14, color: Colors.black87)),
                      const SizedBox(height: 6),
                      TextField(
                        controller: _pass1Ctrl,
                        obscureText: _obscure1,
                        decoration: InputDecoration(
                          hintText: 'debe tener al menos 8 caracteres',
                          suffixIcon: IconButton(
                            icon: Icon(_obscure1
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () =>
                                setState(() => _obscure1 = !_obscure1),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Confirmar contraseña
                      const Text('Confirmar nueva contraseña',
                          style:
                              TextStyle(fontSize: 14, color: Colors.black87)),
                      const SizedBox(height: 6),
                      TextField(
                        controller: _pass2Ctrl,
                        obscureText: _obscure2,
                        decoration: InputDecoration(
                          hintText: 'repetir contraseña',
                          suffixIcon: IconButton(
                            icon: Icon(_obscure2
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () =>
                                setState(() => _obscure2 = !_obscure2),
                          ),
                        ),
                      ),
                      const SizedBox(height: 22),

                      // boton restablecer
                      ElevatedButton(
                          onPressed: _reset,
                          child: const Text('Restablecer contraseña')),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('¿Ya tienes una cuenta? ',
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
