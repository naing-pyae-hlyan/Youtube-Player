import 'dart:convert';
import 'package:YoutubePlayer/model/channel_model.dart';
import 'package:YoutubePlayer/model/video_model.dart';
import 'package:YoutubePlayer/network/http_service.dart';
import 'package:YoutubePlayer/utilities/data.dart';
import 'package:YoutubePlayer/utilities/keys.dart';
import 'package:flutter/material.dart';

const TAG = 'YoutubeApiService';

class YoutubeApiSercies {
  String _nextPageToken = '';

  Future<dynamic> fetchChannel({@required String channelId}) async {
    Map<String, String> params = {
      'part': 'snippet, contentDetails, statistics',
      'id': channelId,
      'key': YOUTUBE_API_KEY
    };
    Uri uri = Uri.https(baseUrl, '/youtube/v3/channels', params);

    var response;
    try {
      response = await getCall(tag: TAG, uri: uri, headers: jsonHeaders);
    } catch (e) {
      return errorResponse('No Connection!');
    }

    if (response == null) {
      return errorResponse('Connection Timeout!');
    }
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body)['items'][0];
      Channel channel = Channel.fromMap(data);

      // Fetch first batch of videos from uploads playlist
      channel.videos =
          await fetchVideosFromPlayList(playlistId: channel.uploadPlaylistId);
      return channel;
    } else {
      return json.decode(response.body)['error']['message'];
    }
  }

  Future<dynamic> fetchVideosFromPlayList({@required String playlistId}) async {
    Map<String, String> params = {
      'part': 'snippet',
      'playlistId': playlistId,
      'maxRewults': '8',
      'pageToken': _nextPageToken,
      'key': YOUTUBE_API_KEY
    };
    Uri uri = Uri.https(baseUrl, '/youtube/v3/playlistItems', params);

    var response;
    try {
      response = await getCall(tag: TAG, uri: uri, headers: jsonHeaders);
    } catch (e) {
      return 'No Connection!';
    }

    if (response == null) {
      return 'Connection Timeout!';
    }
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      _nextPageToken = data['nextPageToken'] ?? '';
      List<dynamic> videosJson = data['items'];

      // Fetch first 8 videos from uploads playlist
      List<Video> videos = [];
      videosJson.forEach((json) => videos.add(Video.fromMap(json['snippet'])));
      return videos;
    } else {
      return json.decode(response.body)['error']['message'];
    }
  }
}
