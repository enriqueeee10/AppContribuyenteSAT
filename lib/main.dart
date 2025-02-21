import 'package:flutter/material.dart';
// import 'package:flutter_application_rest/pages/DeudaScreen.dart';
// import 'package:flutter_application_rest/pages/login.dart';
import 'package:flutter_application_rest/screens/configuration.dart';
import 'package:flutter_application_rest/screens/fail.dart';
import 'package:flutter_application_rest/screens/form.dart';
import 'package:flutter_application_rest/screens/succes.dart';
import 'package:flutter_application_rest/screens/webview.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     debugShowCheckedModeBanner: false,
  //     title: 'Consulta de Deuda',

  //     theme: ThemeData(primarySwatch: Colors.green),
  //     home: LoginScreen(), // Pantalla de inicio
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => MainForm(title: 'Flutter App'),
          '/configuration': (context) => const Configuration(title: "Settings"),
          '/webview': (context) => PaymentWebView(title: 'Flutter WebView'),
          '/success': (context) => const Success(title: "Success Transaction"),
          '/fail': (context) => const Fail(title: "Failed Transaction"),
        });
  }
}
