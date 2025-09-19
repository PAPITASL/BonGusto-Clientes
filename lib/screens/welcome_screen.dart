import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double imageHeight = size.height * 0.62; // alto de imagen

    return Scaffold(
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
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 18,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Imagen
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                      child: Stack(
                        children: [
                          SizedBox(
                            height: imageHeight,
                            width: double.infinity,
                            child: Image.asset(
                              'assets/cocktail.png',
                              fit: BoxFit.cover,
                              alignment: Alignment.topCenter,
                            ),
                          ),
                          // Degradado
                          Positioned.fill(
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Colors.white.withOpacity(0.98),
                                  ],
                                  stops: const [0.68, 1.0],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Contenido inferior
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 22),
                      child: Column(
                        children: [
                          const Text(
                            'BonGusto',
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w800),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('No tengo una cuenta, ',
                                  style: TextStyle(color: Colors.black54)),
                              GestureDetector(
                                onTap: () =>
                                    Navigator.pushNamed(context, '/register'),
                                child: const Text('Regístrate',
                                    style: TextStyle(color: Colors.red)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 22),
                          // Botón grande
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: const StadiumBorder(),
                              ),
                              onPressed: () =>
                                  Navigator.pushNamed(context, '/login'),
                              child: const Text('Iniciar sesión'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
