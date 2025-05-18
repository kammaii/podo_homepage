import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class WelcomeEmail extends StatelessWidget {
  const WelcomeEmail({super.key});

  sendWelcomeEmail(String email) async {
    final response = await http.post(
      Uri.parse(
          'https://us-central1-podo-49335.cloudfunctions.net/onSendWelcomeEmail'),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'email': email,
      },
    );
    if (response.statusCode == 200) {
      print('성공');
    } else {
      print('오류 발생: ${response.statusCode}');
      print(json.decode(response.body)['message']);
    }
  }

  @override
  Widget build(BuildContext context) {
    final userEmail = Uri.base.queryParameters['email'];
    print('USER: $userEmail');
    if(userEmail != null) {
      sendWelcomeEmail(userEmail);
    }

    return const Placeholder();
  }
}
