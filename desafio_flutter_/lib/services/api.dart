
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const baseUrl = "http://localhost:3000";

  static Future<List<dynamic>> getList(String endpoint) async {
    final res = await http.get(Uri.parse("$baseUrl/$endpoint"));
    return jsonDecode(res.body);
  }

  static Future<dynamic> post(String endpoint, Map data) async {
    final res = await http.post(Uri.parse("$baseUrl/$endpoint"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data)
    );
    return jsonDecode(res.body);
  }

  static Future<dynamic> put(String endpoint, int id, Map data) async {
    final res = await http.put(Uri.parse("$baseUrl/$endpoint/$id"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data)
    );
    return jsonDecode(res.body);
  }

  static Future<void> delete(String endpoint, int id) async {
    await http.delete(Uri.parse("$baseUrl/$endpoint/$id"));
  }
}
