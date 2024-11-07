import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../models/user_model.dart';
import '../../services/auth_service.dart';
import '../../services/firestore_service.dart';
import '../../utils/validators.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  RegisterFormState createState() => RegisterFormState();
}

class RegisterFormState extends State<RegisterForm> {
  final AuthService _authService = AuthService();
  final FirestoreService _firestoreService = FirestoreService();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool isLoading = false; // Estado para controlar si se está cargando

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  bool _validateForm() {
    return _formKey.currentState?.validate() ?? false;
  }

  Future<void> _register(BuildContext context) async {
    if (_validateForm()) {
      setState(() {
        isLoading = true; 
      });

      try {
        // Crear usuario usando el AuthService
        var user = await _authService.registerUser(
          _emailController.text,
          _passwordController.text,
        );

        if (user != null) {
          // Crear una instancia del modelo de usuario
          UserModel newUser = UserModel(
            uid: user.uid,
            name: _nameController.text,
            email: _emailController.text,
          );

          // Guardar datos del usuario en Firestore usando FirestoreService
          await _firestoreService.saveUserData(newUser);

          // Navegar al chat si la autenticación es exitosa
          if (context.mounted) {
            Navigator.pushReplacementNamed(context, '/chat');
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Error al autenticar el usuario')),
          );
        }
      } on FirebaseAuthException catch (e) {
        String errorMessage = 'Error desconocido';
        if (e.code == 'weak-password') {
          errorMessage = 'La contraseña es muy débil';
        } else if (e.code == 'email-already-in-use') {
          errorMessage = 'Este correo electrónico ya está en uso';
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      } finally {
        setState(() {
          isLoading = false; 
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Nombre'),
            validator: Validators.validateName,
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(labelText: 'Email'),
            validator: Validators.validateEmail,
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: _passwordController,
            decoration: const InputDecoration(labelText: 'Contraseña'),
            obscureText: true,
            validator: Validators.validatePassword,
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: _confirmPasswordController,
            decoration:
                const InputDecoration(labelText: 'Confirmar Contraseña'),
            obscureText: true,
            validator: (value) =>
                Validators.confirmPassword(_passwordController.text, value),
          ),
          const SizedBox(height: 20),
          isLoading // Si está cargando, mostrar el indicador en vez del botón
              ? const CircularProgressIndicator()
              : ElevatedButton(
                  onPressed: () => _register(context),
                  child: const Text('Registrar'),
                ),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
            child: const Text('¿Ya tienes una cuenta? Inicia sesión'),
          ),
        ],
      ),
    );
  }
}
