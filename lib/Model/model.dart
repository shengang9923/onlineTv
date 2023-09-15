// To parse this JSON data, do
//
//     final channelModel = channelModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<ChannelModel> channelModelFromJson(String str) => List<ChannelModel>.from(json.decode(str).map((x) => ChannelModel.fromJson(x)));

String channelModelToJson(List<ChannelModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChannelModel {
  final String channelName;
  final String link;
  final String source;
  final String thumbnail;

  ChannelModel({
    required this.channelName,
    required this.link,
    required this.source,
    required this.thumbnail,
  });

  ChannelModel copyWith({
    String? channelName,
    String? link,
    String? source,
    String? thumbnail,
  }) =>
      ChannelModel(
        channelName: channelName ?? this.channelName,
        link: link ?? this.link,
        source: source ?? this.source,
        thumbnail: thumbnail ?? this.thumbnail,
      );

  factory ChannelModel.fromJson(Map<String, dynamic> json) => ChannelModel(
    channelName: json["channel_name"],
    link: json["link"],
    source: json["source"],
    thumbnail: json["thumbnail"],
  );

  Map<String, dynamic> toJson() => {
    "channel_name": channelName,
    "link": link,
    "source": source,
    "thumbnail": thumbnail,
  };
}
