import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gemini_bloc/widgets/chat_bubble_widget.dart';
import 'package:gemini_bloc/widgets/message_box_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Gemini Chat'),
        ),
        body: Column(
          children: [
            Expanded(
                child: ListView(
              children: const [
                ChatBubble(
                  isMine: false,
                  photoUrl: 'https://picsum.photos/seed/picsum/200/300',
                  message: 'this is a message from me',
                ),
                ChatBubble(
                  isMine: true,
                  photoUrl: 'https://picsum.photos/seed/picsum/200/300',
                  message: 'this is a message from me',
                ),
              ],
            )),
            const MessageBox()
          ],
        ),
      ),
    );
  }
}
