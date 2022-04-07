import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/screens/list_of_songs.dart';

void main(){
  runApp(MaterialApp(
    title: "Music app by Gopal",
    debugShowCheckedModeBanner: false,
    home: ListOfSongs(),
  ));
}