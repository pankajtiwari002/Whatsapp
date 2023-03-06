import 'package:flutter/material.dart';
import 'package:whatsapp/screens/model/users.dart';
import 'package:whatsapp/screens/service/auth.dart';
import 'package:whatsapp/screens/splash.dart';
import 'package:whatsapp/screens/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: ((context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return StreamProvider<Users?>.value(
            value: AuthService().user,
            // create: (context) => null,
            initialData: null,
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              home: SplashScreen(),
            ),
          );
        }
        return const CircularProgressIndicator();
      }),
    );
  }
}