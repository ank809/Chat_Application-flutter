import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  String uid1;
  String uid2;
  String text;

  ChatModel({
    required this.uid1,
    required this.uid2,
    required this.text,
  });

  Future<void> sendMessage() async {
    final CollectionReference chatCollection =
        FirebaseFirestore.instance.collection('chats');

    final chatSnapshot = await chatCollection
        .where('participants', arrayContainsAny: [uid1, uid2]).get();

    if (chatSnapshot.docs.isNotEmpty) {
      final chatDoc = chatSnapshot.docs.first;
      await chatDoc.reference.update({
        'messages': FieldValue.arrayUnion([
          {
            'sender_uid': uid1,
            'recever_uid': uid2,
            'text': text,
          }
        ])
      });
    } else {
      final newChatDOc = await chatCollection.add({
        'participants': [uid1, uid2],
        'messages': [
          {
            'sender_uid': uid1,
            'recever_uid': uid2,
            'text': text,
          }
        ]
      });
    }
  }
}
