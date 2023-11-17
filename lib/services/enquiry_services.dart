import 'package:http/http.dart' as http;
import 'dart:convert';

Future sendEmail(
    {required List<String> schools, required String phoneNumber}) async {
  final serviceId = "service_oatkfs6";
  final templateId = "template_5qrmv7m";
  final userId = "1Yj2KQoWA-s8hz3mP";
  final url = Uri.parse("http://api.emailjs.com/api/v1.0/email/send");
  final response = await http.post(
    url,
    headers: {'origin': 'http://localhost', 'Content-Type': 'application/json'},
    body: json.encode({
      'service_id': serviceId,
      'template_id': templateId,
      'user_id': userId,
      'template_params': {
        'schools': schools.join(', '), // Convert list to string
        'from_phone': phoneNumber,
      },
    }),
  );
  print(response.body);
}
