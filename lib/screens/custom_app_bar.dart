// lib/widgets/custom_floating_app_bar.dart
import 'package:flutter/material.dart';
import '../screens/carrito_screen.dart';

class CustomFloatingAppBar extends StatelessWidget {
  final bool showBack;
  final bool showCart;
  final Color backColor;
  final Color cartColor;

  const CustomFloatingAppBar({
    super.key,
    this.showBack = true,
    this.showCart = true,
    this.backColor = Colors.red,
    this.cartColor = const Color(0xFFB2281D),
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (showBack)
          Positioned(
            top: 40,
            left: 16,
            child: CircleAvatar(
              backgroundColor: Colors.white.withOpacity(0.9),
              radius: 20,
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: Icon(Icons.arrow_back, color: backColor),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
        if (showCart)
          Positioned(
            top: 40,
            right: 16,
            child: CircleAvatar(
              backgroundColor: cartColor,
              radius: 20,
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: const Icon(Icons.shopping_cart, color: Colors.white),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CarritoPage()),
                  );
                },
              ),
            ),
          ),
      ],
    );
  }
}
