import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ConfirmCodeScreen extends StatefulWidget {
  const ConfirmCodeScreen({super.key});

  @override
  State<ConfirmCodeScreen> createState() => _ConfirmCodeScreenState();
}

class _ConfirmCodeScreenState extends State<ConfirmCodeScreen> {
  // Controladores y  los 5 dígitos
  final List<TextEditingController> _otpCtrls =
      List.generate(5, (_) => TextEditingController());
  final List<FocusNode> _otpNodes = List.generate(5, (_) => FocusNode());

  @override
  void dispose() {
    for (final c in _otpCtrls) c.dispose();
    for (final f in _otpNodes) f.dispose();
    super.dispose();
  }

  //Para que automaticamente cambia al siguiente campo
  void _onOtpChanged(int index, String value) {
    if (value.isNotEmpty && index < _otpNodes.length - 1) {
      _otpNodes[index + 1].requestFocus();
    }
    if (value.isEmpty && index > 0) {
      _otpNodes[index - 1].requestFocus();
    }
    setState(() {});
  }

  // Obtiene el código completo
  String get _code => _otpCtrls.map((c) => c.text).join();

  void _confirm() {
    if (_code.length == 5) {
      Navigator.pushNamed(context, '/reset');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ingresa los 5 dígitos')),
      );
    }
  }

  // Widget de una burbuja (campo) del OTP
  Widget _otpBubble(int index) {
    return Container(
      width: 58,
      height: 58,
      decoration: BoxDecoration(
        color: const Color(0xFFF1DADA),
        borderRadius: BorderRadius.circular(18),
      ),
      alignment: Alignment.center,
      child: TextField(
        controller: _otpCtrls[index],
        focusNode: _otpNodes[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: const InputDecoration(counterText: '', border: InputBorder.none),
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        onChanged: (v) => _onOtpChanged(index, v),
      ),
    );
  }

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
              // Título gris de sección
              const Padding(
                padding: EdgeInsets.only(left: 4, bottom: 12),
                child: Text(
                  'Confirmacion',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black38,
                      fontWeight: FontWeight.w600),
                ),
              ),

              // Tarjeta blanca
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 18,
                      offset: const Offset(0, 8),
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(22, 22, 22, 22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Botón atras
                      Align(
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                          onTap: () => Navigator.pop(context),
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF3F6F4),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(Icons.arrow_back, size: 20),
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),

                      const Center(
                        child: Text(
                          'Código',
                          style: TextStyle(
                              fontSize: 28,
                              height: 1.1,
                              letterSpacing: -0.2,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Cápsula con el numero de celular
                      Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 8),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF3F6F4),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Text('+57 314 9978264',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black87,
                                      letterSpacing: 0.2)),
                              SizedBox(width: 6),
                              Icon(Icons.edit, size: 16, color: Colors.black54),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 22),

                      // Fila de los 5 espacios
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(5, _otpBubble),
                      ),
                      const SizedBox(height: 28),

                      // Boton confirmar
                      Center(
                        child: SizedBox(
                          width: 240,
                          child: ElevatedButton(
                            onPressed: _confirm,
                            child: const Text('Confirmar'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}