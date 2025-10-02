import 'package:bongustoap/screens/perfil_screen.dart';
import 'package:flutter/material.dart';
import 'tarjeta_screen.dart';
import 'tarjeta_global.dart';
import 'carrito_global.dart';
import 'calificacion_screen.dart';
import 'menu_screen.dart';
import 'pedidos_screen.dart';

class MetodoPagoPage extends StatefulWidget {
  const MetodoPagoPage({super.key});

  @override
  State<MetodoPagoPage> createState() => _MetodoPagoPageState();
}

class _MetodoPagoPageState extends State<MetodoPagoPage> {
  int metodoSeleccionado = 1; // 0 = Visa, 1 = Mastercard, 2 = Paypal
  int _currentIndex = 0; // ✅ índice para bottom bar

  // ✅ BottomNavigationBar con navegación
  Widget _bottomBar() {
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
    final total = CarritoGlobal.calcularTotal();
    final tieneTarjeta = TarjetaGlobal.tarjetas.isNotEmpty;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Botón regresar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Text(
                    "Regresar",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // Métodos de pago
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                metodoPagoTile("assets/visa.png", "Visa", 0),
                metodoPagoTile("assets/mastercard.png", "Mastercard", 1),
                metodoPagoTile("assets/paypal.png", "PayPal", 2),
              ],
            ),

            const SizedBox(height: 25),

            // Tarjeta ilustrativa o tarjeta guardada
            Center(
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: tieneTarjeta
                    ? Column(
                        children: [
                          const Icon(
                            Icons.credit_card,
                            size: 80,
                            color: Colors.redAccent,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            TarjetaGlobal.tarjetas.last.nombre,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "**** **** **** ${TarjetaGlobal.tarjetas.last.numero.substring(TarjetaGlobal.tarjetas.last.numero.length - 4)}",
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                          Text(
                            "Vence: ${TarjetaGlobal.tarjetas.last.vencimiento}",
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          Image.asset("assets/tarjeta.png", height: 100),
                          const SizedBox(height: 15),
                          const Text(
                            "Tarjeta no agregada",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            "Agrega una tarjeta para poder pagar",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
              ),
            ),

            const SizedBox(height: 25),

            // Botón agregar tarjeta
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TarjetaPage(),
                    ),
                  );
                  setState(() {});
                },
                child: const Text(
                  "Agregar Nueva Tarjeta +",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Total
            Center(
              child: Text(
                "TOTAL: \$${total.toStringAsFixed(0)}",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Botón Pagar
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: tieneTarjeta ? Colors.green : Colors.grey,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: tieneTarjeta
                    ? () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Pago realizado con éxito por \$${total.toStringAsFixed(0)} 💳",
                            ),
                          ),
                        );

                        CarritoGlobal.vaciarCarrito();

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CalificacionScreen(),
                          ),
                        );
                      }
                    : null,
                child: const Text(
                  "Pagar Ahora",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _bottomBar(), //ahora usa el correcto
    );
  }

  // Widget para cada método de pago
  Widget metodoPagoTile(String imagen, String titulo, int index) {
    bool activo = metodoSeleccionado == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          metodoSeleccionado = index;
        });
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(
                color: activo ? Colors.redAccent : Colors.transparent,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Image.asset(imagen, height: 40),
          ),
          const SizedBox(height: 6),
          Text(
            titulo,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: activo ? Colors.redAccent : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
