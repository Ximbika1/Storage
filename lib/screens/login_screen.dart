import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth_bloc.dart';
import 'register_screen.dart';
import 'wrapper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLogin = true;
  late String titulo;
  late String actionButton;
  late String toggleButton;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    setFormAction(true);
  }

  setFormAction(bool acao) {
    setState(() {
      isLogin = acao;
      if (isLogin) {
        titulo = 'Bem vindo';
        actionButton = 'Login';
        toggleButton = 'Ainda não tem conta? Cadastre-se agora.';
      } else {
        titulo = 'Crie sua conta';
        actionButton = 'Cadastrar';
        toggleButton = 'Voltar ao Login.';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formkey = GlobalKey();
    String username = "";
    String password = "";
    return Form(
      key: formkey,
      child: Column(
        children: [
          const SizedBox(
            height: 70,
          ),
          SizedBox(
            width: 150,
            height: 150,
            child: Image.asset('assets/logo.jpg'),
          ),
          Container(
            height: 70,
          ),
          Container(
            margin:
                const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
            child: TextFormField(
              style: const TextStyle(fontSize: 22),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'E-mail',
                prefixIcon: Icon(Icons.email),
              ),
              validator: (String? inValue) {
                if (inValue!.isEmpty) {
                  return "Insira seu e-mail";
                }
                return null;
              },
              onSaved: (String? inValue) {
                username = inValue!;
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            margin:
                const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
            child: TextFormField(
              style: const TextStyle(fontSize: 22),
              keyboardType: TextInputType.text,
              obscureText: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Senha',
                prefixIcon: Icon(Icons.key),
              ),
              validator: (String? inValue) {
                if (inValue!.length < 4) {
                  return "Tem que ter ao menos 4 caracters";
                }
                return null;
              },
              onSaved: (String? inValue) {
                password = inValue!;
              },
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton.icon(
            onPressed: () {
              if (formkey.currentState!.validate()) {
                formkey.currentState!.save();
                // Lançando evento
                BlocProvider.of<AuthBloc>(context)
                    .add(LoginUser(username: username, password: password));
              }
            },
            label: const Text("Login"),
            icon: const Icon(Icons.login),
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(const Size(80, 60)),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(24.0),
            child: ElevatedButton(
              onPressed: () {
                if (formkey.currentState!.validate()) {
                  if (isLogin) {
                    authenticatedWidget(context);
                  } else {
                    unauthenticatedWidget(context);
                  }
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: (loading)
                    ? [
                        Padding(
                          padding: EdgeInsets.all(16),
                          child: SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ),
                        )
                      ]
                    : [
                        Icon(Icons.check),
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            actionButton,
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
              ),
            ),
          ),
          TextButton(
            onPressed: () => setFormAction(!isLogin),
            child: Text(toggleButton),
          ),
        ],
      ),
    );
  }
}
