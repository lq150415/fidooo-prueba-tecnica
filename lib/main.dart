// main.dart
import 'package:chat/config/app_routes.dart';
import 'package:chat/config/firebase_options.dart';
import 'package:chat/store/auth_store.dart';
import 'package:chat/store/chat_store.dart';
import 'package:chat/ui/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  // Inicialización de Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Proveedor para la autenticación
        Provider<AuthStore>(create: (_) => AuthStore()),
        // Proveedor para manejar el chat
        ChangeNotifierProvider<ChatStore>(create: (_) => ChatStore())
      ],
      child: MaterialApp(
        title: 'Chat App',
        debugShowCheckedModeBanner: false, // Elimina el banner de debug
        theme: AppTheme.lightTheme,
        initialRoute: '/', // Ruta inicial
        routes: AppRoutes.routes, // Rutas de la app
      ),
    );
  }
}
