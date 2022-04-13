import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

import 'models/lista_canciones.dart';

// ignore: must_be_immutable
class Player extends StatefulWidget {
  final List<Cancion> canciones;
  final int index;

  const Player({
    Key? key,
    required this.canciones,
    required this.index,
  }) : super(key: key);

  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  final AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();
  double screenHeight = 0;
  double screenWidth = 0;
  final Color mainColor = Color(0xff00A18F);
  final Color inactiveColor = Color(0xffDAF7A6);

  List<Audio> audioList = [
    Audio('assets/songs/Strangers By Nature.mp3',
        metas: Metas(title: 'Strangers By Nature', artist: 'Adele')),
    Audio('assets/songs/Easy On Me.mp3',
        metas: Metas(title: 'Easy On Me', artist: 'Adele')),
    Audio('assets/songs/My Little Love.mp3',
        metas: Metas(title: 'My Little Love', artist: 'Adele')),
    Audio('assets/songs/Cry Your Heart Out.mp3',
        metas: Metas(title: 'Cry Your Heart Out', artist: 'Adele')),
    Audio('assets/songs/Oh My God.mp3',
        metas: Metas(title: 'Oh My God', artist: 'Adele')),
    Audio('assets/songs/Can I Get It.mp3',
        metas: Metas(title: 'Can I Get It', artist: 'Adele')),
    Audio('assets/songs/I Drink Wine.mp3',
        metas: Metas(title: 'I Drink Wine', artist: 'Adele')),
    Audio('assets/songs/Woman Like Me.mp3',
        metas: Metas(title: 'Woman Like Me', artist: 'Adele')),
    Audio('assets/songs/To Be Loved.mp3',
        metas: Metas(title: 'To Be Loved', artist: 'Adele')),
    Audio('assets/songs/Love Is A Game.mp3',
        metas: Metas(title: 'Love Is A Game', artist: 'Adele')),
  ];

  @override
  void initState() {
    super.initState();
    setupPlaylist();
  }

  void setupPlaylist() async {
    await audioPlayer.open(Playlist(audios: audioList),
        autoStart: false, loopMode: LoopMode.playlist);
  }

  @override
  void dispose() {
    super.dispose();
    audioPlayer.dispose();
  }

  void seekToSecond(int second) {
    Duration newDuration = Duration(seconds: second);

    seekToSecond(second);
  }

  playMusic() async {
    await audioPlayer.play();
  }

  pauseMusic() async {
    await audioPlayer.pause();
  }

  skipPrevious() async {
    await audioPlayer.previous();
  }

  skipNext() async {
    await audioPlayer.next();
  }

  double _barvalue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: audioPlayer.builderRealtimePlayingInfos(
        builder: (context, realtimePlayingInfos) {
      if (realtimePlayingInfos != null) {
        return Stack(
          children: <Widget>[
            imagenFondo(),
            Column(
              children: <Widget>[
                customappbar(),
                const SizedBox(height: 30),
                imagenalbum(),
                const SizedBox(height: 40),
                songtitle(realtimePlayingInfos),
                progressbar(realtimePlayingInfos),
                SizedBox(height: 10),
                playopause(realtimePlayingInfos),
              ],
            ),
          ],
        );
      } else {
        return Column();
      }
    }));
  }

  Widget imagenFondo() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color(0xff514d42),
            Color(0xff191816),
          ],
        ),
      ),
    );
  }

  Widget customappbar() {
    return Container(
      padding: const EdgeInsets.only(top: 15),
      height: 90,
      child: Row(
        children: <Widget>[
          Container(
            height: 35,
            width: 35,
            child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.keyboard_arrow_down_sharp,
                    size: 40, color: Colors.white70)),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 30, top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      Text('REPRODUCIENDO DESDE ÁLBUM',
                          style: TextStyle(color: Colors.white54)),
                      Text('30',
                          style:
                              TextStyle(color: Colors.white70, fontSize: 18)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget imagenalbum() {
    return Container(
      height: 320,
      width: 300,
      child: Image.asset('assets/images/30.jpg', fit: BoxFit.cover),
    );
  }

  Widget songtitle(RealtimePlayingInfos realtimePlayingInfos) {
    return Container(
      height: 70,
      child: Column(
        children: <Widget>[
          Text(realtimePlayingInfos.current!.audio.audio.metas.title!,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          Text(widget.canciones[widget.index].artist,
              style: const TextStyle(color: Colors.white70, fontSize: 17)),
        ],
      ),
    );
  }

  Widget progressbar(RealtimePlayingInfos realtimePlayingInfos) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Column(children: <Widget>[
        Slider(
          min: 0.0,
          max: realtimePlayingInfos.current!.audio.duration.inSeconds
                  .toDouble() -
              0.01,
          value: realtimePlayingInfos.currentPosition.inSeconds.toDouble(),
          activeColor: Colors.white,
          inactiveColor: Colors.white24,
          onChanged: (double value) {
            setState(() {
              audioPlayer.seek(Duration(seconds: value.toInt()));
              value = value;
            });
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: <Widget>[
              Text(realtimePlayingInfos.currentPosition.inSeconds.toString(),
                  style: TextStyle(color: Colors.white54)),
              Spacer(),
              Text(
                  realtimePlayingInfos.current!.audio.duration.inSeconds
                      .toString(),
                  style: const TextStyle(color: Colors.white54)),
            ],
          ),
        ),
      ]),
    );
  }

  Widget playopause(RealtimePlayingInfos realtimePlayingInfos) {
    return Container(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
          IconButton(
              onPressed: () => audioPlayer.previous(),
              icon: Icon(Icons.skip_previous_rounded),
              iconSize: 40,
              color: Colors.white),
          IconButton(
              onPressed: () => audioPlayer.playOrPause(),
              icon: Icon(realtimePlayingInfos.isPlaying
                  ? Icons.pause_circle_filled
                  : Icons.play_circle_fill_rounded),
              iconSize: 40,
              color: Colors.white),
          IconButton(
              onPressed: () => audioPlayer.next(),
              icon: Icon(Icons.skip_next_rounded),
              iconSize: 40,
              color: Colors.white),
        ]));
  }

  Widget botones() {
    return Container(
        height: 50,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.favorite,
                    color: Color(0xff1ed760),
                  )),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.skip_previous,
                    color: Colors.white,
                    size: 30,
                  )),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.play_circle_fill_rounded),
                    iconSize: 40,
                    color: Colors.white),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.skip_next,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.arrow_drop_down_circle_outlined,
                    color: Colors.white),
              ),
            ]));
  }
}
