import 'package:audioplayer/detailaudiopage.dart';
import 'package:flutter/material.dart';
import 'myhomepage.dart';
import 'package:audio_service/audio_service.dart';
// import 'package:http/http.dart';


Future <void> main()  async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(MaterialApp(


    debugShowCheckedModeBanner: false,
    // initialRoute: 'myhomepage',
    home: AudioServiceWidget(child:MyHomePage()),
    routes: {

      "myhomepage": (context) => MyHomePage(),










    },
  ));
}