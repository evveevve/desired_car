import 'package:http/http.dart' as http;
import 'package:html/dom.dart';

// void main() {
//   // Replace with the HTML content provided
//   String htmlContent = """
//       ... (insert your HTML content here) ...
//   """;

//   // Parse the HTML content
//   Document document = html.parse(htmlContent);

//   // Select all the logo_brnds elements
//   List<Element> logoBrnds = document.querySelectorAll('.logo_brnds');

//   // Iterate through each logo_brnds element and extract brand name and image
//   for (Element logoBrnd in logoBrnds) {
//     // Extract brand name
//     String brandName =
//         logoBrnd.querySelector('span[itemprop="name"]')?.text ?? '';

//     // Extract image source
//     String imageSrc = logoBrnd.querySelector('img')?.attributes['src'] ?? '';

//     // Print brand name and image source
//     print('Brand Name: $brandName');
//     print('Image Source: $imageSrc');
//     print('------------------------');
//   }
// }

Future brands(String url) async {
  final response = await http.get(Uri.parse(url));
  final html = Document.html(response.body);
  final brandElement = html.querySelector('#alcarlist')?.outerHtml;
  print(brandElement);
  // Select all the logo_brnds elements
  List<Element> logoBrnds = html.querySelectorAll('.logo_brnds');

  final brnds = logoBrnds
      .map((e) {
        final item = {};
        item['brandName'] =
            e.querySelector('span[itemprop="name"]')?.text ?? '';
        item['imageSrc'] = e.querySelector('img')?.attributes['src'] ?? '';
        item['link'] =
            "https://cartrade.com/${e.querySelector('a')?.attributes['href'] ?? ''}";
        if (!item.values.contains('')) {
          return item;
        }
      })
      .nonNulls
      .toList();

  return brnds;
}

void main() async {
  print(await brands('https://cartrade.com/'));
}
