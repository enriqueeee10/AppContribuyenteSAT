import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  Future<Map<String, dynamic>?> fetchContribuyente(
      String email, String codigo) async {
    final url = Uri.parse(
        'http://190.119.38.13/getValidaEmailContribuyente/$email/$codigo');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['status'] == 'success' && data['data'].isNotEmpty) {
          return data['data'][0]; // Retorna solo la primera coincidencia
        }
      }
    } catch (e) {
      print("Error al obtener datos: $e");
    }

    return null;
  }
}
