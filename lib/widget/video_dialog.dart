import 'package:YoutubePlayer/screen/video_screen.dart';
import 'package:flutter/material.dart';

Future<void> videoDialog({@required BuildContext context,
    @required String id}) async {
  return showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context){
      return Dialog(
        child: VideoScreen(channelTitle: '', videoId: id, videoTitle: '', uiState: false),
      );
    }
  );
}