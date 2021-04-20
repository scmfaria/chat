
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'message_bubble.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseAuth.instance.currentUser(),
      builder: (ctx, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator()
          );
        }

        return StreamBuilder(
          stream: Firestore.instance.collection('chat')
              .orderBy('createdAt', descending: true).snapshots(),
          builder: (ctx, chatSnapshot) {
            if(chatSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            final chatDocs = chatSnapshot.data.documents;
            return ListView.builder(
              reverse: true,
              itemCount: chatDocs.length,
              itemBuilder: (ctx, i) => MessageBubble(
                chatDocs[i]['text'],
                chatDocs[i]['userId'] == snapshot.data.uid ? true : false,
                key: ValueKey(chatDocs[i].documentID),
              ),
            );
          },
        );
      }
    );
  }
}