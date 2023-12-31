import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> fetchBrands() async {
  final url =
      'http://desired-car.glitch.me/brands'; // Update with your server URL

  try {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      print(data);
      return {
        'statusCode': data['statusCode'],
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
