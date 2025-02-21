// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// class DeudasWebView extends StatefulWidget {
//   const DeudasWebView({super.key});

//   @override
//   _DeudasWebViewState createState() => _DeudasWebViewState();
// }

// class _DeudasWebViewState extends State<DeudasWebView> {
//   late final WebViewController controller;

//   @override
//   void initState() {
//     super.initState();
//     controller = WebViewController()
//       ..loadRequest(
//           Uri.parse('https://sat-t.gob.pe/consulta_deuda_tributaria'));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Lista de Deudas')),
//       body: WebViewWidget(controller: controller),
//     );
//   }
// }
