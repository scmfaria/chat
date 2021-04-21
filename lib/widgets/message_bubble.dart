import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final bool belongToMe;
  final Key key;
  final String userName;

  MessageBubble(this.message, this.userName, this.belongToMe, {this.key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: belongToMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: belongToMe ? Colors.grey[300] : Theme.of(context).accentColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
              bottomLeft: belongToMe ? Radius.circular(12) : Radius.circular(0),
              bottomRight: belongToMe ? Radius.circular(0) : Radius.circular(12),
            ),
          ),
          width: 140,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          child: Column(
            crossAxisAlignment: belongToMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: belongToMe ? Colors.black : Theme.of(context).accentTextTheme.headline1.color,
                ),
              ),
              Text(
                message,
                style: TextStyle(
                  color: belongToMe ? Colors.black : Theme.of(context).accentTextTheme.headline1.color,
                ),
                textAlign: belongToMe ? TextAlign.end : TextAlign.start,
              ),
            ],
          ),
          margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        ),
      ],
    );
  }
}