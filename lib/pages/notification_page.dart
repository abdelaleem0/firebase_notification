import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  final String type;
  final String content;

  const NotificationPage({Key? key, required this.type, required this.content})
      : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:const Text(
          "Notification page",
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "type : ${widget.type}",
            style: const TextStyle(
              color: Colors.blue,
              fontSize: 16,
            ),
          ),
          Text(
            "content : ${widget.content}",
            style: const TextStyle(
              color: Colors.blue,
              fontSize: 16,
            ),
          ),
        ],
      )),
    );
  }
}
