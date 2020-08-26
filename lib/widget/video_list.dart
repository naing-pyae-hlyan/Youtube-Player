import 'package:YoutubePlayer/model/video_callback_model.dart';
import 'package:YoutubePlayer/model/video_model.dart';
import 'package:flutter/material.dart';

class VideoList extends StatelessWidget {
  final Video video;
  final ValueChanged<VideoCallBackModel> onTap;
  final ValueChanged<VideoCallBackModel> onLongPress;

  VideoList(
      {@required this.video, @required this.onTap, @required this.onLongPress});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        onLongPress(VideoCallBackModel(videoId: video.id));
      },
      onTap: () {
        onTap(VideoCallBackModel(
            channelTitle: video.channelTitle,
            videoTitle: video.title,
            videoId: video.id));
      },
      child: Container(
        margin: const EdgeInsets.only(left: 12.0, top: 10.0, right: 12.0),
        padding: const EdgeInsets.all(20.0),
        height: 140.0,
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
              color: Colors.black12, offset: Offset(0, 1), blurRadius: 6.0)
        ]),
        child: Row(
          children: [
            Image(
              width: 150.0,
              image: NetworkImage(video.thumbnailUrl),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Text(
                video.title,
                style: TextStyle(color: Colors.black, fontSize: 18.0),
              ),
            )
          ],
        ),
      ),
    );
  }
}
