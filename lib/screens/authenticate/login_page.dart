import 'package:flutter/material.dart';
import 'package:whatsapp/screens/service/auth.dart';

class LoginPage extends StatefulWidget {
  final Function toggleView;
  LoginPage(this.toggleView);
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool isobsecure = true;
  String email = '', password = '', error = '';
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.blue[700],
      //   title: const Text('Login'),
      //   actions: [
      //     TextButton(
      //       onPressed: () {
      //         widget.toggleView();
      //       },
      //       child: const Text('Register',
      //           style: TextStyle(
      //             color: Colors.white,
      //           )),
      //     )
      //   ],
      // ),
      body: Stack(children: [
        Image.asset(
          'assets/loginpage.png',
          width: double.infinity,
          height: double.infinity,
          // scale: 0.6,
          fit: BoxFit.cover,
        ),
        Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 100,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
                  width: double.infinity,
                  child: const Text(
                    'Welcome',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                  // height: 40,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: TextFormField(
                    onChanged: (val) {
                      setState(() {
                        email = val;
                      });
                    },
                    validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      labelText: 'Email',
                      labelStyle: TextStyle(
                        color: Colors.black,
                      ),
                      hintText: 'Enter Email',
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: TextFormField(
                    obscureText: isobsecure,
                    onChanged: (val) {
                      setState(() {
                        password = val;
                      });
                    },
                    validator: (val) => val!.length < 6 ? 'Enter a password of atleast 6 char' : null,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        labelText: 'Password',
                        labelStyle: const TextStyle(
                          color: Colors.black,
                        ),
                        hintText: 'Enter Password',
                        fillColor: Colors.white,
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isobsecure = !isobsecure;
                            });
                          },
                          icon: isobsecure
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off),
                        )),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromARGB(255, 173, 9, 86),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        dynamic user =
                            _auth.signInWithEmailAndPassword(email, password);
                        if (user == null) {
                          setState(() {
                            error = 'Could not sign in with those credentials';
                          });
                        }
                      }
                    },
                    child: Text('Sign In'),
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromARGB(255, 173, 9, 86))),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account? ",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      ),
                    TextButton(
                      onPressed: (){
                        widget.toggleView();
                      },
                     child: Text(
                      'Register',
                      style: TextStyle(
                        textBaseline: TextBaseline.alphabetic,
                        ),
                      )
                     )
                  ],
                ),
                SizedBox(height: 12,),
                Text(error, style: TextStyle(color: Colors.red, fontSize: 14),),
              ],
            ),
          ),
        )
      ]),
    );
  }
}
