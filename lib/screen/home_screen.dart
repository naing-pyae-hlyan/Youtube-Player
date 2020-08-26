import 'package:YoutubePlayer/model/channel_model.dart';
import 'package:YoutubePlayer/model/video_model.dart';
import 'package:YoutubePlayer/providers/youtube_api_provider.dart';
import 'package:YoutubePlayer/screen/video_screen.dart';
import 'package:YoutubePlayer/widget/subscribe_channel.dart';
import 'package:YoutubePlayer/widget/video_dialog.dart';
import 'package:YoutubePlayer/widget/video_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Youtube Player'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: VideoSliverList(),
    );
  }
}

class VideoSliverList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final videoProvider =
        Provider.of<YoutubeApiProvider>(context, listen: false);
    return Container(
      child: FutureBuilder<dynamic>(
        future:
            videoProvider.fetchChannel(channelId: 'UC6Dy0rQ6zDnQuHQ1EeErGUA'),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Container();
          }
          if (snapshot.hasData) {
            if (snapshot.data is Channel) {
              Channel channel = snapshot.data;

              return ListView.builder(
                  itemCount: channel.videos.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return SubscribeChannel(channel: snapshot.data);
                    }
                    Video video = channel.videos[index - 1];
                    return VideoList(
                      video: video,
                      onTap: (value) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => VideoScreen(
                                      channelTitle: value.channelTitle,
                                      videoTitle: value.videoTitle,
                                      videoId: value.videoId,
                                      uiState: true,
                                    )));
                      },
                      onLongPress: (value) {
                        videoDialog(context: context, id: value.videoId);
                      },
                    );
                  });
            }
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
