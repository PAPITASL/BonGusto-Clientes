import 'package:flutter/material.dart';
import 'platos_screen.dart'; // 👈 Importa la nueva pantalla de platos

class RestauranteScreen extends StatefulWidget {
  const RestauranteScreen({super.key});

  @override
  State<RestauranteScreen> createState() => _RestauranteScreenState();
}

class _RestauranteScreenState extends State<RestauranteScreen> {
  int _currentIndex = 0;

  // 🔽 Barra inferior
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
      bottomNavigationBar: _bottomBar(), // ✅ Barra inferior
      body: Stack(
        children: [
          // 🔥 Contenido principal con scroll
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Banner con difuminado
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 280,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/restaurante1.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    // Difuminado en la parte inferior
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 100,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.white,
                            ],
                          ),
                        ),
                      ),
                    ),
                    // 🔙 Botón regresar (arriba izquierda)
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
                    // 🛒 Botón carrito (arriba derecha)
                    Positioned(
                      top: 40,
                      right: 20,
                      child: CircleAvatar(
                        backgroundColor: Colors.red,
                        child: IconButton(
                          icon: const Icon(Icons.shopping_cart, color: Colors.white),
                          onPressed: () {
                            // lógica del carrito
                          },
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Sección de platos destacados
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    "Platos destacados",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),

                const SizedBox(height: 12),

                SizedBox(
                  height: 200,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _platoCard("Carnes 3/4", "assets/carne1.png"),
                      _platoCard("Carnes 3/4", "assets/carne2.png"),
                      _platoCard("Carnes 3/4", "assets/carne3.png"),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Sección de categorías
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    "Categorías",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),

                const SizedBox(height: 12),

                SizedBox(
                  height: 200,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _categoriaCard("Carnes", "assets/carne1.png"),
                      _categoriaCard("Pollo", "assets/carne2.png"),
                      _categoriaCard("Pescado", "assets/carne3.png"),
                    ],
                  ),
                ),

                const SizedBox(height: 80), // espacio final
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 🔥 Card de platos destacados (no redirige, solo muestra)
  Widget _platoCard(String title, String imagePath) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(left: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(2, 4),
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipOval(
            child: Image.asset(
              imagePath,
              height: 80,
              width: 80,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text("Pedir"),
          )
        ],
      ),
    );
  }

  // 🔥 Card de categorías (redirige a MenuPlatosPage)
  Widget _categoriaCard(String title, String imagePath) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PlatosPage(categoria: title),
          ),
        );
      },
      child: _platoCard(title, imagePath),
    );
  }
}
