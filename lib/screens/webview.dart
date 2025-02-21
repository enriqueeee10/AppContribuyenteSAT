import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentWebView extends StatefulWidget {
  const PaymentWebView({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  PaymentWebViewState createState() => PaymentWebViewState();
}

late String getUrlPref;

class PaymentWebViewState extends State<PaymentWebView> {
  WebViewController? _webViewController;

  @override
  void initState() {
    super.initState();
    _clearCache();
  }

  @override
  Widget build(BuildContext context) {
    final responseArgument = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: WebViewWidget(
        controller: _webViewController = WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..loadRequest(Uri.parse(responseArgument['response'])),
      ),
    );
  }

  @override
  void dispose() {
    _clearCache();
    super.dispose();
  }

  Future<void> _clearCache() async {
    await _webViewController?.clearCache();
    final cookieManager = WebViewCookieManager();
    await cookieManager.clearCookies();
  }
}
