import 'package:flutter/material.dart';
import 'home_screen.dart';


class CalificacionScreen extends StatefulWidget {
  const CalificacionScreen({super.key});

  @override
  State<CalificacionScreen> createState() => _CalificacionScreenState();
}

class _CalificacionScreenState extends State<CalificacionScreen> {
  int comida = 0;
  int servicio = 0;
  int ambiente = 0;
  final TextEditingController observacionesController = TextEditingController();

  Widget _buildStarRow(int value, Function(int) onChange) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        5,
        (index) => IconButton(
          icon: Icon(
            Icons.star,
            size: 36,
            color: value > index ? Colors.amber : Colors.grey,
          ),
          onPressed: () => setState(() => onChange(index + 1)),
        ),
      ),
    );
  }

  void enviarCalificacion() {
    if (comida == 0 || servicio == 0 || ambiente == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Por favor completa todas las calificaciones")),
      );
      return;
    }

    debugPrint("🍽️ Calidad de la comida: $comida");
    debugPrint("🤝 Atención del personal: $servicio");
    debugPrint("🏠 Ambiente y comodidad: $ambiente");
    debugPrint("📝 Observaciones: ${observacionesController.text}");

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("¡Gracias por tu calificación!")),
    );

    // Ir directamente al Home usando la ruta
    Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Queremos saber tu opinión"),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("¿Cómo calificarías la calidad de la comida?",
                style: TextStyle(fontSize: 16)),
            _buildStarRow(comida, (val) => comida = val),
            const SizedBox(height: 20),

            const Text("¿Qué tan satisfecho estás con la atención del personal?",
                style: TextStyle(fontSize: 16)),
            _buildStarRow(servicio, (val) => servicio = val),
            const SizedBox(height: 20),

            const Text("¿Cómo valorarías el ambiente y la comodidad del restaurante?",
                style: TextStyle(fontSize: 16)),
            _buildStarRow(ambiente, (val) => ambiente = val),
            const SizedBox(height: 20),

            const Text("Observaciones", style: TextStyle(fontSize: 16)),
            TextField(
              controller: observacionesController,
              maxLines: 3,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Escribe tus comentarios aquí...",
              ),
            ),
            const SizedBox(height: 30),

            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: enviarCalificacion,
                child: const Text("Enviar", style: TextStyle(color: Colors.white, fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
