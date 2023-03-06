import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchname = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
        .collection('user')
        .where(
          'Name',
          isEqualTo: searchname.text,
        )
        .snapshots();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 2, 160, 57),
        title: Text('Whatsapp')
      ),
      body: Column(
        children: [
           Container(
              height: 60,
              padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 10),
              child: TextField(
                // style: TextStyle(fontSize: 20,height: 2),
                controller: searchname,
                onChanged: (val){
                  // print("pankaj");
                  setState(() {});
                },
                decoration: InputDecoration(
                  // isDense: true,
                  contentPadding: EdgeInsets.all(8),
                  prefixIcon: Icon(Icons.search),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  focusedBorder:  OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  labelText: 'Username',
                  labelStyle: TextStyle(
                    color: Colors.grey[600],
                  ),
                  hintText: 'search',
                  suffix: IconButton(
                    onPressed: (){
                        searchname.clear();
                        setState(() {});
                      },
                     icon: Icon(Icons.clear)
                     ),
                ),
              ),
            ),
          StreamBuilder(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text("something is wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              height: MediaQuery.of(context).size.height - 500,
              alignment: Alignment.center,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListView.builder(
              
              itemCount: snapshot.data!.docs.length,
              shrinkWrap: true,
              itemBuilder: (_, index) {
                return Card(
                  child: ListTile(
                    onTap: (){
                      
                    },
                    title: Text(
                      snapshot.data!.docChanges[index].doc['Name'],
                    ),
                    subtitle:
                        Text(snapshot.data!.docChanges[index].doc['email']),
                    trailing: Container(
                      width: 100,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 8),
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(50)),
                      child: Text('message'),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
        ],
      )
    );
  }
}
