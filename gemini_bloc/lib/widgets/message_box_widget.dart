import 'package:flutter/material.dart';

class MessageBox extends StatefulWidget {
  final ValueChanged<String> onSendMessage;
  const MessageBox({required this.onSendMessage, super.key});

  @override
  State<MessageBox> createState() => _MessageBoxState();
}

class _MessageBoxState extends State<MessageBox> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          controller: _controller,
          maxLines: 1,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0),
                  borderSide:
                      const BorderSide(color: Colors.black38, width: 1.0)),
              suffix: IconButton(
                icon: const Icon(Icons.send),
                onPressed: () {
                  widget.onSendMessage(_controller.text);
                  _controller.clear();
                },
              )),
          onSubmitted: (value) {
            widget.onSendMessage(value);
            _controller.clear();
          },
        ),
      );
}
