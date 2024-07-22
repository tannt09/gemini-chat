import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gemini_bloc/widgets/chat_bubble_widget.dart';
import 'package:gemini_bloc/widgets/message_box_widget.dart';
import 'package:gemini_bloc/worker/genai_worker.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final GenAIWorker _worker = GenAIWorker();
  
  MyApp({super.key});

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
            MessageBox(
              onSendMessage: (value) {
                print('----1111 $value');
              },
            )
          ],
        ),
      ),
    );
  }
}
