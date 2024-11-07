class Validators {
  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'El email no puede estar vacío';
    }
    final emailRegExp = RegExp(r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
    if (!emailRegExp.hasMatch(email)) {
      return 'Introduce un email válido';
    }
    return null;
  }

  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'La contraseña no puede estar vacía';
    } else if (password.length < 6) {
      return 'La contraseña debe tener al menos 6 caracteres';
    }
    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingresa tu nombre';
    }
    return null;
  }

  static String? confirmPassword(String? password, String? confirmPassword) {
    if (password != confirmPassword) {
      return 'Las contraseñas no coinciden';
    }
    return null;
  }
}
