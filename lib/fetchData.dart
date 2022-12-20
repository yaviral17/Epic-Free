import 'dart:convert';

import 'package:epic_free/url.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
Future<Map<String, dynamic>> fetchGameData() async {
  var request = http.Request('GET',Uri.parse(mainApiUrl));
  request.headers.addAll(Apihader);
  http.StreamedResponse response = await request.send();
  if (response.statusCode >= 200 && response.statusCode < 300) {
    var jsonResponse = json.decode(await response.stream.bytesToString());
    return {"isSuccess":true, "ApplicationList":jsonResponse};
  } else {
    if(response.statusCode==401){
      return {"isSuccess":false,"ApplicationList":[],"isLoggedIn":false};
    }
    return {"isSuccess":false,"ApplicationList":[],"isLoggedIn":true};
  }
}