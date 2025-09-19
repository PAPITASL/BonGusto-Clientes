import 'package:flutter/material.dart';

class DetallePlatoPage extends StatelessWidget {
  final String nombre;
  final String descripcion;
  final String precio;
  final String imagen;

  const DetallePlatoPage({
    super.key,
    required this.nombre,
    required this.descripcion,
    required this.precio,
    required this.imagen,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Imagen con gradiente
          Column(
            children: [
              Stack(
                children: [
                  // Imagen del plato
                  Container(
                    width: double.infinity,
                    height: 280,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(imagen),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // Gradiente abajo
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 120,
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
                  // Botón regresar
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
                  // Botón carrito
                  Positioned(
                    top: 40,
                    right: 20,
                    child: CircleAvatar(
                      backgroundColor: Colors.red,
                      child: IconButton(
                        icon: const Icon(Icons.shopping_cart, color: Colors.white),
                        onPressed: () {
                          // Ir al carrito
                        },
                      ),
                    ),
                  ),
                ],
              ),

              // Contenido del detalle
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Nombre
                      Text(
                        nombre,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Descripción
                      Text(
                        descripcion,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Precio
                      Text(
                        "\$$precio",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent,
                        ),
                      ),
                      const SizedBox(height: 25),

                      // Botón
                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            // Acción agregar al carrito
                          },
                          child: const Text(
                            "Agregar al carrito",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),

      // Barra inferior
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.redAccent,
        unselectedItemColor: Colors.black38,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Inicio"),
          BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: "Pedidos"),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: "Mapa"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Perfil"),
        ],
        currentIndex: 0,
        onTap: (index) {
          // navegación inferior
        },
      ),
    );
  }
}
