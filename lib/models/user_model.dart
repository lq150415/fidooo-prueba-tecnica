class UserModel {
  final String uid;
  final String name;
  final String email;

  UserModel({required this.uid, required this.name, required this.email});

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
    };
  }
}