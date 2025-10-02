import 'package:flutter/material.dart';
import 'pedido_global.dart';

class PedidosScreen extends StatefulWidget {
  const PedidosScreen({super.key});

  @override
  State<PedidosScreen> createState() => _PedidosScreenState();
}

class _PedidosScreenState extends State<PedidosScreen> {
  @override
  Widget build(BuildContext context) {
    final pedidos = PedidoGlobal.obtenerPedidos();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Mis Pedidos"),
        backgroundColor: Colors.red,
      ),
      body: pedidos.isEmpty
          ? const Center(child: Text("No tienes pedidos todavía"))
          : ListView.builder(
              itemCount: pedidos.length,
              itemBuilder: (context, index) {
                final pedido = pedidos[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    title: Text("Pedido #${pedido.id}"),
                    subtitle: Text(
                      "Estado: ${pedido.estado}\n"
                      "Productos: ${pedido.productos.map((p) => p.nombre).join(", ")}",
                    ),
                    trailing: const Icon(Icons.fastfood, color: Colors.red),
                  ),
                );
              },
            ),
    );
  }
}
