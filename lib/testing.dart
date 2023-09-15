import 'dart:convert';

void main() {
  List cList = [
    {
      "channel_name": "ABC News",
      "link":
          "https://abc-iview-mediapackagestreams-2.akamaized.net/out/v1/6e1cc6d25ec0480ea099a5399d73bc4b/index.m3u8",
      "source": "iptv",
      "thumbnail":
          "https://upload.wikimedia.org/wikipedia/commons/thumb/2/2a/ABC_News_logo_2021.svg/1200px-ABC_News_logo_2021.svg.png"
    },
    {
      "channel_name": "Arirang",
      "link":
          "https://abc-iview-mediapackagestreams-2.akamaized.net/out/v1/6e1cc6d25ec0480ea099a5399d73bc4b/index.m3u8",
      "source": "iptv",
      "thumbnail":
          "https://upload.wikimedia.org/wikipedia/commons/thumb/2/2a/ABC_News_logo_2021.svg/1200px-ABC_News_logo_2021.svg.png"
    }
  ];
 // print(cList.toString());
 //cList.removeWhere((element) => element['channel_name'] == "ABC News");
  bool exists = cList.any((jsonObject) => jsonObject['channel_name'] == "ABC Newss");
  print(exists);
}
