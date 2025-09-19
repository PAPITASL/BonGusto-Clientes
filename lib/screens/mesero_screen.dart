import 'package:flutter/material.dart';

class MeseroScreen extends StatefulWidget {
  const MeseroScreen({super.key});

  @override
  State<MeseroScreen> createState() => _MeseroScreenState();
}

class _MeseroScreenState extends State<MeseroScreen> {
  int _currentIndex = 1; // posición en la barra (Pedidos en este caso)

  Widget _bottomBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (i) {
        setState(() => _currentIndex = i);
        // Aquí podrías navegar a otras pantallas
        final labels = ['Inicio', 'Pedidos', 'Mapa', 'Perfil'];
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${labels[i]} (demo)')),
        );
      },
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.red,
      unselectedItemColor: Colors.black38,
      showUnselectedLabels: true,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Inicio'),
        BottomNavigationBarItem(icon: Icon(Icons.list_alt_outlined), label: 'Pedidos'),
        BottomNavigationBarItem(icon: Icon(Icons.map_outlined), label: 'Mapa'),
        BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Perfil'),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _bottomBar(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Imagen del mesero
          Center(
            child: Image.asset(
              "assets/meserologo.png", // asegúrate que exista en assets
              height: 400,
            ),
          ),

          const SizedBox(height: 20),

          // Texto
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.0),
            child: Text(
              "¡Gracias por tu paciencia!\nEn unos instantes tu mesero estará contigo.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
          ),

          const SizedBox(height: 40),

          // Botón rojo
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Se registró que ya te atendieron")),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "Listo, ya me atendieron",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
