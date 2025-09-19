import 'package:flutter/material.dart';
import 'restaurante_screen.dart'; // 👈 importa tu pantalla Restaurante
import 'mesero_screen.dart';     // 👈 importa tu pantalla Mesero

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  int _currentIndex = 0;

  Widget _bottomBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (i) {
        setState(() => _currentIndex = i);
        if (i != 0) {
          final labels = ['Inicio', 'Pedidos', 'Mapa', 'Perfil'];
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('${labels[i]} (demo)')),
          );
        }
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
      appBar: AppBar(
        title: const Text("Menú del Restaurante"),
        backgroundColor: Colors.red,
      ),
      bottomNavigationBar: _bottomBar(),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16),
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: [
          _menuCard("Ver menú y Ordenar", "assets/menu.png", const RestauranteScreen()),
          _menuCard("Llamar Mesero", "assets/mesero.png", const MeseroScreen()),
          _menuCard("Solicitar Música", "assets/musica.png", const Placeholder()),
          _menuCard("Pagar", "assets/pagos.png", const Placeholder()),
          _menuCard("Próximos Eventos", "assets/reservas.png", const Placeholder()),
          _menuCard("Conócenos", "assets/conocenos.png", const Placeholder()),
        ],
      ),
    );
  }

  // 🔹 Acepta la pantalla como parámetro
  Widget _menuCard(String title, String imagePath, Widget page) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 5,
              offset: const Offset(2, 5),
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              height: 120,
              width: 120,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
