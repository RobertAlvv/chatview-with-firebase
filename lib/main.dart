import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chat_edessis/features/chat/presentation/screens/chat_screen.dart';
import 'features/chat/presentation/bloc/chat_bloc/chat_bloc.dart';
import 'core/di/injection_dependency.dart' as injection;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  injection.init();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChatBloc>(
      create: (_) => injection.locator<ChatBloc>(),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const ChatScreen(),
      ),
    );
  }
}
