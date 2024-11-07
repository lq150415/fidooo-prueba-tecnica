import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chat/store/auth_store.dart';
import 'package:chat/utils/validators.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  LoginFormState createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false; // Estado de carga

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signIn(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true; 
      });

      final authStore = Provider.of<AuthStore>(context, listen: false);
      await authStore.signIn(_emailController.text, _passwordController.text);

      setState(() {
        isLoading = false; 
      });

      if (context.mounted) {
        if (authStore.user != null) {
          Navigator.pushReplacementNamed(context, '/chat');
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Error en la autenticación')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(labelText: 'Email'),
            validator: (value) => Validators.validateEmail(value ?? ''),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: _passwordController,
            decoration: const InputDecoration(labelText: 'Contraseña'),
            obscureText: true,
            validator: (value) => Validators.validatePassword(value ?? ''),
          ),
          const SizedBox(height: 20),
          isLoading 
              ? const CircularProgressIndicator()
              : ElevatedButton(
                  onPressed: () => _signIn(context),
                  child: const Text('Iniciar Sesión'),
                ),
          TextButton(
            style: _styleTextButton(),
            onPressed: () {
              Navigator.pushNamed(context, '/register');
            },
            child: const Text('¿No tienes una cuenta? Regístrate'),
          ),
          TextButton(
            style: _styleTextButton(),
            onPressed: () {
              Navigator.pushNamed(context, '/reset_password');
            },
            child: const Text('¿Olvidaste tu contraseña?'),
          ),
        ],
      ),
    );
  }

  _styleTextButton() {
    return const ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(Colors.blueAccent));
  }
}
