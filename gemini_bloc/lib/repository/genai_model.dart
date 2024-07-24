import 'dart:async';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class GenAiModel {
  late final GenerativeModel _model;

  GenAiModel() {
    String apiKey = dotenv.env['API_KEY'] ?? 'Unknown API URL';

    _model = GenerativeModel(model: 'gemini-1.5-pro', apiKey: apiKey);
  }

  Future<GenerateContentResponse> sendMessage(List<Content> content) => _model.generateContent(content);
}
