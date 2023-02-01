import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/auth_bloc.dart';
import 'screens/register_screen.dart';
import 'screens/wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyDB9IT2Rnmymni-S2QRGkU8MxVJl3XY6Ao",
          appId: "1:187555562632:web:1b878930735465daa6cb3d",
          messagingSenderId: "187555562632",
          projectId: "armazenamentoliterario",
          storageBucket: "armazenamentoliterario.appspot.com",
          authDomain: "armazenamentoliterario.firebaseapp.com"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MultiBlocProvider(providers: [
          BlocProvider(create: (context) => AuthBloc()),
        ], child: Wrapper(context)));
  }
}
