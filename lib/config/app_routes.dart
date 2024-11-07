import 'package:chat/ui/pages/reset_password_page.dart';
import 'package:flutter/material.dart';
import 'package:chat/ui/pages/login_page.dart';
import 'package:chat/ui/pages/register_page.dart';
import 'package:chat/ui/pages/chat_page.dart';

class AppRoutes {
  static final Map<String, WidgetBuilder> routes = {
    '/': (context) => LoginPage(),
    '/chat': (context) => ChatPage(),
    '/register': (context) => RegisterPage(),
    '/reset_password': (context) => ResetPasswordPage(),
  };
}
