import 'dart:async';

import 'package:audioplayer/const.dart';
import 'package:audioplayer/myhomepage.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:audioplayer/appcolor.dart' as AppColors;
import 'audiofile.dart';
import 'package:audio_service/audio_service.dart';





class DetailAudioPage extends StatefulWidget {


  final booksData;
  final int index;
  const DetailAudioPage({ Key? key, this.booksData, required this.index}) : super(key: key);

  @override
  _DetailAudioPageState createState() => _DetailAudioPageState();
}
Duration _position = new Duration();







class _DetailAudioPageState extends State<DetailAudioPage> {
  late AudioPlayer advancedPlayer;








  @override
  void initState(){
    super.initState();
    advancedPlayer= AudioPlayer();
    advancedPlayer.onAudioPositionChanged.listen((e) {
      setState(() {
        _position =  e;
      });
    });
  }
  // int counter = 0;
  var _imageurl = 'https://source.unsplash.com/random/${variable.counter}';

Widget changeImage(){
    return Image.network(_imageurl,
    fit: BoxFit.cover,
    width: double.infinity,
    height: double.infinity,);
}

void _newimage(){
  setState(() {
    _imageurl = 'https://source.unsplash.com/random/${variable.counter}';
    variable.counter++;
  });

}


  @override
  Widget build(BuildContext context) {
    // Timer.periodic(Duration(seconds: 10), (timer) => _newimage());
    final double screenHeight=MediaQuery.of(context).size.height;
    final double screenWidth=MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: ()async{
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: ((context) => MyHomePage())));
return true;
      },
      child: Scaffold(
        backgroundColor: AppColors.audioBluishBackground,
        body: Stack(
          children: [
            Positioned(
                top:0,
                left: 0,
                right: 0,
                height: screenHeight/4,
                child: Container(
                    color:AppColors.audioBlueBackground

                )),
            Positioned(

                child: AppBar(
                  automaticallyImplyLeading: false,
                  // backgroundColor: Colors.transparent,
                  elevation: 0.0,
                )
            ),




            Positioned(
                left: 0,
                right: 0,
                top: screenHeight*0.65,
                height: screenHeight*0.35,
                child: Container(
                    decoration: BoxDecoration(

                      color:Colors.white,

                    ),
                    child:Column(
                      children: [
                        SizedBox(height: screenHeight*0.1,),

                        AudioFile(advancedPlayer:advancedPlayer, audioPath:this.widget.booksData[this.widget.index]["audio"],books: widget.booksData,i: widget.index),
                      ],
                    )

                )),

             Container(
              height: 550.0,
              child: Stack(
                children: [
                  Container(
                    child: changeImage()




                  ),
                  Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              Colors.black.withOpacity(0.4),
                              Colors.black
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 52.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.5),
                                    borderRadius:
                                    BorderRadius.circular(50.0)),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(2, 0, 0, 0),
                                    child: IconButton(
                                      icon:Icon(Icons.arrow_back_ios,),
                                      onPressed: (){

                                        _position = Duration();
                                        _newimage();
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(builder: ((context) => MyHomePage())));
                                        advancedPlayer.stop();



                                      },
                                      iconSize: 15,
                                    ),
                                  ),
                                )),
                            Column(
                              children: [
                                Text(
                                  "PLAYLIST",
                                  style: TextStyle(
                                      color: Colors.white54,
                                      fontFamily: "RajdhaniBold",
                                      fontSize: 25.0),

                                )
                              ],
                            ),
                            Icon(
                              Icons.playlist_add,
                              color: Colors.white54,
                              size: 35.0,
                            )
                          ],
                        ),
                        Spacer(),

                        Text((_position.toString().split(".")[0]),style: TextStyle(fontSize: 75,fontFamily: "RajdhaniLight",color: Colors.white),),
                          SizedBox(height: 150,),
                        Text(
                          this.widget.booksData[this.widget.index]["title"],
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: "RajdhaniSemibold",
                            fontSize: 45.0,
                          ),
                        ),
                        SizedBox(
                          height: 6.0,
                        ),
                        Text(
                          this.widget.booksData[this.widget.index]["text"],
                          style: TextStyle(
                              fontFamily: "RajdhaniMedium",
                              color: Colors.white.withOpacity(0.6),
                              fontSize: 22.0),
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
