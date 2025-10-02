import 'package:flutter/material.dart';
import 'menu_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const kBrandRed = Color(0xFFB2281D);
  int _currentIndex = 0;

  // FUNCIÓN PARA ABRIR LA TARJETA MODAL 
  void _openRestaurantCard(String title, String subtitle, String imagePath) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.black.withOpacity(0.5), // oscurecer fondo
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.7,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          builder: (_, controller) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
              ),
              child: ListView(
                controller: controller,
                padding: const EdgeInsets.all(20),
                children: [
                  // Handle bar
                  Center(
                    child: Container(
                      width: 40,
                      height: 5,
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Información de $title - Ubicación: $subtitle",
                    style: const TextStyle(color: Colors.black54),
                  ),
                  const SizedBox(height: 20),
                  Image.asset(
                    imagePath,
                    height: 180,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 20),
                  const Text('Horario: 12 PM - 11 PM'),
                  const SizedBox(height: 10),
                  const Text('Calificación: ⭐ 4.7'),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kBrandRed,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context); // cerrar modal
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const MenuScreen(),
                        ),
                      );
                    },
                    child: const Text("Ver menú"),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  //BANNER ROJO SUPERIOR 
  Widget _promoBanner() {
    return Container(
      height: 140,
      decoration: BoxDecoration(
        color: kBrandRed,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      child: Row(
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: const Text(
                  'Ofertas Imperdibles',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
          ),
          Image.asset(
            'assets/hamburguesa.png',
            height: 120,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }

  // ====== TARJETA "PESQUERIA" =================================================
  Widget _pesqueriaButton(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () =>
          _openRestaurantCard('Pesquería', '1 Km', 'assets/pesqueria.png'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Image.asset(
              'assets/pesqueria.png',
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
          ),
          const SizedBox(height: 10),
          const Text('Pesqueria',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
          const SizedBox(height: 2),
          const Text('1 Km', style: TextStyle(color: Colors.black54)),
        ],
      ),
    );
  }

  // ====== MINI CARD ===========================================================
  Widget _miniInfoCardButton(
      BuildContext context, String title, String subtitle, String imagePath) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () => _openRestaurantCard(title, subtitle, imagePath),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
            const SizedBox(height: 6),
            Text(subtitle, style: const TextStyle(color: Colors.black54)),
          ],
        ),
      ),
    );
  }

  // ====== SECCIÓN "LO MÁS CERCANO" ============================================
  Widget _nearbySection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Lo mas cercano',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
        const SizedBox(height: 12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _pesqueriaButton(context)),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                children: [
                  _miniInfoCardButton(
                      context, 'Bocado Express', '1 km', 'assets/bandeja.png'),
                  const SizedBox(height: 16),
                  _miniInfoCardButton(
                      context, 'Saber En Marcha', '500 mts', 'assets/pesqueria.png'),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ====== TARJETA DESTACADO (RÁPIDO Y RICO) ===================================
  Widget _featuredCard(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () => _openRestaurantCard(
          'Rápido Y Rico', '2 Km', 'assets/bandeja.png'),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(18),
                topRight: Radius.circular(18),
              ),
              child: Image.asset(
                'assets/bandeja.png',
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Rapido Y Rico',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 4),
                  const Text(
                    'Cocteles - Aperitivos - Wings - Music.',
                    style: TextStyle(color: Colors.black54),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: const [
                      Icon(Icons.star_border_rounded, size: 22),
                      SizedBox(width: 6),
                      Text('4.7'),
                      SizedBox(width: 16),
                      Icon(Icons.event_available, size: 20),
                      SizedBox(width: 6),
                      Text('Reserva'),
                      SizedBox(width: 16),
                      Icon(Icons.schedule, size: 20),
                      SizedBox(width: 6),
                      Text('12 PM'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ====== BOTTOM NAVIGATION BAR ================================================
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
      selectedItemColor: kBrandRed,
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

  // ====== BUILD ================================================================
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
                  'Inicio',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black38,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
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
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(22, 22, 22, 22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _promoBanner(),
                      const SizedBox(height: 22),
                      _nearbySection(context),
                      const SizedBox(height: 22),
                      const Text('Destacados',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w800)),
                      const SizedBox(height: 12),
                      _featuredCard(context),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _bottomBar(),
    );
  }
}
