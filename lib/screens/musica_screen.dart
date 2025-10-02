import 'package:bongustoap/screens/perfil_screen.dart';
import 'package:flutter/material.dart';
import 'custom_app_bar.dart';
import 'pedidos_screen.dart';
import 'menu_screen.dart';

class MusicaScreen extends StatefulWidget {
  const MusicaScreen({super.key});

  @override
  State<MusicaScreen> createState() => _MusicaScreenState();
}

class _MusicaScreenState extends State<MusicaScreen> {
  int _currentIndex = 0;

  // Lista inicial
  List<Map<String, String>> listaReproduccion = [
    {"titulo": "Hound Dog", "artista": "Elvis Presley"},
  ];

  // Canción actual
  Map<String, String> cancionActual = {
    "titulo": "Hound Dog",
    "artista": "Elvis Presley",
    "imagen": "assets/elvis.png", //asegúrate de tener este asset
  };

  // ---------------- NAVIGATION BAR -----------------
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
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const PedidosScreen()),
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
  // -------------------------------------------------

  // 🔹 Mostrar lista emergente
  void mostrarListaReproduccion() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          builder: (_, controller) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Text(
                    "🎶 Lista de Reproducción",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: ListView.builder(
                      controller: controller,
                      itemCount: listaReproduccion.length,
                      itemBuilder: (context, index) {
                        final cancion = listaReproduccion[index];
                        return ListTile(
                          leading: const Icon(Icons.music_note, color: Colors.red),
                          title: Text(cancion["titulo"]!),
                          subtitle: Text(cancion["artista"]!),
                        );
                      },
                    ),
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      _mostrarDialogAgregar();
                    },
                    icon: const Icon(Icons.add, color: Colors.white),
                    label: const Text(
                      "Agregar Canción",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // Diálogo para agregar canción
  void _mostrarDialogAgregar() {
    final formKey = GlobalKey<FormState>();
    final tituloController = TextEditingController();
    final artistaController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Agregar Canción"),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: tituloController,
                decoration: const InputDecoration(labelText: "Título"),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "El título no puede estar vacío";
                  }
                  if (!RegExp(r"^[a-zA-Z0-9\sáéíóúÁÉÍÓÚñÑ]+$")
                      .hasMatch(value.trim())) {
                    return "El título solo puede contener letras y números";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: artistaController,
                decoration: const InputDecoration(labelText: "Artista"),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "El artista no puede estar vacío";
                  }
                  if (!RegExp(r"^[a-zA-Z\sáéíóúÁÉÍÓÚñÑ]+$")
                      .hasMatch(value.trim())) {
                    return "El artista solo puede contener letras";
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancelar"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              if (formKey.currentState!.validate()) {
                setState(() {
                  listaReproduccion.add({
                    "titulo": tituloController.text.trim(),
                    "artista": artistaController.text.trim(),
                  });
                });
                Navigator.pop(context);
                mostrarListaReproduccion();
              }
            },
            child: const Text("Agregar"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _bottomBar(), //Barra de navegación
      body: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Text(
                      "¡Qué canción vamos a escuchar!",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (cancionActual["imagen"] != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        cancionActual["imagen"]!,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                  const SizedBox(height: 12),
                  Text(
                    cancionActual["titulo"]!,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    cancionActual["artista"]!,
                    style: const TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: mostrarListaReproduccion,
                    child: const Text(
                      "Lista Reproducción",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const CustomFloatingAppBar(
            showBack: true,
            showCart: true,
          ),
        ],
      ),
    );
  }
}
