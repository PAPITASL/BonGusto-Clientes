import 'package:flutter/material.dart';

class RapidoYRicoScreen extends StatelessWidget {
  const RapidoYRicoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rapido Y Rico'),
        backgroundColor: const Color(0xFFB2281D),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              'assets/home_destacado.jpg',
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 16),
          const Text('Rapido Y Rico',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
          const SizedBox(height: 6),
          const Text('Cocteles - Aperitivos - Wings - Music.',
              style: TextStyle(color: Colors.black54)),
          const SizedBox(height: 16),
          const Text(
            'Puedes extender con reseñas, menús, promos y galería. '
            'Este screen es demostrativo para la navegación.',
          ),
        ],
      ),
    );
  }
}
