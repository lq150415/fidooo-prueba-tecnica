import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class ChatStore extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> get messagesStream =>
      _firestore.collection('messages').orderBy('timestamp').snapshots();

  Future<void> sendMessage(String text, String sender) async {
    if (text.isEmpty) return;
    await _firestore.collection('messages').add({
      'text': text,
      'sender': sender,
      'timestamp': FieldValue.serverTimestamp(),
    });
    notifyListeners();
  }
}
