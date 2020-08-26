import 'dart:io';
import 'package:YoutubePlayer/utilities/log.dart';
import 'package:http/http.dart' as http;

const TYPE_APPLICATION_JSON = 'application/json';
const Map<String, String> jsonHeaders = {
  HttpHeaders.contentTypeHeader: TYPE_APPLICATION_JSON,
  HttpHeaders.acceptHeader: TYPE_APPLICATION_JSON
};
const Duration DEFAULT_TIME_OUT_DURATION = Duration(seconds: 30);

Future<http.Response> getCall(
    {String tag,
    Uri uri,
    Map<String, String> headers = jsonHeaders,
    Duration timeoutDuration = DEFAULT_TIME_OUT_DURATION}) async {
  final response = await http
      .get(uri, headers: headers)
      .timeout(timeoutDuration, onTimeout: () {
    myLog(
        tag,
        '\nRequest URL: $uri'
        '\nRequest Method: GET'
        '\nRequest Headers: ${headers.toString()}'
        '\nRequest Time: $uri');
    return null;
  });

  return response;
}
