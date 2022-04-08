import 'dart:collection';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import '../models/song.dart';

class PlayerRoute extends StatefulWidget {
  late Song song;

  PlayerRoute(this.song, {Key? key}) : super(key: key);

  @override
  State<PlayerRoute> createState() => _PlayerRouteState();
}

class _PlayerRouteState extends State<PlayerRoute> {
  AudioPlayer player = AudioPlayer();
  Duration? _duration;
  Duration? _position;
  bool isPlay = false;

  _play() {
    if (isPlay) {
      player.pause();
    } else {
      player.play(widget.song.audio);
    }
    isPlay = !isPlay;
  }

  @override
  void initState() {
    super.initState();
    _initPlayerThings();
  }

  _initPlayerThings() {
    player.onDurationChanged.listen((duration) {
      this._duration = duration;
      setState(() {});
    });
    player.onAudioPositionChanged.listen((pos) {
      _position = pos;
      setState(() {});
    });
    player.onPlayerCompletion.listen((duration) {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.song.trackName),
      ),
      body: Column(
        children: [
          Container(
            height: size.height / 2,
            width: size.width,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.topRight,
                colors: [
                  Colors.yellow,
                  Colors.orange,
                  Colors.red,
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(80.0),
              child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage(widget.song.image))),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(widget.song.image),
                  )),
            ),
          ),
          Text(widget.song.artistName),
          Text(widget.song.trackName),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.skip_previous, size: 50),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(
                  Icons.play_arrow,
                  size: 50,
                  color: Colors.red,
                ),
                onPressed: () {
                  _play();
                },
              ),
              IconButton(
                icon: Icon(Icons.skip_next, size: 50),
                onPressed: () {},
              )
            ],
          ),
          Text("Current is ${_position?.inSeconds}"),
          Text('Duration is ${_duration == null ? 0.0 : _duration?.inSeconds}')
        ],
      ),
    );
  }
}
