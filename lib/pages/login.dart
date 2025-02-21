import 'package:flutter/material.dart';
// import 'package:flutter_application_rest/pages/DeudaScreen.dart';
import 'package:flutter_application_rest/pages/screen_deudas.dart';

void main() {
  runApp(const MyApp());
}

final _formKey = GlobalKey<FormState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 5, 251, 112),
              Color.fromARGB(255, 29, 5, 237)
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Image.asset(
              "assets/logopeque.png",
              height: 200, // Ajusta la altura según sea necesario
              width: 200, // Ajusta el ancho según sea necesario
              fit: BoxFit.contain,
            ),

            // Formulario
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Campo de correo
                      TextFormField(
                        controller:
                            emailController, // Cambiado a emailController
                        decoration: InputDecoration(
                          labelText: "Correo Electrónico",
                          labelStyle: TextStyle(
                            color: const Color.fromARGB(255, 2, 149, 2),
                            fontWeight: FontWeight.bold,
                            // Hace el texto de la etiqueta negrita
                            fontSize:
                                16, // Ajusta el tamaño de la fuente si es necesario
                          ),
                          prefixIcon: Icon(Icons.email,
                              color: const Color.fromARGB(255, 2, 149, 2)),
                        ),
                        validator: validateEmail,
                      ),
                      const SizedBox(height: 10),
                      // Campo de código de contribuyente
                      TextFormField(
                        controller: codeController,
                        decoration: InputDecoration(
                          labelText: "Código de contribuyente",
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

                      const SizedBox(height: 15),

                      // Botón Iniciar Sesión
                      ElevatedButton(
                        onPressed: () {
                          _formKey.currentState!.validate();
                          if (_formKey.currentState!.validate()) {
                            _login();
                          }
                        },
                        // onPressed: isButtonEnabled ? _login : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              isButtonEnabled ? Colors.green : Colors.grey,
                          foregroundColor: Colors.white,
                          minimumSize: Size(double.infinity, 45),
                        ),
                        child: const Text("CONSULTAR DEUDA"),
                      ),
                      const SizedBox(height: 5),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 25),

            // Opciones inferiores (Contacto, Ubícanos)
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 30),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       contactoOpcion(Icons.phone, "Contacto"),
            //       contactoOpcion(Icons.location_on, "Ubícanos"),
            //     ],
            //   ),
            // ),

            // const SizedBox(height: 20),

            // Redes Sociales
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     const SizedBox(width: 10),
            //     const Text(
            //       "SAT TARAPOTO",
            //       style: TextStyle(color: Colors.white),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }

  // Widget contactoOpcion(IconData icon, String texto) {
  //   return Column(
  //     children: [
  //       Icon(icon, color: Colors.white),
  //       const SizedBox(height: 5),
  //       Text(
  //         texto,
  //         style: const TextStyle(color: Colors.white),
  //       ),
  //     ],
  //   );
  // }
}
