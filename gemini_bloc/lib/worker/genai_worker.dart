import 'package:google_generative_ai/google_generative_ai.dart';

class GenAIWorker {
  late final GenerativeModel _model;

  GenAIWorker() {
    const apiKey = String.fromEnvironment('apiKey');

    print('----2222 $apiKey');

    _model = GenerativeModel(model: 'gemini-1.5-pro', apiKey: apiKey);
  }

  void sendToGemini(String message) async {
    
  }
}