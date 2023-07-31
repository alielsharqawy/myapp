// ignore_for_file: unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller=TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ignore: sized_box_for_whitespace
                Container(
                  height: 100,
                  width: 100,
                  child: Image.asset("assets/flutter.png"),
                ),
                const SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    controller: emailcontroller,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                    ),
                    validator: (value) {
                      if (value!.contains("@")) {
                        return null;
                      } else {
                        return "add vaild email";
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    controller: passwordcontroller,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                    ),
                    validator: (value) {
                      if (value!.length < 8) {
                        return 'Please enter Valid pasword';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                  ),
                  child: InkWell(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        bool result= await firebaselogin(emailcontroller.text,passwordcontroller.text);
                       if(result) {final SharedPreferences prefs = await SharedPreferences.getInstance();
                        await prefs.setString('email', emailcontroller.text);
                        // ignore: use_build_context_synchronously
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeScreeen()),
                        );}
                        else {
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('add valid account')),
                        );}
                      } 
                      
                    },
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(
                            12.0,
                          )),
                      child: const Center(
                        child: Text(
                          "Log In",
                          style: TextStyle(color: Colors.white, fontSize: 15.0),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Forget Password? No yawa. Tap me",
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                  ),
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(
                          12.0,
                        )),
                    child: const Center(
                      child: Text(
                        "No Account? Sign Up",
                        style: TextStyle(color: Colors.white, fontSize: 15.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future<bool> firebaselogin(String email,String password) async {
    try {
  final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: email,
    password: password,
  );
  if(credential.user !=null){
    return true;
  }
} on FirebaseAuthException catch (e) {
  if (e.code == 'user-not-found') {
    // ignore: avoid_print
    print('No user found for that email.');
  } else if (e.code == 'wrong-password') {
    // ignore: avoid_print
    print('Wrong password provided for that user.');
  }
}
 return false;
  }
 
}
