import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meus_gastos/core/base_state.dart';
import 'package:meus_gastos/pages/auth/login/login_controller.dart';
import 'package:meus_gastos/pages/auth/login/login_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseState<LoginScreen, LoginController> {
  final GlobalKey<FormState> key = GlobalKey();
  final email = TextEditingController();
  final password = TextEditingController();

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final nav = Navigator.of(context);
    final scaffold = ScaffoldMessenger.of(context);

    return BlocListener<LoginController, LoginState>(
      listener: (context, state) {
        state.status.matchAny(
          any: () {},
          success: () {
            scaffold.showSnackBar(const SnackBar(
              content: Text('Usuário logado com sucesso.'),
            ));
            Navigator.of(context).pushNamed('/home');
          },
          error: () {
            scaffold.showSnackBar(
                const SnackBar(content: Text('Erro ao logar usuário.')));
          },
        );
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 48.0, left: 8.0, bottom: 36.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Entrar",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.black.withOpacity(0.7),
                      ),
                    ),
                  ),
                ),
                Form(
                  key: key,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.05),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: TextFormField(
                              controller: email,
                              decoration: const InputDecoration(
                                hintText: "Digite seu e-mail",
                                hintStyle: TextStyle(color: Colors.grey),
                                border: InputBorder.none,
                                fillColor: Colors.grey,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Email obrigatório";
                                }
                                return null;
                              }),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(
                            top: 34.0,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.05),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: TextFormField(
                                  controller: password,
                                  decoration: const InputDecoration(
                                    hintText: "Digite sua senha",
                                    hintStyle: TextStyle(
                                      color: Colors.grey,
                                    ),
                                    border: InputBorder.none,
                                    fillColor: Colors.grey,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Senha obrigatória";
                                    }
                                    return null;
                                  }),
                            ),
                          )),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.only(
                            left: 10.0, right: 10.0, top: 48.0, bottom: 36.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            if (key.currentState?.validate() ?? false) {
                              await controller.login(
                                  email: email.text, password: password.text);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff5EA3A3),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            padding:
                                const EdgeInsets.only(top: 18.0, bottom: 18.0),
                          ),
                          child: const Text(
                            "ENTRAR",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        child: ElevatedButton(
                          onPressed: () {
                            nav.pushNamed('/register');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff5EA3A3),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            padding:
                                const EdgeInsets.only(top: 18.0, bottom: 18.0),
                          ),
                          child: const Text(
                            "REGISTRAR",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
