import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}
class _RegisterScreenState extends State<RegisterScreen> {
  //Controladores
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();

  //State de visibilidad de contraseñas
  bool _obscure1 = true;
  bool _obscure2 = true;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  //Validación de email
  bool _isValidEmail(String v) {
    final reg = RegExp(r'^[\w\.\-]+@([\w\-]+\.)+[a-zA-Z]{2,}$');
    return reg.hasMatch(v);
  }

  //Seguridad de contraseña
  bool _strongPass(String v) {
    final reg = RegExp(
        r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&\.\-\_]).{8,}$');
    return reg.hasMatch(v);
  }

  //Accion Registrar
  void _register() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registro exitoso')),
      );
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Fondo gris
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
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // Título y Boton atras
                        Row(
                          children: [
                            const Expanded(
                              child: Text(
                                'Registro',
                                style: TextStyle(
                                    fontSize: 28,
                                    height: 1.1,
                                    letterSpacing: -0.2,
                                    fontWeight: FontWeight.w900),
                              ),
                            ),
                            InkWell(
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
                          ],
                        ),
                        const SizedBox(height: 22),

                        // Nombre
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Nombre completo',
                              style: TextStyle(
                                  fontSize: 14, color: Colors.black87)),
                        ),
                        const SizedBox(height: 6),
                        TextFormField(
                          controller: _nameCtrl,
                          decoration: const InputDecoration(
                            hintText: 'ingresar nombre y apellidos',
                          ),
                          validator: (v) => (v == null || v.trim().isEmpty)
                              ? 'Campo requerido'
                              : null,
                        ),
                        const SizedBox(height: 16),

                        // Correo
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Correo electrónico',
                              style: TextStyle(
                                  fontSize: 14, color: Colors.black87)),
                        ),
                        const SizedBox(height: 6),
                        TextFormField(
                          controller: _emailCtrl,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            hintText: 'ejemplo@gmail.com',
                          ),
                          validator: (v) {
                            if (v == null || v.trim().isEmpty) {
                              return 'Campo requerido';
                            }
                            if (!_isValidEmail(v.trim())) {
                              return 'Correo no válido';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),

                        // contraseña
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Crear contraseña',
                              style: TextStyle(
                                  fontSize: 14, color: Colors.black87)),
                        ),
                        const SizedBox(height: 6),
                        TextFormField(
                          controller: _passCtrl,
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
                          validator: (v) {
                            if (v == null || v.isEmpty) {
                              return 'Campo requerido';
                            }
                            if (!_strongPass(v)) {
                              return 'Incluye mayúscula, minúscula, número y símbolo';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),

                        // Confirmar contraseña
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Confirmar contraseña',
                              style: TextStyle(
                                  fontSize: 14, color: Colors.black87)),
                        ),
                        const SizedBox(height: 6),
                        TextFormField(
                          controller: _confirmCtrl,
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
                          validator: (v) =>
                              (v != _passCtrl.text) ? 'No coincide' : null,
                        ),
                        const SizedBox(height: 24),

                        // Botón egistro
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _register,
                            child: const Text('Registro'),
                          ),
                        ),
                        const SizedBox(height: 22),

                        // Iniciar sesion
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('¿Ya tienes una cuenta? ',
                                style: TextStyle(color: Colors.black54)),
                            GestureDetector(
                              onTap: () =>
                                  Navigator.pushNamed(context, '/login'),
                              child: const Text('Iniciar sesión',
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