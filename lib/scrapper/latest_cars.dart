import 'package:html/dom.dart';
import 'package:http/http.dart' as http;

void main() =>
    keySpecifications('https://www.cartrade.com/citroen-cars/c3-aircross/');

Future keySpecifications(String url) async {
  final Uri uri = Uri.parse(url);
  final response = await http.get(uri);
  final html = Document.html(response.body);
  final document = html.querySelector(
      '#idbybody > article > section > section.left-content > section:nth-child(1) > div > div > table > tbody')!;

  // Fetch the table rows
  List<Element> rows = document.querySelectorAll('tr');

  // Iterate through each row and extract the data and export it
  return rows.map((element) {
    final titleElement = element.querySelector('th>h3.specTitle');
    final dataElement = element.querySelector('td.specData');

    if (titleElement != null && dataElement != null) {
      String title = titleElement.text.trim();
      String data = dataElement.text.trim();
      return {title: data};
    }
  }).toList();
}
