import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/manage_bloc.dart';
import '../bloc/monitor_bloc.dart';
import 'add_note.dart';
import 'list_note.dart';
import 'login_screen.dart';

import '../bloc/auth_bloc.dart';

import 'register_screen.dart';

class Wrapper extends StatefulWidget {
  const Wrapper(BuildContext context, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return WrapperState();
  }
}

class WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          showDialog(
              context: context,
              builder: (contextWrapper) {
                return AlertDialog(
                  title: const Text("Erro do Firebase"),
                  content: Text(state.message),
                );
              });
        }
      },
      builder: (context, state) {
        if (state is Authenticated) {
          return authenticatedWidget(context);
        } else {
          return unauthenticatedWidget(context);
        }
      },
    );
  }
}

Widget authenticatedWidget(BuildContext context) {
  return DefaultTabController(
    length: 2,
    child: Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              BlocProvider.of<AuthBloc>(context).add(Logout());
            },
            child: const Icon(Icons.logout)),
        appBar: AppBar(
            title: const Text("widget.title"),
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.directions)),
                Tab(icon: Icon(Icons.ac_unit))
              ],
            )),
        body: MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => ManageBloc()),
            BlocProvider(create: (_) => MonitorBloc()),
          ],
          child: TabBarView(
            children: [
              AddNote(),
              ListNote(),
            ],
          ),
        )),
  );
}

Widget unauthenticatedWidget(BuildContext context) {
  return DefaultTabController(
      length: 1,
      child: Scaffold(
        body: const TabBarView(
          children: [LoginScreen()],
        ),
        appBar: AppBar(
          title: const Text("Autenticação Necessária"),
          bottom: const TabBar(
            tabs: [Tab(text: "Efetuar Login")],
          ),
        ),
      ));
}
