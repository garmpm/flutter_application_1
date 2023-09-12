import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/album.dart';
import 'package:url_launcher/url_launcher.dart';

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  var favorites = <WordPair>[];

  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }

  String encodeCaesar(String plaintext) {
    var ciphertext = '';
    List alphabet = [
      'A',
      'B',
      'C',
      'D',
      'E',
      'F',
      'G',
      'H',
      'I',
      'J',
      'K',
      'L',
      'M',
      'N',
      'O',
      'P',
      'Q',
      'R',
      'S',
      'T',
      'U',
      'V',
      'W',
      'X',
      'Y',
      'Z'
    ];
    for (var character in plaintext.runes) {
      if ((64 < character && character < 91) ||
          (96 < character && character < 123)) {
        var plainNumber = character + 1;
        var cipherNumber = (plainNumber + 3) % 26;
        ciphertext += alphabet[cipherNumber];
      } else {
        ciphertext += String.fromCharCode(character);
      }
    }
    notifyListeners();
    return ciphertext;
  }

  launchURL() async {
    const url = 'https://www.youtube.com/watch?v=dQw4w9WgXcQ';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  void assignAlbum(Future<Album> futureAlbum, int index) {
    futureAlbum = fetchAlbum(index);
    notifyListeners();
  }
}
