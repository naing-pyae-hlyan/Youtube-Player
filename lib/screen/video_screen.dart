import 'package:YoutubePlayer/model/channel_model.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoScreen extends StatefulWidget {
  final String channelTitle, videoTitle, videoId;
  final bool uiState;

  VideoScreen(
      {@required this.channelTitle,
      @required this.videoTitle,
      @required this.videoId,
      @required this.uiState});

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
        initialVideoId: widget.videoId,
        flags: YoutubePlayerFlags(mute: false, autoPlay: true));
  }

  @override
  Widget build(BuildContext context) {
    return widget.uiState ? _fullPage(context) : _dialogPage(context);
  }

  Widget _fullPage(BuildContext context) {
    return Material(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
            sliver: SliverList(
                delegate: SliverChildListDelegate([
              YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
                onReady: () {
                  print('Player is ready.');
                },
              ),
              const SizedBox(height: 10.0),
              Text(
                widget.videoTitle,
                style: TextStyle(color: Colors.black, fontSize: 18.0),
              ),
            ])),
          )
        ],
      ),
    );
  }

  Widget _dialogPage(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(2.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              onReady: () {
                print('Player is ready.');
              },
            )
          ],
        ),
      ),
    );
  }
}
