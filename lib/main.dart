import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:imcn3/screens/edit_imc_screen.dart';
import 'package:imcn3/screens/main_screen.dart';
import 'package:imcn3/screens/register_imc_screen.dart';

import 'firebase_options.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.android,
      ),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const MaterialApp(
            home: Center(
              child: Text('Error initializing Firebase'),
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            initialRoute: '/',
            routes: {
              '/': (context) => const MainScreen(),
              '/register': (context) => const RegisterImcScreen(),
              '/edit':(context) => const EditImcScreen(),
            },
          );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      }
    );
  }
}
