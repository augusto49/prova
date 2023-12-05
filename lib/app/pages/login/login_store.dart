// ignore_for_file: use_build_context_synchronously, prefer_const_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../home/home_page.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {
  final String apiUrl =
      'https://656dd1c4bcc5618d3c240b6b.mockapi.io/login/users';

  @observable
  String username = '';

  @observable
  String password = '';

  @observable
  bool isLoading = false;

  @observable
  String errorMessage = '';

  @computed
  bool get isUsernameValid =>
      username.length <= 20 && username.isNotEmpty && !username.endsWith(' ');

  @computed
  bool get isPasswordValid =>
      password.length >= 2 &&
      password.length <= 20 &&
      !password.endsWith(' ') &&
      RegExp(r'^[a-zA-Z0-9]+$').hasMatch(password);

  @action
  void setUsername(String value) => username = value;

  @action
  void setPassword(String value) => password = value;

  @action
  Future<void> login(BuildContext context) async {
    if (!isUsernameValid || !isPasswordValid) {
      errorMessage = 'Por favor, verifique seu usuário e senha.';
      return;
    }

    isLoading = true;
    errorMessage = '';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final List<dynamic> userList = json.decode(response.body);

        final user = userList.firstWhere(
          (user) => user['useraname'] == username && user['senha'] == password,
          orElse: () => null,
        );

        if (user != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        } else {
          errorMessage = 'Usuário ou senha incorretos.';
        }
      } else {
        errorMessage = 'Erro ao conectar com a API: ${response.statusCode}';
      }
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
    }
  }
}
