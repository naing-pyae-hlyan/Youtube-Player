import 'package:YoutubePlayer/network/youtube_api_services.dart';
import 'package:flutter/foundation.dart';

class YoutubeApiProvider with ChangeNotifier {
  Future<dynamic> fetchChannel({@required String channelId}) {
    return YoutubeApiSercies().fetchChannel(channelId: channelId);
  }
}
