import 'producto_global.dart';

class CarritoGlobal {
  static final List<Producto> productos = [];

  static void agregarProducto(Producto producto) {
    productos.add(producto);
  }

  static void eliminarProductoEn(int index) {
    productos.removeAt(index);
  }

  static double calcularTotal() {
    return productos.fold(
      0,
      (suma, item) => suma + (item.precio * item.cantidad),
    );
  }

  static void vaciarCarrito() {
    productos.clear();
  }
}
