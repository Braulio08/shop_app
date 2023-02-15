import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Auth with ChangeNotifier {
  late String _token;
  late DateTime _expiryDate;
  late String _userId;

  Future<void> signUp(String email, String password) async {
    String? apiKey = dotenv.env['FIREBASE_API_KEY'];
    var url = Uri.https('identitytoolkit.googleapis.com', '/v1/accounts:signUp?key=$apiKey');

  }
}
