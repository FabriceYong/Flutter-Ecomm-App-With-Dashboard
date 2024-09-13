import 'package:ecomm_mobile/utility/app_color.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TrackingScreen extends StatelessWidget {
  const TrackingScreen({super.key, this.url});
  final String? url;

  @override
  Widget build(BuildContext context) {
    WebViewController webViewController = WebViewController();
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(
        Uri.parse(url ?? 'https://www.google.com/'),
      );
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Track Order',
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColor.darkOrange),
        ),
      ),
    );
  }
}
