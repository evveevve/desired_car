import 'package:html/dom.dart' as dom;
import 'package:http/http.dart' as http;

void main() async => print(await cars());

Future carsPage(String url) async {
  final Uri uri = Uri.parse(url);
  final response = await http.get(uri);
  final html = dom.Document.html(response.body);

  final carElementList = html
          .querySelector(
              '#idbybody > div.content_are > div.content_are > div.news_left > div.inside_wrapper.gap_btm > div > ul')
          ?.children ??
      [];

  final carsList = carElementList.map(
    (element) {
      final Map<String, String?> item = {};

      item['image'] = element
          .querySelector(' div.left_block > span > img')
          ?.attributes['src'];

      item['name'] = element
          .querySelector('div.right_block > h2 > a')
          ?.attributes['title'];

      item['price'] = element
          .querySelector('div.right_block > div.row > div.column.prc > span')
          ?.text
          .trim();

      item['launchedDate'] = element
          .querySelector(
              'div.right_block > div.row > div.column.launch > span.launch_time')
          ?.innerHtml;

      item['about'] = element
          .querySelector(' div.right_block ')
          ?.children[4]
          .innerHtml
          .trim();

      item['link'] =
          element.querySelector('div.right_block > h2 > a')?.attributes['href'];
      return item.values.contains(null) ? null : item;
    },
  );

  return carsList.nonNulls;
}

Future cars() async {
  final list = [];
  for (int i = 1; i < 4; i++) {
    list.addAll(
        await carsPage('https://www.cartrade.com/new-car-launches/p-$i'));
  }
  return list;
}
