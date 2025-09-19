import 'package:flutter/material.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

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
              const Padding(
                padding: EdgeInsets.only(left: 4, bottom: 12),
                child: Text(
                  'Confirmacion-exitosa',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black38,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.78,
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
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Contraseña cambiada',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 26, fontWeight: FontWeight.w900),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Tu contraseña ha sido cambiada exitosamente.',
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(fontSize: 14, color: Colors.black54),
                        ),
                        const SizedBox(height: 26),
                        SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: ElevatedButton(
                              onPressed: () => Navigator.pushNamedAndRemoveUntil(
                                  context, '/login', (_) => false),
                              child:
                                  const Text('Volver al inicio de sesión'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}