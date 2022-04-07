import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:music_app/utils/api_clients.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:music_app/utils/network_client.dart';
import 'package:shake/shake.dart';
import '../models/song.dart';

class ListOfSongs extends StatefulWidget {
  const ListOfSongs({Key? key}) : super(key: key);

  @override
  State<ListOfSongs> createState() => _ListOfSongsState();
}

class _ListOfSongsState extends State<ListOfSongs> {
  final int limit = 20;
  final String staticUrl =
      "https://itunes.apple.com/search?term=sonu+nigam&limit=20";
  final String baseUrl = "https://itunes.apple.com/search?term=";

  final AudioPlayer audioPlayer = AudioPlayer();
  final TextEditingController _controllerSearch = TextEditingController();
  final ApiClients clients = ApiClients();
  final NetworkClient _networkClient = NetworkClient();

  IconData icon = Icons.play_arrow;
  List<Song> songs = [];
  dynamic error;
  bool isPlaying = false;
  int playingIndex = -1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    clients.getSongs(getSongsList, getSongsError, staticUrl);
    ShakeDetector shakeDetector = ShakeDetector.autoStart(
        onPhoneShake: () {
          print("shakeddddds");
          _changeSong();
        },
        shakeThresholdGravity: 2);
    // shakeDetector.startListening();
  }

  getSongsList(List<Song> songs) {
    this.songs = songs;
    setState(() {});
  }

  getSongsError(dynamic error) {
    this.error = error;
    setState(() {});
  }

  _changeSong() async {
    int nextTrack = playingIndex + 1;
    if(playingIndex == limit-1){
      playingIndex = 0;
      nextTrack = 0;
    }

    await audioPlayer.play(songs[nextTrack].audio);
    String message = "${songs[nextTrack].trackName} is playing";
    _createFlushBar(message, 3, context);
    playingIndex = nextTrack;
    isPlaying = true;
    setState(() {

    });

  }

  Center _showLoading() {
    return const Center(child: CircularProgressIndicator());
  }

  void _getNewSongs() {
    String str = _controllerSearch.text.toString();
    if (str.isNotEmpty) {
      String url = _networkClient.createUrlWithSearchTerm(baseUrl, str, limit);
      songs.clear();
      audioPlayer.stop();
      isPlaying = false;
      playingIndex = -1;
      clients.getSongs(getSongsList, getSongsError, url);
    }
  }

  _playSong(int index, String songName) async {
    print("Index is $index");
    if (!isPlaying || (isPlaying && playingIndex != index)) {
      playingIndex = index;
      isPlaying = true;
      icon = Icons.pause;
      String message = "$songName is playing";
      _createFlushBar(message, 3, context);
      await audioPlayer.play(songs[index].audio);
    } else {
      playingIndex = -1;
      isPlaying = false;
      icon = Icons.play_arrow;
      String message = "$songName is paused";
      _createFlushBar(message, 3, context);
      await audioPlayer.pause();
    }

    setState(() {});
  }

  _createFlushBar(String message, int seconds, BuildContext context) {
    Flushbar(
      message: message,
      duration: Duration(seconds: seconds),
    ).show(context);
  }

  _setIcon(double sizes, Color colors, IconData icon) {
    return Icon(
      icon,
      size: sizes,
      color: colors,
    );
  }

  ///Alternative for recycler view
  ListView _printSongs() {
    print("as");
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: Image.network(songs[index].image),
          title: Text(songs[index].trackName),
          subtitle: Text(songs[index].artistName),
          trailing: IconButton(
            onPressed: () => _playSong(index, songs[index].trackName),
            icon: index == playingIndex
                ? _setIcon(25, Colors.green, Icons.pause)
                : _setIcon(25, Colors.red, Icons.play_arrow_sharp),
          ),
        );
      },
      itemCount: songs.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Songs'),
      ),
      body: Container(
        //Alternative for recycler view
        child: Column(
          children: [
            Container(
              height: 45,
              margin: EdgeInsets.all(8),
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: TextField(
                        controller: _controllerSearch,
                        onSubmitted: (_) => _getNewSongs(),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter the artist name',
                          label: Text('Artist name'),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: _getNewSongs,
                      icon: Icon(
                        Icons.search_outlined,
                        color: Colors.red,
                      ))
                ],
              ),
            ),
            Expanded(
              child: Container(
                child: this.songs.length == 0 ? _showLoading() : _printSongs(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
