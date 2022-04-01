import 'package:audioplayer/const.dart';
import 'package:audioplayer/detailaudiopage.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:audio_service/audio_service.dart';






class AudioFile extends StatefulWidget {
  final AudioPlayer advancedPlayer;
  final String audioPath;
  var books;
  var i;

  AudioFile(
      {Key? key,
      required this.advancedPlayer,
      required this.audioPath,
      required this.i,
      required this.books})
      : super(key: key);

  @override
  _AudioFileState createState() => _AudioFileState();
}

class _AudioFileState extends State<AudioFile> {
  Duration _duration = new Duration();
  Duration _position = new Duration();
  bool isPlaying = false;
  bool isPaused = false;
  bool isRepeat = false;
  bool isLike = false;
  int count = 0;

  Color color = Colors.black;

  List<IconData> _icons = [
    Icons.play_circle_rounded,
    Icons.pause_circle_rounded,
  ];

  @override
  void initState() {
    super.initState();

    if (variable.Likecheck.isNotEmpty) {
      setState(() {
        isLike = variable.Likecheck[widget.i];
      });
    } else {
      for (int i = 0; i < widget.books.length; i++) {
        variable.Likecheck.insert(i, false);
      }
    }

    this.widget.advancedPlayer.onDurationChanged.listen((d) {
      setState(() {
        _duration = d;
      });
    });
    this.widget.advancedPlayer.onAudioPositionChanged.listen((p) {
      setState(() {
        _position = p;
      });
      if (_position.toString().split(".")[0] ==
          _duration.toString().split(".")[0]) {
        count++;
        setState(() {});

        if (count == 1) {
          showDialog(
            context: context,
            builder: (BuildContext context) => _buildPopupDialog(context),
          );
        }
      }
      // print('_position is ${_position}');
    });

    this.widget.advancedPlayer.setUrl(this.widget.audioPath);
    this.widget.advancedPlayer.onPlayerCompletion.listen((event) {
      setState(() {
        _position = Duration(seconds: 0);
        count = 0;
        if (isRepeat == true) {
          isPlaying = true;
        } else {
          isPlaying = false;
          isRepeat = false;
        }
      });
    });
  }

  Widget _buildPopupDialog(BuildContext context) {
    return new AlertDialog(
      title: const Text(
        'Song is Completed',
        style: TextStyle(fontFamily: "GilmerBold", color: Colors.black),
      ),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Text("Hello"),
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            if (widget.i + 1 < widget.books.length) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailAudioPage(
                          booksData: widget.books, index: widget.i + 1)));
            }
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('OK',
              style: TextStyle(fontFamily: "GilmerBold", color: Colors.white)),
          color: Colors.black,
        ),
      ],
    );
  }

  Widget _buildPopupDialoge(BuildContext context) {
    return new AlertDialog(
      title: const Text(
        'No Next Track Available',
        style: TextStyle(fontFamily: "GilmerBold", color: Colors.black),
      ),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Text("Hello"),
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('OK',
              style: TextStyle(fontFamily: "GilmerBold", color: Colors.white)),
          color: Colors.black,
        ),
      ],
    );
  }

  Widget _buildPopupDialogee(BuildContext context) {
    return new AlertDialog(
      title: const Text(
        'No Previous Track Available',
        style: TextStyle(fontFamily: "GilmerBold", color: Colors.black),
      ),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Text("Hello"),
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('OK',
              style: TextStyle(fontFamily: "GilmerBold", color: Colors.white)),
          color: Colors.black,
        ),
      ],
    );
  }

  Widget btnStart() {
    return IconButton(
      padding: const EdgeInsets.only(bottom: 10),
      icon: isPlaying == false
          ? Icon(_icons[0], size: 50, color: Colors.black)
          : Icon(_icons[1], size: 50, color: Colors.black54),
      onPressed: () {
        if (isPlaying == false) {
          this.widget.advancedPlayer.play(this.widget.audioPath);
          this.widget.advancedPlayer.setPlaybackRate(1);
          setState(() {
            isPlaying = true;
          });
        } else if (isPlaying == true) {
          this.widget.advancedPlayer.pause();
          setState(() {
            isPlaying = false;
          });
        }
        // this.widget.advancedPlayer.setPlaybackRate(1);
      },
    );
  }

  Widget btnFast() {
    return IconButton(
      icon: Icon(Icons.fast_forward_rounded),
      iconSize: 35,
      // color: color,
      onPressed: () {
        this.widget.advancedPlayer.setPlaybackRate(1.5);
      },
    );
  }

  Widget btnSlow() {
    return IconButton(
      icon: Icon(Icons.fast_rewind_rounded),
      iconSize: 35,
      // color: color,
      onPressed: () {
        // this.widget.advancedPlayer.setPlaybackRate( 1);
        this.widget.advancedPlayer.setPlaybackRate(0.5);
      },
    );
  }

  Widget btnnext() {
    return IconButton(
      icon: Icon(Icons.skip_next_rounded),
      iconSize: 35,
      // color: color,
      onPressed: () {
        if (widget.i + 1 < widget.books.length) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailAudioPage(
                      booksData: widget.books, index: widget.i + 1)));
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) => _buildPopupDialoge(context),
          );
        }
      },
    );
  }

  Widget btnreverse() {
    return IconButton(
        icon: Icon(Icons.skip_previous_rounded),
        iconSize: 35,
        // color: color,
        onPressed: () {
          {
            if (widget.i < 1) {
              showDialog(
                context: context,
                builder: (BuildContext context) => _buildPopupDialogee(context),
              );
            } else {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailAudioPage(
                          booksData: widget.books, index: widget.i - 1)));
            }
          }
        });
  }

  Widget btnLoop() {
    return IconButton(
      icon: Icon(Icons.loop_rounded),
      // color: color,
      iconSize: 25, onPressed: () {},
    );
  }

  Widget btnRepeat() {
    return IconButton(
      icon: Icon(Icons.repeat_rounded),
      color: color,
      iconSize: 25.0,
      onPressed: () {
        if (isRepeat == false) {
          this.widget.advancedPlayer.setReleaseMode(ReleaseMode.LOOP);
          setState(() {
            isRepeat = true;
            color = Colors.blue;
          });
        } else if (isRepeat == true) {
          this.widget.advancedPlayer.setReleaseMode(ReleaseMode.RELEASE);
          color = Colors.black;
          isRepeat = false;
        }
      },
    );
  }

  Widget btnFavourite() {
    return IconButton(
      iconSize: 28,
      onPressed: () {
        setState(() {
          isLike = !isLike;
        });
        // print('is like is $isLike ${widget.i}');
        variable.Likecheck.insert(widget.i, isLike);
      },
      icon: isLike
          ? Icon(Icons.favorite_rounded)
          : Icon(Icons.favorite_outline_rounded),
      color: isLike ? Colors.pinkAccent : Colors.black,
    );
  }

  Widget slider() {
    return Slider(
        activeColor: Colors.green,
        inactiveColor: Colors.grey,
        value: _position.inSeconds.toDouble(),
        min: 0.0,
        max: _duration.inSeconds.toDouble(),
        onChanged: (double value) {
          setState(() {
            changeToSecond(value.toInt());
            value = value;
          });
        });
  }

  void changeToSecond(int second) {
    Duration newDuration = Duration(seconds: second);
    print("duration is $newDuration");
    this.widget.advancedPlayer.seek(newDuration);
  }



  Widget loadAsset() {
    return Container(
      child: Row(


          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            btnSlow(),

            btnreverse(),

            btnStart(),

            btnnext(),

            btnFast(),

          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
            children: [

              Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                   child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                       Text(
                               _position.toString().split(".")[0],
                                    style: TextStyle(fontSize: 20, fontFamily: "RajdhaniBold"),
                       ),

                       Text(
                               _duration.toString().split(".")[0],
                                     style: TextStyle(fontSize: 20, fontFamily: "RajdhaniBold"),
                       ),
            ],
          ),
        ),


                slider(),


                loadAsset(),


           SizedBox(height: 10,),


          SingleChildScrollView(
             child: Center(
                child: Row(


                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,

                     children: [

                               btnRepeat(),

                               btnFavourite(),

                               btnLoop()

              ],
            ),
          ),
        )
      ],
    ));
  }
}

