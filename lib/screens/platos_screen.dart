import 'package:flutter/material.dart';

class PlatosPage extends StatelessWidget {
  final String categoria;

  const PlatosPage({super.key, required this.categoria});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barra superior con regresar y carrito
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Platos de $categoria"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () {
              // Aquí navegas al carrito
            },
          )
        ],
      ),

      // Lista de platos
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: 6, // cantidad de platos
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Imagen redondeada
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      "assets/carne.png", // Ajusta tus imágenes
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Info del plato
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Nombre y rating
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "$categoria Especial",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: const [
                                Icon(Icons.star, color: Colors.orange, size: 18),
                                SizedBox(width: 4),
                                Text("4.7"),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(height: 4),

                        // Descripción
                        Text(
                          "Delicioso plato de $categoria preparado con los mejores ingredientes.",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 13, color: Colors.black54),
                        ),
                        const SizedBox(height: 6),

                        // Precio y botón pedir
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "\$119.500",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.redAccent,
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.redAccent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () {
                                // Acción pedir
                              },
                              child: const Text("Pedir"),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),

      // Barra de navegación inferior
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.redAccent,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Inicio"),
          BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: "Pedidos"),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: "Mapa"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Perfil"),
        ],
        currentIndex: 0, // Cambia según la página
        onTap: (index) {
          // Aquí navegas a otras páginas
        },
      ),
    );
  }
}
