import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gerenciamento_estado/exceptions/auth_exception.dart';
import 'package:gerenciamento_estado/exceptions/http_exception.dart';
import 'package:gerenciamento_estado/utils/user_manager.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String? _token;
  String? _email;
  String? _userId;
  DateTime? _expiryDate;
  Timer? _logoutTimer;

  bool get isAuth {
    final isValid = _expiryDate?.isAfter(DateTime.now()) ?? false;
    return _token != null && isValid;
  }

  String? get token => isAuth ? _token : null;

  String? get email => isAuth ? _email : null;

  String? get userId => isAuth ? _userId : null;

  Future<void> checkStorageLogin() async {
    try {
      final dataSave = await UserManager.isAuth;
      if (dataSave['token'] != '') {
        _token = dataSave['token'];
        _email = dataSave['email'];
        _userId = dataSave['userId'];
        _expiryDate = DateTime.parse(dataSave['expiryDate']);
        notifyListeners();
      }
    } on HttpException {
      throw HttpException(msg: 'Erro no login', statusCode: 0);
    }
  }

  Future<void> _authenticate(
      String email, String password, String urlFragment) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlFragment?key=AIzaSyDBz5UMuMuLHO2ClO8wgTEbMIUJvpSDycQ';

    final response = await http.post(Uri.parse(url),
        body: jsonEncode({
          'email': email,
          'password': password,
          'returnSecureToken': true,
        }));

    final body = jsonDecode(response.body);

    if (body['error'] != null) {
      throw AuthExpection(body['error']['message']);
    } else {
      _token = body['idToken'];
      _email = body['email'];
      _userId = body['localId'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(body['expiresIn']),
        ),
      );
      UserManager.writeAuth(_token!, _userId!, _email!, _expiryDate.toString());
    }
    _autoLogout();
    notifyListeners();
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }

  void logout() {
    _token = null;
    _email = null;
    _userId = null;
    _expiryDate = null;
    _clearLogoutTimer();
    UserManager.removeAuth();
    notifyListeners();
  }

  void _clearLogoutTimer() {
    _logoutTimer?.cancel();
    _logoutTimer = null;
  }

  void _autoLogout() {
    _clearLogoutTimer();
    final timeToLogout = _expiryDate?.difference(DateTime.now()).inSeconds;

    _logoutTimer = Timer(Duration(seconds: timeToLogout ?? 0), logout);
  }
}
