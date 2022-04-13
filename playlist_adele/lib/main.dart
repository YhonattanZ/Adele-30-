import 'package:flutter/material.dart';
import 'package:playlist_adele/play_page.dart';

import 'models/lista_canciones.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: Playlist());
  }
}

class Playlist extends StatefulWidget {
  const Playlist({Key? key}) : super(key: key);

  @override
  _PlaylistState createState() => _PlaylistState();
}

class _PlaylistState extends State<Playlist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff191816),
      body: Column(
        children: <Widget>[
          Stack(children: <Widget>[
            imagenFondo(context),
            appBarPersonalizado(),
            description(context),
          ]),
          Expanded(
            child: ListView(
                children: canciones
                    .asMap()
                    .map((index, cancion) =>
                        MapEntry(index, itemlist(context, cancion, index + 1)))
                    .values
                    .toList()),
          ),
        ],
      ),
    );
  }
}

Widget imagenFondo(BuildContext context) {
  return Container(
    height: MediaQuery.of(context).size.height / 2,
    decoration: BoxDecoration(
        image: DecorationImage(
            image: const AssetImage('assets/images/30.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.90), BlendMode.dstATop))),
  );
}

Widget appBarPersonalizado() {
  return Container(
      height: 50,
      child: Row(
        children: <Widget>[
          const Padding(padding: EdgeInsets.symmetric(horizontal: 2)),
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.arrow_back, color: Colors.white, size: 25))
        ],
      ));
}

Widget description(BuildContext context) {
  return Positioned(
    top: MediaQuery.of(context).size.height / 3,
    child: Container(
        padding: const EdgeInsets.only(left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // ignore: prefer_const_literals_to_create_immutables
          children: <Widget>[
            const Text('30',
                style: TextStyle(fontSize: 35, color: Colors.white)),
            const Text('Adele',
                style: TextStyle(fontSize: 15, color: Colors.white)),
            Text('Álbum - 2021',
                style: TextStyle(fontSize: 15, color: Colors.grey.shade300)),
            Row(children: <Widget>[
              IconButton(
                  padding: const EdgeInsets.only(bottom: 10),
                  onPressed: () {},
                  icon: const Icon(Icons.favorite, color: Color(0xff1ed760))),
              IconButton(
                  padding: const EdgeInsets.only(bottom: 10),
                  onPressed: () {},
                  icon: const Icon(Icons.more_vert, color: Colors.white70)),
              IconButton(
                  padding: const EdgeInsets.only(bottom: 10, left: 190),
                  onPressed: () {},
                  icon: const Icon(Icons.play_circle_rounded,
                      color: Color(0xff1ed760), size: 40)),
            ])
          ],
        )),
  );
}

Widget itemlist(BuildContext context, Cancion cancion, int index) {
  return InkWell(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                Player(canciones: canciones, index: index - 1),
          ));
    },
    child: Container(
        height: 60,
        child: Row(
          children: <Widget>[
            const SizedBox(width: 10),
            Text(index.toString().padLeft(2, '0'),
                style: const TextStyle(color: Colors.white70)),
            const SizedBox(width: 10),
            Container(
              height: 30,
              width: 30,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: Image.asset(cancion.image),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Padding(padding: EdgeInsets.only(top: 14)),
                Text(cancion.title,
                    style: const TextStyle(color: Colors.white70)),
                Text(cancion.artist,
                    style: const TextStyle(color: Colors.white70)),
              ],
            ),
            const Spacer(),
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.more_vert, color: Colors.white70))
          ],
        )),
  );
}
