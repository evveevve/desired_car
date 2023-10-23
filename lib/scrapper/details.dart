import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> fetchDetails(final String uri) async {
  try {
    final response = await http.get(Uri.parse(uri));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return {
        'name': data['name'],
        'price': data['price'],
        'images': data['images'],
        'about': data['about']
      };
    } else {
      throw Exception(
          'Request failed with status code: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Error: $e');
  }
}
