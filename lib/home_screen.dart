import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreeen extends StatefulWidget {
  const HomeScreeen({ Key? key,}) : super(key: key);

  @override
  State<HomeScreeen> createState() => _HomeScreeenState();
}

class _HomeScreeenState extends State<HomeScreeen> {
  String email = "";
  Future<void> getemail () async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    email = prefs.getString('email')??"no email";  
     setState((){}); 
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getemail();
   
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: Text(
          "Welcom $email",
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
      ),
    );
  }
}
