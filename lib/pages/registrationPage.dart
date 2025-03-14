import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UpdatePage extends StatefulWidget {
  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController codeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  bool isVerified = false;
  String? contributorName;

  Future<void> _verifyContributor() async {
    final code = codeController.text.trim();
    if (code.isEmpty || code.length != 11) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Ingrese un código válido de 11 dígitos")),
      );
      return;
    }

    final url = Uri.parse("http://190.119.38.13/getEmailContribuyente/$code");

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data["status"] == "success" && data["data"].isNotEmpty) {
          setState(() {
            isVerified = true;
            contributorName = data["data"][0]["Nombre"];
            emailController.text = data["data"][0]["Direccion"] ?? "";
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Código de contribuyente válido")),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Código de contribuyente no encontrado")),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error al conectar con el servidor")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  Future<void> _updateData() async {
    if (_formKey.currentState!.validate()) {
      final code = codeController.text.trim();
      final email = emailController.text.trim();
      final phone = phoneController.text.trim();

      final url = Uri.parse(
          "http://190.119.38.13/getGuardarCorreoContribuyente/$email/0/$code/$phone");

      try {
        final response = await http.get(url);
        if (response.statusCode == 200) {
          // Mostrar un cuadro de diálogo en lugar del SnackBar
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Éxito"),
                content: Text("Datos actualizados exitosamente."),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Cierra el diálogo
                    },
                    child: Text("Aceptar"),
                  ),
                ],
              );
            },
          );
          _clearFields();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error al actualizar los datos")),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: $e")),
        );
      }
    }
  }

  void _clearFields() {
    setState(() {
      codeController.clear();
      emailController.clear();
      phoneController.clear();
      isVerified = false;
      contributorName = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 76, 220, 14),
              Color.fromARGB(255, 63, 84, 163)
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              "assets/sat-logo.png",
              height: 100,
              width: 250,
              fit: BoxFit.contain,
            ),
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
                      blurRadius: 400,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: codeController,
                        decoration: InputDecoration(
                          labelText: "Código de Contribuyente",
                          labelStyle: TextStyle(
                            color: Color.fromARGB(255, 2, 149, 2),
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          prefixIcon: Icon(Icons.person,
                              color: Color.fromARGB(255, 2, 149, 2)),
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
                      const SizedBox(height: 4),
                      if (isVerified) ...[
                        Card(
                          elevation: 10,
                          margin: EdgeInsets.symmetric(vertical: 5),
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              "$contributorName",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ),
                        TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            labelText: "Correo Electrónico",
                            labelStyle: TextStyle(
                              color: Color.fromARGB(255, 2, 149, 2),
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            prefixIcon: Icon(Icons.email,
                                color: Color.fromARGB(255, 2, 149, 2)),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Ingrese su correo electrónico";
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: phoneController,
                          decoration: InputDecoration(
                            labelText: "Número de Celular",
                            labelStyle: TextStyle(
                              color: Color.fromARGB(255, 2, 149, 2),
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            prefixIcon: Icon(Icons.phone,
                                color: Color.fromARGB(255, 2, 149, 2)),
                          ),
                          keyboardType: TextInputType.phone,
                          maxLength: 9,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Ingrese su número de celular";
                            }
                            return null;
                          },
                        ),
                      ],
                      ElevatedButton(
                        onPressed:
                            isVerified ? _updateData : _verifyContributor,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          minimumSize: Size(double.infinity, 45.0),
                        ),
                        child: Text(isVerified
                            ? "ACTUALIZAR DATOS"
                            : "VERIFICAR CÓDIGO"),
                      ),
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
