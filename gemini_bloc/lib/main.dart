import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gemini_bloc/bloc/genai_bloc.dart';
import 'package:gemini_bloc/data/chat_content.dart';
import 'package:gemini_bloc/widgets/chat_bubble_widget.dart';
import 'package:gemini_bloc/widgets/message_box_widget.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(BlocProvider<GenaiBloc>(
    create: (context) => GenaiBloc(),
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
                child: BlocBuilder<GenaiBloc, GenaiState>(
                    builder: (context, state) {
                      final List<ChatContent> data = [];

                      if (state is MessagesUpdate) {
                        data.addAll(state.contents);
                      }
                      
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
                context.read<GenaiBloc>().add(SendMessageEvent(value));
              },
            )
          ],
        ),
      ),
    );
  }
}
