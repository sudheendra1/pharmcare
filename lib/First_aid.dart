

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class First_aid extends StatefulWidget {
  const First_aid({super.key, required this.info, required this.fname,required this.url,required this.steps});

  final info;
  final fname;
  final url;
  final steps;

  @override
  State<StatefulWidget> createState() {
    return _Firstaidstate();
  }
}

class _Firstaidstate extends State<First_aid> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    final videoid = YoutubePlayer.convertUrlToId(widget.url);
    _controller = YoutubePlayerController(
        initialVideoId: videoid!,
        flags: YoutubePlayerFlags(
          autoPlay: true,
        ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Basic info:"),
              SizedBox(height: 20,),
               Text(widget.info),
              SizedBox(height: 20,),
              YoutubePlayer(controller: _controller,
              showVideoProgressIndicator: true,
              bottomActions: [
                CurrentPosition(),
                ProgressBar(
                  isExpanded: true,
                  colors: ProgressBarColors(
                    playedColor: Colors.redAccent,
                    handleColor: Colors.red
                  ),
                ),
                RemainingDuration(),
FullScreenButton(),
                PlaybackSpeedButton(),

              ],),
              SizedBox(height: 20,),
              Text("Steps:"),
              SizedBox(height: 20,),
               Text(widget.steps),
            ],
          ),
        ),
      ),
    );
  }
}
