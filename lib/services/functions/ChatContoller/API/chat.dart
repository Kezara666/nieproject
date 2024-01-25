import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nieproject/enviroment/api.dart';

class ApiService {
  final String baseUrl = apiChat;

  Future<List<String>> fetchChatMessages() async {
    final response = await http.get(Uri.parse('$baseUrl/chat')); // Adjust the endpoint
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((message) => message.toString()).toList();
    } else {
      throw Exception('Failed to load chat messages');
    }
  }
}
