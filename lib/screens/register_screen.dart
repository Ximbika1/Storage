import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth_bloc.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formkey = GlobalKey();
    String username = "";
    String password = "";
    return Form(
      key: formkey,
      child: Form(
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            SizedBox(
              width: 150,
              height: 150,
              child: Image.asset('assets/logo.jpg'),
            ),
            const SizedBox(
              height: 60,
            ),
            Container(
              margin: const EdgeInsets.only(
                  top: 10, left: 10, right: 10, bottom: 10),
              child: TextFormField(
                style: const TextStyle(fontSize: 22),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'E-mail',
                  prefixIcon: Icon(Icons.email),
                ),
                validator: (String? inValue) {
                  if (inValue!.isEmpty) {
                    return "Insira o seu e-mail";
                  }
                  return null;
                },
                onSaved: (String? inValue) {
                  username = inValue!;
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                  top: 10, left: 10, right: 10, bottom: 10),
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
              label: const Text("Register"),
              icon: const Icon(Icons.assignment),
              onPressed: () {
                if (formkey.currentState!.validate()) {
                  formkey.currentState!.save();
                  // Lançando evento
                  BlocProvider.of<AuthBloc>(context).add(
                      RegisterUser(username: username, password: password));
                }
              },
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(const Size(80, 60)),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
