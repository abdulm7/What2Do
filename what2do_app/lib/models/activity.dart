// To parse this JSON data, do
//
//     final activity = activityFromJson(jsonString);

import 'dart:convert';

List<String> activityFromJson(String str) => List<String>.from(json.decode(str).map((x) => x));

String activityToJson(List<String> data) => json.encode(List<dynamic>.from(data.map((x) => x)));
