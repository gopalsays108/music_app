import 'dart:convert' as jsonconvertor;
import 'package:http/http.dart' as http;
import '../models/song.dart';

// Object to JSon = serialization
// Json to Object = Deserialization

class ApiClients {
  void getSongs(Function successCallBack, Function failCallBack, String url) {
    Future<http.Response> future = http.get(Uri.parse(url));
    future.then((response) {
      String json = response.body;

      Map<String, dynamic> map = jsonconvertor.jsonDecode(json);

      List<dynamic> list = map['results'];

      print("list  is is $list");
      List<Song> songs = list.map((songMap) => Song.fromJson(songMap)).toList();
      print("songgs is $songs");
      successCallBack(songs);
      // List<Song> songs = list
      //     .map((element) => Song(
      //             artistName: element['artistName'],
      //             trackName: element['trackName'],
      //             image: element['networkUrl100'],
      //             audio: element['previewUrl'])
      //         //  Traverse the list and get one by one map and convert map into song object and song object store in a song list.
      //         )
      //     .toList();
      print('map is $map and map type is ${map.runtimeType}');
      print("JSON $json");
      print(json.runtimeType);
    }).catchError((erro) {
      failCallBack(erro);
    });
  }
}
