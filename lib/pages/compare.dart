import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Compare extends StatefulWidget {
  const Compare({super.key});

  @override
  State<Compare> createState() => _CompareState();
}

class _CompareState extends State<Compare> {
  final controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          return NavigationDecision.navigate;
        },
      ),
    )
    ..loadRequest(Uri.parse('https://www.cardekho.com/compare-cars'));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Stack(children: [
        WebViewWidget(controller: controller),
        Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: double.infinity,
              height: 80,
              color: const Color(0xFFE4E4EE),
              child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Row(children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        shadows: [
                          Shadow(color: Colors.orange[900]!, blurRadius: 5)
                        ],
                      ),
                      color: Colors.orange[900],
                    ),
                    Text(
                      'Desired Car',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange[900]),
                    ),
                  ])),
            ))
      ]),
    );
  }
}
