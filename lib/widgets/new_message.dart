import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {

  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  String _enteredMessage = '';
  final _controller = TextEditingController();

  Future<void> _sendMessage() async {
    FocusScope.of(context).unfocus();

    final user = FirebaseAuth.instance.currentUser;

    final userData = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

    FirebaseFirestore.instance.collection('chat').add({
      'text': _enteredMessage,
      'createdAt': Timestamp.now(),
      'userId': user.uid,
      'userName': userData.get('name'),
      'userImage': userData.get('imageUrl'),
    });

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Enviar Mensagem'),
              onChanged: (value) {
                setState(() {
                  _enteredMessage = value;
                });
              }
            ),
          ),
          Divider(),
          IconButton(
            icon: Icon(Icons.send), 
            onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage,
          )
        ],
      ),
    );
  }
}