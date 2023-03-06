import 'package:flutter/material.dart';
import 'package:whatsapp/screens/service/auth.dart';
import 'package:whatsapp/screens/service/database.dart';
import 'package:whatsapp/screens/service/helperfunction.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register(this.toggleView);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  DatabaseMethods databaseMethod  = new DatabaseMethods();
  TextEditingController emailTextEditingController = new TextEditingController();
  TextEditingController usernameTextEditingController = new TextEditingController();
  TextEditingController passwordTextEditingController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String username = '';
  String email = '';
  String password = '';
  String error = '';
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/background.png',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Form(
            key: _formKey,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20.0),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: TextFormField(
                        validator: (val) => val!.isEmpty ? 'Enter an username' : null,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          hintText: 'Enter Username',
                          labelText: 'Username',
                        ),
                        controller: usernameTextEditingController,
                        onChanged: (val) {
                          setState(() {
                            username = val;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: TextFormField(
                        validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          hintText: 'Enter Email',
                          labelText: 'Email',
                        ),
                        controller: emailTextEditingController,
                        onChanged: (val) {
                          setState(() {
                            email = val;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: TextFormField(
                        obscureText: true,
                        validator: (val) => val!.length < 6
                            ? 'Enter Password of atleast 6 char'
                            : null,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          hintText: 'Enter Password',
                          labelText: 'Password',
                        ),
                        controller: passwordTextEditingController,
                        onChanged: (val) {
                          setState(() {
                            password = val;
                          });
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        Map<String ,String> userMap = {
                            "email" : email,
                            "Name" : username
                        };
                        HelperFunction.saveUserLoggedInSharedPreference(true);
                        HelperFunction.saveUserNameSharedPreference(username);
                        HelperFunction.saveUserEmailSharedPreference(email);
                        databaseMethod.uploadUserInfo(userMap);
                        if (_formKey.currentState!.validate()) {
                          dynamic result = await _auth.registerWithEmailAndPassword(
                              email, password);
                          if (result == null) {
                            setState(() {
                              error = 'Please supply a valid email';
                            });
                          }
                        }
                      },
                      child: Text('Register'),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.pink),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Already have an account?'),
                        TextButton(
                          onPressed: () {
                            widget.toggleView();
                          },
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                              color: Colors.blue,
                            )
                          ),
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white)),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
