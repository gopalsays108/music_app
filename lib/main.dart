import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:music_app/config/themes/color_theme.dart';
import '/screens/list_of_songs.dart';

void main() async {
  await dotenv.load(fileName: ".env");

  runApp(MaterialApp(
    title: "Music app by Gopal",
    theme: getColorTheme(),
    debugShowCheckedModeBanner: false,
    home: ListOfSongs(),
  ));
}