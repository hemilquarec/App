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
      body: WillPopScope(
        onWillPop: () async {
          if (canNavigateBack) {
            if (await _controller.canGoBack()) {
              _controller.goBack();
              return false; // Prevent the app from exiting
            }
          }

          // If not on the root page, allow back navigation in WebView
          if (canNavigateBack) {
            return true;
          } else {
            // Show a confirmation dialog to exit the app
            return await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Exit App'),
                content: Text('Are you sure you want to exit the app?'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(false); // Cancel the exit
                    },
                    child: Text('No'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(true); // Confirm the exit
                    },
                    child: Text('Yes'),
                  ),
                ],
              ),
            );
          }
        },
        child: WebView(
          initialUrl: 'https://gujaratvandan.com/',
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
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    canNavigateBack = false;
  }
}
