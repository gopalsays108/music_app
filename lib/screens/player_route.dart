import 'package:flutter/material.dart';
import '../models/song.dart';

class PlayerRoute extends StatefulWidget {
  late Song song;

  PlayerRoute(this.song, {Key? key}) : super(key: key);

  @override
  State<PlayerRoute> createState() => _PlayerRouteState();
}

class _PlayerRouteState extends State<PlayerRoute> {
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
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.topRight,
                    colors: [
                  Colors.yellow,
                  Colors.orange,
                  Colors.red,
                ])),
            child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage(widget.song.image))),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(widget.song.image),
                )),
          ),
        ],
      ),
    );
  }
}
