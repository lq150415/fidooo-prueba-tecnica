import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chat/store/auth_store.dart';

class ResetPasswordPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authStore = Provider.of<AuthStore>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Restablecer Contraseña'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Correo electrónico'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (_emailController.text.isNotEmpty) {
                  try {
                    // Llamada al método de restablecer contraseña del AuthStore
                    await authStore.resetPassword(_emailController.text);
                    // Mostrar mensaje de éxito
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Correo de restablecimiento enviado")),
                    );
                    Navigator.pop(context); // Regresar a la página de login
                  } catch (e) {
                    // Manejo de errores
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Error: ${e.toString()}")),
                    );
                  }
                } else {
                  // Solicitar al usuario que ingrese un correo
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Por favor ingresa un correo")),
                  );
                }
              },
              child: const Text('Enviar correo de restablecimiento'),
            ),
          ],
        ),
      ),
    );
  }
}
