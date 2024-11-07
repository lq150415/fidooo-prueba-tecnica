import 'package:flutter/material.dart';
import 'package:chat/ui/forms/register_form.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro'), // Título
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0), 
        child: RegisterForm(),
      ),
    );
  }
}
