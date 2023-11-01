import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WebViewExample(),
    );
  }
}

class WebViewExample extends StatefulWidget {
  @override
  _WebViewExampleState createState() => _WebViewExampleState();
}

class _WebViewExampleState extends State<WebViewExample> {
  late WebViewController _controller;
  bool canNavigateBack = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text('Gujarat Vandan'),
      ),
      body: WebView(
        initialUrl: 'https://gujaratvandan.com/', // Change to the URL you want to display
        javascriptMode: JavascriptMode.unrestricted,
        onWebResourceError: (WebResourceError error) {
          print("Error occurred: ${error.description}");
          // Display a user-friendly error message or take appropriate action here.
        },
        onWebViewCreated: (WebViewController controller) {
          _controller = controller;
        },
        navigationDelegate: (NavigationRequest request) {
          if (request.url == 'https://gujaratvandan.com/') {
            canNavigateBack = false;
          } else {
            canNavigateBack = true;
          }
          return NavigationDecision.navigate;
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    canNavigateBack = false;
  }

  @override
  Future<bool> didPopRoute() async {
    if (canNavigateBack) {
      if (await _controller.canGoBack()) {
        _controller.goBack();
        return true;
      }
    }
    return false;
  }
}
