import 'package:flutter/material.dart';
import 'package:gemini_bloc/widgets/chat_bubble_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Center(
        child: ChatBubble(
          isMine: true,
          photoUrl: 'https://picsum.photos/seed/picsum/200/300',
          message: 'this is a message from me',
        ),
      ),
    );
  }
}
