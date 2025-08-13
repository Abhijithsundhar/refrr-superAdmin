import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'Features/Login/Screens/loginScreen.dart';
import 'core/globelvariable.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyADaZLCOLHraKDbWjwKIqsJRmaoEJWsotQ",
          authDomain: "i-canyon-marketing-app.firebaseapp.com",
          projectId: "i-canyon-marketing-app",
          storageBucket: "i-canyon-marketing-app.firebasestorage.app",
          messagingSenderId: "574909873629",
          appId: "1:574909873629:web:37a875d8da9179073bca34",
          measurementId: "G-K4JQB03QJ1"));
  runApp( ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    fontWidth = MediaQuery.of(context).size.width;
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return MaterialApp(
      title: 'refrr Super-admin',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
      // home: Home(),
    );
  }
}

