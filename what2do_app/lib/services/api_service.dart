import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:what2do_app/models/activity.dart';

class ApiService{
  Future<List<String>?> getActivities(occupation, goal) async{
    var client = http.Client();

    var url = 'https://udbmcm3zu0.execute-api.ca-central-1.amazonaws.com/default/whattodo?occupation=$occupation&goal=$goal';
    final uri = Uri.parse(url);

    var res = await client.get(uri);

    if (res.statusCode == 200){
      var json = res.body;
      return activityFromJson(json);
    }
  }
}