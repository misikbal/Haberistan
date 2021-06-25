import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:haberistan/viws/home.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(home:MyApp()));
}

// class MyApp extends StatelessWidget {
  
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
      
//       // title: 'Haberistan',
//       // debugShowCheckedModeBanner: false,
//       // theme: ThemeData(
//       //   primaryColor: Colors.white,
//       // ),
//       // home: Home(),
//     );
//   }
// }

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override 
  void initState(){
    super.initState();
    Future.delayed(Duration(seconds:3),
    (){
      Navigator.push(context,MaterialPageRoute(builder: (context)=>Home()));
    }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        decoration:BoxDecoration(
          image:DecorationImage(
            image: AssetImage("/assets/images/acilis.jpg"),fit:BoxFit.cover
          )
        )
      ),
    );
  }
}



