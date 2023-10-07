import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pharmcare/firebase_options.dart';
import 'package:pharmcare/home_page.dart';
import 'package:pharmcare/login_page.dart';
import 'package:pharmcare/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pharmcare',
theme: ThemeData(useMaterial3: true),
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (ctx, snapshot) {
            if(snapshot.connectionState==ConnectionState.waiting){
              return const Splashscreen();
            }
            if(snapshot.hasData){
              return const Homepage();
            }
            return const Loginpage();
          }),
    );
  }
}

