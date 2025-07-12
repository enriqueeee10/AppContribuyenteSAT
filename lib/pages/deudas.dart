import 'package:flutter/material.dart';
import 'package:flutter_application_rest/pages/registrationPage.dart';
import 'package:flutter_application_rest/pages/screen_deudas.dart';

final _formKey = GlobalKey<FormState>();

class DeudasScreen extends StatefulWidget {
  const DeudasScreen({super.key});

  @override
  State<DeudasScreen> createState() => _DeudasScreenState();
}

class _DeudasScreenState extends State<DeudasScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  bool isButtonEnabled = false;

  String? validateEmail(String? email) {
    RegExp emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    final isEmailValid = emailRegExp.hasMatch(email ?? '');
    if (!isEmailValid) {
      return 'Ingrese un correo electrónico válido';
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    emailController.addListener(_updateButtonState);
    codeController.addListener(_updateButtonState);
  }

  void _updateButtonState() {
    setState(() {
      isButtonEnabled =
          emailController.text.isNotEmpty && codeController.text.isNotEmpty;
    });
  }

  void _login() {
    final email = emailController.text;
    final codigo = codeController.text;

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => DeudasPage(email: email, codigo: codigo)),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    codeController.dispose();
    super.dispose();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      resizeToAvoidBottomInset: true, // Evita que el teclado cubra elementos
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(5.0),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/logo2.png",
                      height: 100, width: 200, fit: BoxFit.fill),
                ],
              ),
            ),
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(5.0),
                  color: Colors.blue.shade900,
                  child: Row(),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 20,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: "Correo Electrónico",
                          labelStyle: TextStyle(
                            color: Colors.blue.shade900,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          prefixIcon:
                              Icon(Icons.email, color: Colors.blue.shade900),
                        ),
                        validator: validateEmail,
                      ),
                      const SizedBox(height: 5),
                      TextFormField(
                        controller: codeController,
                        decoration: InputDecoration(
                          labelText: "Código de contribuyente",
                          labelStyle: TextStyle(
                            color: Colors.blue.shade900,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          prefixIcon:
                              Icon(Icons.person, color: Colors.blue.shade900),
                        ),
                        keyboardType: TextInputType.number,
                        maxLength: 11,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Ingrese el código de contribuyente";
                          }
                          if (value.length > 11) {
                            return "El código no puede tener más de 11 dígitos";
                          }
                          return null;
                        },
                        onEditingComplete: () {
                          // Se ejecuta cuando el usuario termina de escribir
                          String input = codeController.text.trim();
                          if (input.isNotEmpty && input.length <= 11) {
                            codeController.text =
                                input.padLeft(11, '0'); // Completa con ceros
                          }
                        },
                      ),
                      const SizedBox(height: 5.0),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UpdatePage()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade900,
                          foregroundColor: Colors.white,
                          minimumSize: Size(double.infinity, 45.0),
                        ),
                        child: const Text("Actualizar Datos"),
                      ),
                      const SizedBox(height: 5),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _login();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              isButtonEnabled ? Colors.green : Colors.grey,
                          foregroundColor: Colors.white,
                          minimumSize: Size(double.infinity, 45.0),
                        ),
                        child: const Text("Consultar Deuda"),
                      ),
                      const SizedBox(height: 5),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
