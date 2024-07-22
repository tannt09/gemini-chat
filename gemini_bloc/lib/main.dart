import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gemini_bloc/widgets/chat_bubble_widget.dart';
import 'package:gemini_bloc/widgets/message_box_widget.dart';
import 'package:gemini_bloc/worker/genai_worker.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {

  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GenAIWorker _worker = GenAIWorker();

  final ScrollController _controller = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
                child: StreamBuilder<List<ChatContent>>(
                    stream: _worker.stream,
                    builder: (context, snapshot) {
                      final List<ChatContent> data = snapshot.data ?? [];
                      return ListView(
                        controller: _controller,
                        children: data.map((e) {
                          final bool isMine = e.sender == Sender.user;
                          return ChatBubble(
                              isMine: isMine,
                              photoUrl:
                                  'https://picsum.photos/seed/picsum/200/300',
                              message: e.message);
                        }).toList(),
                      );
                    })),
            MessageBox(
              onSendMessage: (value) {
                _worker.sendToGemini(value);
              },
            )
          ],
        ),
      ),
    );
  }
}
