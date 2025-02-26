import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactoOpcion extends StatelessWidget {
  final IconData icon;
  final String texto;
  final String url;

  const ContactoOpcion({
    super.key,
    required this.icon,
    required this.texto,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        try {
          final Uri uri = Uri.parse(url);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri);
          } else {
            throw 'No se pudo abrir $url';
          }
        } catch (e) {
          throw 'Error al abrir la URL: $e';
        }
      },
      child: Column(
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(height: 5),
          Text(
            texto,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
