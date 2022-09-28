import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gerenciamento_estado/exceptions/auth_exception.dart';
import 'package:gerenciamento_estado/models/auth.dart';
import 'package:provider/provider.dart';

// ignore: constant_identifier_names
enum AuthMode { Signup, Login }

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm>
    with SingleTickerProviderStateMixin {
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  AuthMode _authMode = AuthMode.Login;
  final Map<String, dynamic> _authData = {'email': '', 'password': ''};

  void _switchAuthMode() {
    setState(() {
      if (_isLogin()) {
        _authMode = AuthMode.Signup;
        _controller.forward();
      } else {
        _authMode = AuthMode.Login;
        _controller.reverse();
      }
    });
  }

  void _showError(String msg) {
    showDialog(
        context: context,
        builder: ((context) => AlertDialog(
              title: const Text('Ocorreu um Erro'),
              content: Text(msg),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Fechar'))
              ],
            )));
  }

  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));

    _opacityAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool _isLogin() => _authMode == AuthMode.Login;
  bool _isSignup() => _authMode == AuthMode.Signup;

  Future<void> _submit() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    debugPrint('$_authData - $isValid');
    if (!isValid) {
      return;
    }
    _formKey.currentState?.save();
    setState(() => _isLoading = true);

    Auth auth = context.read<Auth>();
    try {
      if (_isLogin()) {
        await auth.login(_authData['email'], _authData['password']);
      } else {
        // Registrar
        await auth.signup(_authData['email'], _authData['password']);
      }
    } on AuthExpection catch (error) {
      debugPrint('$error');
      _showError(error.toString());
    } catch (error) {
      _showError('Ocorreu um erro inesperado');
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
          margin: const EdgeInsets.only(bottom: 20),
          padding: const EdgeInsets.all(16),
          height: _isLogin() ? 320 : 400,
          //height: _heightAnimation.value.height,
          width: deviceSize.width * 0.75,
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'E-mail'),
                    keyboardType: TextInputType.emailAddress,
                    onSaved: (email) {
                      _authData['email'] = email ?? '';
                    },
                    validator: (e) {
                      final email = e ?? '';
                      if (email.trim().isEmpty || !email.contains('@')) {
                        return 'Informe um e-mail válido';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Senha'),
                    keyboardType: TextInputType.emailAddress,
                    obscureText: true,
                    controller: _passwordController,
                    onSaved: (password) {
                      _authData['password'] = password ?? '';
                    },
                    validator: (pass) {
                      final password = pass ?? '';
                      if (password.isEmpty || password.length < 6) {
                        return 'Tamanho de senha inválido';
                      }
                      return null;
                    },
                  ),
                  if (_isSignup())
                    AnimatedContainer(
                      constraints: BoxConstraints(
                          minHeight: _isLogin() ? 0 : 60,
                          maxHeight: _isLogin() ? 0 : 120),
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.linear,
                      child: FadeTransition(
                        opacity: _opacityAnimation,
                        child: TextFormField(
                          decoration: const InputDecoration(
                              labelText: 'Confirmar Senha'),
                          keyboardType: TextInputType.emailAddress,
                          obscureText: true,
                          validator: (pass) {
                            final password = pass ?? '';
                            if (password != _passwordController.text) {
                              return 'Senhas informadas não conferem.';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: _submit,
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 8)),
                    child: _isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : Text(
                            _authMode == AuthMode.Login
                                ? 'Entrar'
                                : 'Registrar',
                            style: const TextStyle(color: Colors.white),
                          ),
                  ),
                  const Spacer(),
                  TextButton(
                      onPressed: _switchAuthMode,
                      child: Text(_isLogin()
                          ? 'Deseja registrar?'
                          : 'Já possui conta?'))
                ],
              )),
        ));
  }
}
