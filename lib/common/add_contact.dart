import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddContact extends StatefulWidget {
  const AddContact({super.key});

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  String? email;
  String? source;
  String message = 'Processing...';

  @override
  void initState() {
    super.initState();
    final url = html.window.location.href;
    final uri = Uri.parse(url);
    email = uri.queryParameters['email'];
    source = uri.queryParameters['source'] ?? '';

    if (email != null && email!.contains('@')) {
      _sendToFirebaseFunction(email!);
    } else {
      setState(() {
        message = 'No valid email address found.';
      });
    }
  }

  Future<void> _sendToFirebaseFunction(String email) async {
    try {
      final response = await http.post(
        Uri.parse(
          'https://us-central1-podo-49335.cloudfunctions.net/onAddContactToZoho',
        ),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'email': email,
          'source': source,
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          message = 'Please check your inbox to complete the contact registration.';
        });
      } else {
        setState(() {
          message = 'Registration failed. Please try again.';
        });
      }
    } catch (e) {
      setState(() {
        message = 'An error occurred: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(child: Text(message, style: const TextStyle(fontSize: 18))),
      ),
    );
  }
}
