import 'package:flutter/material.dart';
import 'pedidos_screen.dart';
import 'menu_screen.dart';
import 'perfil_screen.dart';

class ConocenosPage extends StatefulWidget {
  const ConocenosPage({super.key});

  @override
  State<ConocenosPage> createState() => _ConocenosPageState();
}

class _ConocenosPageState extends State<ConocenosPage> {
  int _currentIndex = 0; //índice de bottom bar

  Widget _bottomBar(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (i) {
        setState(() => _currentIndex = i);

        if (i == 0) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const MenuScreen()),
          );
        } else if (i == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const PedidosScreen()),
          );
        } else if (i == 2) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Mapa (demo)")),
          );
        } else if (i == 3) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const PerfilScreen()),
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
        BottomNavigationBarItem(
          icon: Icon(Icons.map_outlined),
          label: 'Mapa',
        ),
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
      body: Column(
        children: [
          // ===== Imagen superior con gradiente y botones =====
          Stack(
            children: [
              // Imagen grande
              Container(
                width: double.infinity,
                height: 300,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/rapidoyrico.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // Gradiente
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 140,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, Colors.white],
                    ),
                  ),
                ),
              ),

              // Botón volver
              Positioned(
                top: 40,
                left: 20,
                child: CircleAvatar(
                  backgroundColor: Colors.white.withOpacity(0.8),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.red),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),
            ],
          ),

          // ===== Contenido =====
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Conócenos",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 12),
                  Text(
                    "En Bon Gusto creemos en la magia de los sabores que unen a las personas. "
                    "Nuestro compromiso es ofrecer experiencias gastronómicas únicas, "
                    "combinando ingredientes frescos, pasión por la cocina y un ambiente acogedor.\n\n"
                    "Desde nuestros inicios, buscamos no solo alimentar el cuerpo, "
                    "sino también crear momentos inolvidables alrededor de la mesa. "
                    "Queremos que cada visita sea especial, como si fueras parte de nuestra familia.",
                    style: TextStyle(fontSize: 15, color: Colors.black87, height: 1.4),
                  ),
                  SizedBox(height: 30),
                  Text(
                    "Nuestra misión",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.redAccent,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Ofrecer un servicio de calidad con platos llenos de sabor, "
                    "hechos con amor y dedicación para nuestros clientes.",
                    style: TextStyle(fontSize: 15, color: Colors.black87),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _bottomBar(context), //ahora sí funciona
    );
  }
}
