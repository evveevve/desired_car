import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> fetchProducts(final String uri) async {
  final String url = "https://desired-car.glitch.me/brand-products?url=$uri";
  try {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return {
        'status code': data['status Code'],
        'data': data['data'],
        'error': data['error'],
      };
    } else {
      throw Exception(
          'Request failed with status code: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Error: $e');
  }
}

// }
