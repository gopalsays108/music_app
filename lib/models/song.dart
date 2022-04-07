class Song {
  late String artistName; //title of the song
  late String trackName;
  late String image;
  late String audio; //Url of image

  Song({required this.artistName,
    required this.trackName,
    required this.audio,
    required this.image});

  Song.fromJson(Map<String, dynamic> map) {
    artistName = map['artistName'];
    trackName = map['trackName'];
    image = map['artworkUrl100'];
    audio = map['previewUrl'];
  }

  Map<String, dynamic> toJson() {
    return {
      "artistName": artistName,
      "trackName": trackName,
      "networkUrl100": image,
      "previewUrl": audio,
    };
  }

  @override
  String toString() {
    return 'Artist name: $artistName, TrackName: $trackName';
  }
}
