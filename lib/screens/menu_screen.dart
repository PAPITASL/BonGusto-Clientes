import 'package:bongustoap/screens/perfil_screen.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; //Importa url_launcher
import 'restaurante_screen.dart';
import 'mesero_screen.dart';
import 'metodos_screen.dart';
import 'conocenos_screen.dart';
import 'musica_screen.dart';
import 'pedidos_screen.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  int _currentIndex = 0;

  // Función para abrir WhatsApp
  Future<void> abrirWhatsApp() async {
    const telefono = "+573028416412"; // 🔹 cambia por tu número con código país
    const mensaje =
        "Hola, quiero más información sobre los próximos eventos 🎉";
    final url = Uri.parse("https://wa.me/$telefono?text=$mensaje");

    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw "No se pudo abrir WhatsApp";
    }
  }

  Widget _bottomBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (i) {
        setState(() => _currentIndex = i);

        if (i == 0) {
          // Inicio (ya estás en esta pantalla)
        } else if (i == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PedidosScreen()),
          );
        } else if (i == 2) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Mapa (demo)")),
          );
        } else if (i == 3) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PerfilScreen()),
          );
        }
      },
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.red,
      unselectedItemColor: Colors.black38,
      showUnselectedLabels: true,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: 'Inicio',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list_alt_outlined),
          label: 'Pedidos',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.map_outlined), label: 'Mapa'),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'Perfil',
        ),
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
      body: Center(
        child: SingleChildScrollView(
          child: Wrap(
            alignment: WrapAlignment.center,
            spacing: 16,
            runSpacing: 16,
            children: [
              _menuCard(
                "Ver menú y Ordenar",
                "assets/menu.png",
                const RestauranteScreen(),
              ),
              _menuCard(
                  "Llamar Mesero", "assets/mesero.png", const MeseroScreen()),
              _menuCard(
                "Solicitar Música",
                "assets/musica.png",
                const MusicaScreen(),
              ),
              _menuCard("Pagar", "assets/pagos.png", const MetodoPagoPage()),
              // Aquí cambiamos para que abra WhatsApp
              GestureDetector(
                onTap: abrirWhatsApp,
                child: _menuCardSinNavegacion(
                  "Próximos Eventos",
                  "assets/reservas.png",
                ),
              ),
              _menuCard(
                  "Conócenos", "assets/conocenos.png", const ConocenosPage()),
            ],
          ),
        ),
      ),
    );
  }

  //Tarjeta normal (lleva a otra pantalla)
  Widget _menuCard(String title, String imagePath, Widget page) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },
      child: _menuCardSinNavegacion(title, imagePath),
    );
  }

  // 🔹 Tarjeta sin navegación (ejemplo: WhatsApp)
  Widget _menuCardSinNavegacion(String title, String imagePath) {
    return Container(
      width: 170,
      height: 170,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 5,
            offset: const Offset(2, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(imagePath, height: 100, width: 100, fit: BoxFit.contain),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
