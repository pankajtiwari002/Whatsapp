import 'package:flutter/material.dart';
import 'package:whatsapp/screens/searchpage.dart';
// import './search.dart';
import 'package:whatsapp/screens/service/auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 2, 160, 57),
        title: const Text('Whatsapp'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: (){
              _auth.signOut();
            },
          )
        ]
      ),
      body: const Center(child: Text('Home page')),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: ((context) => SearchPage())));
          // showSearch(context: context, delegate: Search());
        },
        child: Icon(Icons.search),
        backgroundColor: const Color.fromARGB(255, 2, 160, 57),
        ),
    );
  }
}