import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gemini_bloc/data/chat_content.dart';
import 'package:gemini_bloc/repository/genai_model.dart';
import 'package:gemini_bloc/utils/bloc_extensions.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

part 'genai_event.dart';
part 'genai_state.dart';

class GenaiBloc extends Bloc<GenaiEvent, GenaiState> {
  final List<ChatContent> _content = [];
  final GenAiModel _model = GenAiModel();

  GenaiBloc() : super(GenaiInitial()) {
    on<SendMessageEvent>(_sendMessage);
  }

  void _sendMessage(SendMessageEvent event, Emitter<GenaiState> emit) async {
    _content.add(ChatContent.user(event.message));
    emitSafety(MessagesUpdate(List.from(_content)));

    try {
      final response = await _model.sendMessage([Content.text(event.message)]);
      final String? text = response.text;

      if (text == null) {
        _content.add(const ChatContent.gemini('Unable to generate response'));
      } else {
        _content.add(ChatContent.gemini(text));
      }
    } catch (e) {
      _content.add(const ChatContent.gemini('Unable to generate response'));
    }

    emitSafety(MessagesUpdate(List.from(_content)));
  }
}
