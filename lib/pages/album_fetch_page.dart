import 'package:flutter/material.dart';
import 'package:flutter_application_1/album.dart';
import 'package:flutter_application_1/state/my_app_state.dart';
import 'package:provider/provider.dart';

class AlbumFetchPage extends StatefulWidget {
  const AlbumFetchPage({super.key});

  @override
  State<AlbumFetchPage> createState() => _AlbumFetchPageState();
}

class _AlbumFetchPageState extends State<AlbumFetchPage> {
  int currentIndex = 1;
  late Future<Album> futureAlbum;
  final textControl = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    textControl.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum(1);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    futureAlbum = fetchAlbum(currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    return Scaffold(
        body: Column(
      children: [
        Center(
          child: TextField(
            controller: textControl,
            decoration: InputDecoration(
                label: Text('Index:'),
                border: OutlineInputBorder(),
                hintText: 'Enter an album index.'),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        ElevatedButton(
          onPressed: () {
            appState.assignAlbum(futureAlbum, int.parse(textControl.text));
            currentIndex = int.parse(textControl.text);
          },
          child: Text('Fetch!'),
        ),
        SizedBox(
          height: 100,
        ),
        Center(
          child: Text(
            'Fetch result:',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
        Center(
          child: FutureBuilder<Album>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ElevatedButton(
                  onPressed: () {
                    appState.launchURL();
                  },
                  child: Text(snapshot.data!.title),
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ],
    ));
  }
}
