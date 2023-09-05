import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meus_gastos/core/base_state.dart';
import 'package:meus_gastos/pages/auth/register/register_controller.dart';
import 'package:meus_gastos/pages/auth/register/register_state.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends BaseState<RegisterScreen, RegisterController> {
  final GlobalKey<FormState> key = GlobalKey();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    email.dispose();
    password.dispose();
    confirmPassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final nav = Navigator.of(context);
    return BlocListener<RegisterController, RegisterState>(
      listener: (context, state) {
        state.status.matchAny(
            any: () => {},
            success: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Usuário registrado com sucesso'),
              ));
              nav.pushNamed('/');
            },
            error: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Erro ao registrar usuário'),
              ));
            });
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
                      "Registrar",
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
                          // borderRadius: BorderRadius.circular(8.0),
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
                              // borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: TextFormField(
                                  controller: password,
                                  obscureText: true,
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
                                    } else if (value.length < 6) {
                                      return "Senha deve ter mín. de 6 caracteres";
                                    }
                                    return null;
                                  }),
                            ),
                          )),
                      Padding(
                          padding:
                              const EdgeInsets.only(top: 34.0, bottom: 60.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.05),
                              // borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: TextFormField(
                                  controller: confirmPassword,
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                    hintText: "Confirme sua senha",
                                    hintStyle: TextStyle(
                                      color: Colors.grey,
                                    ),
                                    border: InputBorder.none,
                                    fillColor: Colors.grey,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Confirmação de senha obrigatória";
                                    } else if ((password.text !=
                                        confirmPassword.text)) {
                                      return "Senhas não podem ser diferentes";
                                    }
                                    return null;
                                  }),
                            ),
                          )),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            if (key.currentState?.validate() ?? false) {
                              await controller
                                  .register(email.text, password.text);
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
                            "REGISTRAR",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.only(
                            left: 10.0, right: 10.0, top: 42.0, bottom: 36.0),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/');
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
                            "CANCELAR",
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
