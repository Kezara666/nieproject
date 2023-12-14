import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = '"http://alphau.nie.ac.lk/api/admin/tickets"'; // Replace with your API endpoint

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
