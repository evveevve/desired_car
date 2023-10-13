import 'package:html/dom.dart' as dom;
import 'package:http/http.dart' as http;

Future getUpcomingCars(String url) async {
  final response = await http.get(Uri.parse(url));
  final html = dom.Document.html(response.body);
  final carList = html
      .querySelector('div:nth-child(5) > ul')
      ?.children
      .map((e) {
        Map<String, String> item = {};

        item['image'] =
            e.querySelector('div.left_block > a > img')?.attributes['src'] ??
                '';

        item['title'] =
            e.querySelector('div.right_block > h3 > a')?.attributes['title'] ??
                '';
        item['href'] =
            'https://www.cartrade.com${e.querySelector('div.right_block > h3 > a')?.attributes['href'] ?? ''}';
        item['price'] = e
                .querySelector('div.right_block > div.row > div.column.prc')
                ?.children[0]
                .innerHtml
                .split('>')
                .last ??
            '';
        item['release'] = e
                .querySelector(
                    'div.right_block > div.row > div.column.launch > span:nth-child(1)')
                ?.innerHtml ??
            '';

        return item.containsValue('') ? null : item;
      })
      .nonNulls
      .toList();
  return carList;
}

Future upcomingCars() async {
  var cars = [];
  for (int i = 1; i < 4; i++) {
    cars.addAll(
        await getUpcomingCars('https://www.cartrade.com/upcoming-cars/p-$i/'));
  }
  return cars;
}
// class UpcomingCars {
// UpcomingCars._initialize() {
//   () async {
//     for (int i = 1; i < 4; i++) {
//       _cars.addAll(await _getUpcomingCars(
//           'https://www.cartrade.com/upcoming-cars/p-$i/'));
//     }
//   }();
// }
//  final _shared = UpcomingCars._initialize();
// factory UpcomingCars() => _shared;
// final _cars = [];
// get getUpcomingCars => _cars;

// }

void main() async {
  print(await upcomingCars());
}
